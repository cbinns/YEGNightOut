{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE LambdaCase        #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeFamilies      #-}
{-# LANGUAGE TypeOperators     #-}

module App where

import           Control.Monad.IO.Class (liftIO)
import           Control.Monad.Logger (runStderrLoggingT)
import           Database.Persist.Sqlite ( ConnectionPool, createSqlitePool
                                         , runSqlPool, runSqlPersistMPool
                                         , runMigration, selectFirst, selectList, (==.)
                                         , insert, entityVal, rawSql, PersistValue(..))
import           Data.String.Conversions (cs)
import           Data.Text (Text, pack, unpack)
import           Network.Wai.Handler.Warp as Warp

import           Servant

import           Api
import           Models
import           OtherModels

server :: ConnectionPool -> Server Api
server pool = restaurantAddH
         :<|> restaurantGetByNameH
         :<|> restaurantGetByAddressH
         :<|> restaurantGetAllH
         :<|> specialAddH
         :<|> specialGetByDayH
         :<|> specialGetByDescriptionH
         :<|> specialGetAllH
  where
    restaurantAddH newRestaurant = liftIO $ restaurantAdd newRestaurant
    restaurantGetByNameH name    = liftIO $ restaurantGetByName name
    restaurantGetByAddressH address    = liftIO $ restaurantGetByAddress address
    restaurantGetAllH = liftIO $ restaurantGetAll
    specialAddH newSpecial = liftIO $ specialAdd newSpecial
    specialGetByDayH day    = liftIO $ specialGetByDay day
    specialGetByDescriptionH day    = liftIO $ specialGetByDescription day
    specialGetAllH = liftIO $ specialGetAll

    restaurantAdd :: Restaurant -> IO (Maybe (Key Restaurant))
    restaurantAdd newRestaurant = flip runSqlPersistMPool pool $ do
      exists <- selectFirst [RestaurantName ==. (restaurantName newRestaurant)
                            ,RestaurantAddress ==. (restaurantAddress newRestaurant)] []
      case exists of
        Nothing -> Just <$> insert newRestaurant
        Just _ -> return Nothing

    restaurantGetByName :: Text -> IO [Restaurant]
    restaurantGetByName name = flip runSqlPersistMPool pool $ do
      mRestaurant <- selectList [RestaurantName ==. name] []
      return $ entityVal <$> mRestaurant

    restaurantGetByAddress :: Text -> IO [Restaurant]
    restaurantGetByAddress address = flip runSqlPersistMPool pool $ do
      mRestaurant <- selectList [RestaurantAddress ==. address] []
      return $ entityVal <$> mRestaurant

    restaurantGetAll :: IO [Restaurant]
    restaurantGetAll = flip runSqlPersistMPool pool $ do
      mRestaurant <- selectList [] []
      return $ entityVal <$> mRestaurant

    specialAdd :: Special -> IO (Maybe (Key Special))
    specialAdd newSpecial = flip runSqlPersistMPool pool $ do
      exists <- selectFirst [SpecialDay ==. (specialDay newSpecial)
                            ,SpecialDescription ==. (specialDescription newSpecial)
                            ,SpecialRestaurantId ==. (specialRestaurantId newSpecial)] []
      case exists of
        Nothing -> Just <$> insert newSpecial
        Just _ -> return Nothing

    specialGetByDay :: Day -> IO [Special]
    specialGetByDay day = flip runSqlPersistMPool pool $ do
      mSpecial <- selectList [SpecialDay ==. day] []
      return $ entityVal <$> mSpecial

    specialGetByDescription :: Text -> IO [Special]
    specialGetByDescription description = flip runSqlPersistMPool pool $ do
      let sql = "select ?? from special where description like ?"
      mSpecial <- (rawSql sql [PersistText (pack ("%" ++ (unpack description) ++ "%"))])
      return $ entityVal <$> mSpecial

    specialGetAll :: IO [Special]
    specialGetAll = flip runSqlPersistMPool pool $ do
      mSpecial <- selectList [] []
      return $ entityVal <$> mSpecial

app :: ConnectionPool -> Application
app pool = serve api $ server pool

mkApp :: FilePath -> IO Application
mkApp sqliteFile = do
  pool <- runStderrLoggingT $ do
    createSqlitePool (cs sqliteFile) 5

  runSqlPool (runMigration migrateAll) pool
  return $ app pool

run :: FilePath -> IO ()
run sqliteFile =
  Warp.run 3000 =<< mkApp sqliteFile
