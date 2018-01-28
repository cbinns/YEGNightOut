{-# LANGUAGE EmptyDataDecls             #-}
{-# LANGUAGE FlexibleContexts           #-}
{-# LANGUAGE GADTs                      #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses      #-}
{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE QuasiQuotes                #-}
{-# LANGUAGE TemplateHaskell            #-}
{-# LANGUAGE TypeFamilies               #-}

module OtherModels where

import Data.Aeson
import Data.Aeson.Types
import Data.Text
import Control.Monad

import Servant

import Database.Persist.TH

data Day = Monday
         | Tuesday
         | Wednesday
         | Thursday
         | Friday
         | Saturday
         | Sunday
         | Weekdays
         | Weekends
         | Everyday
         deriving (Enum, Eq, Read, Show)
derivePersistField "Day"

instance ToJSON Day  where
    toJSON a  = String $ pack (show a)

instance FromJSON Day where
    parseJSON (String v) = do
        case (v :: Text) of
            "Monday" -> return Monday
            "Tuesday" -> return Tuesday
            "Wednesday" -> return Wednesday
            "Thursday" -> return Thursday
            "Friday" -> return Friday
            "Saturday" -> return Saturday
            "Sunday" -> return Sunday
            "Weekdays" -> return Weekdays
            "Weekends" -> return Weekends
            "Everyday" -> return Everyday
            _    -> mzero
    parseJSON v = typeMismatch "Day" v

instance ToHttpApiData Day where
    toUrlPiece day = pack $ show day

instance FromHttpApiData Day where
    parseUrlPiece "Monday" = Right Monday
    parseUrlPiece "Tuesday" = Right Tuesday
    parseUrlPiece "Wednesday" = Right Wednesday
    parseUrlPiece "Thursday" = Right Thursday
    parseUrlPiece "Friday" = Right Friday
    parseUrlPiece "Saturday" = Right Saturday
    parseUrlPiece "Sunday" = Right Sunday
    parseUrlPiece "Weekdays" = Right Weekdays
    parseUrlPiece "Weekends" = Right Weekends
    parseUrlPiece "Everyday" = Right Everyday
    parseUrlPiece _ = Left $ pack "Not a day"

