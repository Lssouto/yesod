{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Home where

import Import
import Network.HTTP.Types.Status
import Database.Persist.Postgresql



getMateriaR :: Handler TypedContent
getMateriaR = do
    materia <- runDB $ selectList [] [Asc MateriaNome]
    sendStatusJSON ok200 (object [ "data" .= materia
                                 , "status" .= True 
                                 ])
                                 

--postUsuarioR :: Handler TypedContent
--postUsuarioR = do
--    usuario <- requireJsonBody :: Handler User
--    runDB $ insert usuario
--    sendStatusJSON ok200 (object ["resp" .= usuario])
    