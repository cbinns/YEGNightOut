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
  rid Int
  address  Text
  lat Double Maybe
  lon Double Maybe
  Primary rid
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
               <*> v .: "rid"
               <*> v .: "address"
               <*> v .:! "lat"
               <*> v .:! "lon"

instance ToJSON Restaurant where
  toJSON (Restaurant name rid address lat lon) =
    object [ "id" .= rid
           , "name" .= name
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

