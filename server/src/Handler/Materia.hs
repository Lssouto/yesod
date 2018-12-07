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
                                 
postMateriaR :: Handler TypedContent
postMateriaR = do
    materia <- requireJsonBody :: Handler Materia
    runDB $ insert materia
    sendStatusJSON ok200 (object ["status" .= True])
    
--getOneUsuarioR :: UserId -> Handler TypedContent
--getOneUsuarioR userId = do
--    usuario <- runDB $ get404 userId :: Handler User
--    sendStatusJSON ok200 (object [ "data" .= usuario
--                                 , "status" .= True
--                                 ])