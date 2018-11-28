{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE DeriveGeneric #-}
module Handler.Tag where

import Import

-- postUsuarioR :: Handler TypedContent
-- postUsuarioR = do
--     usuario <- requireJsonBody :: Handler User
--     runDB $ insert usuario
--     sendStatusJSON ok200 (object ["resp" .= usuario])
    
-- getOneUsuarioR :: UserId -> Handler TypedContent
-- getOneUsuarioR userId = do
--     usuario <- runDB $ get404 userId
--     sendStatusJSON ok200 (object ["data" .= usuario])
    
getTagR :: Handler TypedContent
getTagR = do
    tag <- runDB $ selectList [] [Asc TagId]
    sendStatusJSON ok200 (object ["data" .= tag,
                                  "status" .= True ])

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