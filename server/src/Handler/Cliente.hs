{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE DeriveGeneric #-}
module Handler.Cliente where

import Import

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