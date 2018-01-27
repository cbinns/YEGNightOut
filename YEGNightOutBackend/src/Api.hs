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

import Servant.API



type Api =
       "restaurant" :> ReqBody '[JSON] Restaurant :> Post '[JSON] (Maybe (Key Restaurant))
  :<|> "restaurant" :> Capture "name" Text  :> Get  '[JSON] (Maybe Restaurant)

api :: Proxy Api
api = Proxy
