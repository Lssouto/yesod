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
    
getOneMateriaR :: MateriaId -> Handler TypedContent
getOneMateriaR materiaId = do
    materia <- runDB $ get404 materiaId :: Handler Materia
    sendStatusJSON ok200 (object [ "data" .= materia
                                 , "status" .= True
                                 ])
