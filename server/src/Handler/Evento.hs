{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE LambdaCase #-}

module Handler.Evento where

import Import
import Network.HTTP.Types.Status
import Database.Persist.Postgresql
import Prelude (read)

getEventoR :: Handler TypedContent
getEventoR = do
    usrid <- maybeAuthId
    case usrid of
        Just uid -> do 
                    evento <- runDB $ selectList [ EventoIdUser ==. uid ] [Asc EventoTitulo]
                    sendStatusJSON ok200 (object [ "data" .= evento
                                                 , "status" .= True 
                                                 ])
        _ -> sendStatusJSON ok200 (object ["status" .= False])
    
                                 
postEventoR :: Handler TypedContent
postEventoR = do
    evento <- requireJsonBody :: Handler Evento
    usrid <- maybeAuthId
    case usrid of
        Just uid -> do 
                    runDB . insert $ evento { eventoIdUser = uid }
                    sendStatusJSON ok200 (object ["status" .= True])
        _ -> sendStatusJSON ok200 (object ["status" .= False])
        
putPeventoR :: EventoId -> Handler TypedContent
putPeventoR evntId = do 
    evento <- requireJsonBody :: Handler Evento
    usrid <- maybeAuthId
    case usrid of
        Just uid -> do 
                    runDB $ replace evntId evento
                    sendStatusJSON ok200 (object ["status" .= True])
        _ -> sendStatusJSON ok200 (object ["status" .= False])

getPeventoR :: EventoId -> Handler TypedContent
getPeventoR evntId = do 
    usrid <- maybeAuthId
    case usrid of
        Just uid -> do 
                    evento <- runDB $ selectFirst [ EventoId ==. evntId ] []
                    sendStatusJSON ok200 (object [ "data" .= evento
                                                 , "status" .= True 
                                                 ])
        _ -> sendStatusJSON ok200 (object ["status" .= False])