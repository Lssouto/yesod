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
    sendStatusJSON ok200 (object ["resp" .= usuario])
    
getOneUsuarioR :: UserId -> Handler TypedContent
getOneUsuarioR userId = do
    usuario <- runDB $ get404 userId
    sendStatusJSON ok200 (object ["data" .= usuario])
    
getUsuarioR :: Handler TypedContent
getUsuarioR = do
    usuario <- runDB $ selectList [] [Asc UserEmail]
    sendStatusJSON ok200 (object ["listinha" .= usuario])

--postClienteR :: Handler TypedContent
--postClienteR = do 
--    cli <- requireJsonBody :: Handler Cliente
--    runDB $ insert cli
--    sendStatusJSON created201 (object ["resp" .= cliid])
--    --201 é quando cria
--    
--getListaCliR :: Handler TypedContent
--getListaCliR  = do 
--    clis <- runDB $ selectList [] [Asc ClienteNome]
--    sendStatusJSON ok200 (object ["resp" .= clis])
--    --200 nao mexe no banco