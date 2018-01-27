{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE LambdaCase        #-}
{-# LANGUAGE TypeFamilies      #-}
{-# LANGUAGE TypeOperators     #-}

module Api where

import Data.Proxy
import Data.Text

import Database.Persist

import Models
import OtherModels

import Servant.API



type Api =
       "restaurant" :> ReqBody '[JSON] Restaurant :> Post '[JSON] (Maybe (Key Restaurant))
  :<|> "restaurant" :> Capture "name" Text  :> Get  '[JSON] (Maybe Restaurant)
  :<|> "special" :> ReqBody '[JSON] Special :> Post '[JSON] (Maybe (Key Special))
  :<|> "special" :> Capture "day" Day  :> Get  '[JSON] (Maybe Special)

api :: Proxy Api
api = Proxy
