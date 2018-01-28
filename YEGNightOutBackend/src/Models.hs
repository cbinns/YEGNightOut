{-# LANGUAGE EmptyDataDecls             #-}
{-# LANGUAGE FlexibleContexts           #-}
{-# LANGUAGE GADTs                      #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses      #-}
{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE QuasiQuotes                #-}
{-# LANGUAGE TemplateHaskell            #-}
{-# LANGUAGE TypeFamilies               #-}

module Models where

import Data.Aeson
import Data.Text

import Database.Persist.TH

import OtherModels

share [mkPersist sqlSettings, mkMigrate "migrateAll"] [persistLowerCase|
Restaurant
  name Text
  address  Text
  lat Double Maybe
  lon Double Maybe
  RestaurantNameAddress name address
  deriving Eq Read Show

Special
  day Day
  description Text
  restaurantId RestaurantId
  SpecialDayDescriptionRestaurantId day description restaurantId
  deriving Eq Read Show
|]

instance FromJSON Restaurant where
  parseJSON = withObject "Restaurant" $ \ v ->
    Restaurant <$> v .: "name"
               <*> v .: "address"
               <*> v .:! "lat"
               <*> v .:! "lon"

instance ToJSON Restaurant where
  toJSON (Restaurant name address lat lon) =
    object [ "name" .= name
           , "address"  .= address
           , "lat" .= lat
           , "lon" .= lon ]

instance FromJSON Special where
  parseJSON = withObject "Special" $ \ v ->
    Special <$> v .: "day"
            <*> v .: "description"
            <*> v .: "restaurantId"

instance ToJSON Special where
  toJSON (Special day description restaurantId) =
    object [ "day" .= day
           , "description" .= description
           , "restaurantId" .= restaurantId ]

