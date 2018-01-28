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
  :<|> "restaurant" :> "name" :> Capture "name" Text  :> Get  '[JSON] [Restaurant]
  :<|> "restaurant" :> "address" :> Capture "address" Text  :> Get  '[JSON] [Restaurant]
  :<|> "restaurant" :> Get  '[JSON] [Restaurant]
  :<|> "special" :> ReqBody '[JSON] Special :> Post '[JSON] (Maybe (Key Special))
  :<|> "special" :> "day" :> Capture "day" Day  :> Get  '[JSON] [Special]
  :<|> "special" :> "description" :> Capture "description" Text  :> Get  '[JSON] [Special]
  :<|> "special" :> Get  '[JSON] [Special]

api :: Proxy Api
api = Proxy
