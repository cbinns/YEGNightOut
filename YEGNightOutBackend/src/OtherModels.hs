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
import Data.Aeson.TH
import Data.Text

import Servant

import GHC.Generics (Generic)

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
deriveJSON defaultOptions ''Day

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

