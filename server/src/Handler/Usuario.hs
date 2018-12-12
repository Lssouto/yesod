{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE DeriveGeneric #-}
module Handler.Usuario where

import Import

postUsuarioR :: Handler TypedContent
postUsuarioR = do
    usuario <- requireJsonBody :: Handler User
    runDB $ insert usuario
    sendStatusJSON ok200 (object ["resp" .= usuario
                                 ,"status" .= True
                                 ])
    
getOneUsuarioR :: UserId -> Handler TypedContent
getOneUsuarioR userId = do
    usuario <- runDB $ get404 userId
    sendStatusJSON ok200 (object ["data" .= usuario
                                 ,"status" .= True
                                 ])
    
getUsuarioR :: Handler TypedContent
getUsuarioR = do
    usuario <- runDB $ selectList [] [Asc UserEmail]
    sendStatusJSON ok200 (object ["data" .= usuario
                                 ,"status" .= True
                                 ])