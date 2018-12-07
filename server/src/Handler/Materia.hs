{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Home where

import Import
import Network.HTTP.Types.Status
import Database.Persist.Postgresql

getHomeR :: Handler Html
getHomeR = undefined

--getUsuarioR :: Handler TypedContent
--getUsuarioR = do
--    usuario <- runDB $ selectList [] [Asc UserEmail]
--    sendStatusJSON ok200 (object [ "data" .= usuario
--                                 , "status" .= True 
--                                 ])

--postUsuarioR :: Handler TypedContent
--postUsuarioR = do
--    usuario <- requireJsonBody :: Handler User
--    runDB $ insert usuario
--    sendStatusJSON ok200 (object ["resp" .= usuario])
    