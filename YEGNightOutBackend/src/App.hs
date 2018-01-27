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
                                         , runMigration, selectFirst, (==.)
                                         , insert, entityVal)
import           Data.String.Conversions (cs)
import           Data.Text (Text)
import           Network.Wai.Handler.Warp as Warp

import           Servant

import           Api
import           Models
import           OtherModels

server :: ConnectionPool -> Server Api
server pool =
  restaurantAddH :<|> restaurantGetH :<|> specialAddH :<|> specialGetH
  where
    restaurantAddH newRestaurant = liftIO $ restaurantAdd newRestaurant
    restaurantGetH name    = liftIO $ restaurantGet name
    specialAddH newSpecial = liftIO $ specialAdd newSpecial
    specialGetH day    = liftIO $ specialGet day

    restaurantAdd :: Restaurant -> IO (Maybe (Key Restaurant))
    restaurantAdd newRestaurant = flip runSqlPersistMPool pool $ do
      exists <- selectFirst [RestaurantName ==. (restaurantName newRestaurant)
                            ,RestaurantAddress ==. (restaurantAddress newRestaurant)] []
      case exists of
        Nothing -> Just <$> insert newRestaurant
        Just _ -> return Nothing

    restaurantGet :: Text -> IO (Maybe Restaurant)
    restaurantGet name = flip runSqlPersistMPool pool $ do
      mRestaurant <- selectFirst [RestaurantName ==. name] []
      return $ entityVal <$> mRestaurant

    specialAdd :: Special -> IO (Maybe (Key Special))
    specialAdd newSpecial = flip runSqlPersistMPool pool $ do
      exists <- selectFirst [SpecialDay ==. (specialDay newSpecial)
                            ,SpecialDescription ==. (specialDescription newSpecial)] []
      case exists of
        Nothing -> Just <$> insert newSpecial
        Just _ -> return Nothing

    specialGet :: Day -> IO (Maybe Special)
    specialGet day = flip runSqlPersistMPool pool $ do
      mSpecial <- selectFirst [SpecialDay ==. day] []
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
