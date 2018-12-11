{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE DeriveGeneric #-}
module Handler.Authenticate where

import Import

data ParsedResponse = ParsedResponse { dados :: Value , status :: Bool, message :: String } deriving Generic

instance ToJSON ParsedResponse where 
    toJSON (ParsedResponse dados status message) = object
        [ "status" .= status
        , "data"   .= dados
        , "message" .= message
        ]
        
postAuthenticateR :: Handler TypedContent
postAuthenticateR = do 
    usuario <- requireJsonBody :: Handler User
    userExist <- runDB $ selectFirst [UserEmail ==. userEmail usuario, UserPassword ==. userPassword usuario] []
    case userExist of
        Just (Entity userid user) -> do 
            sendStatusJSON ok200 (ParsedResponse (toJSON $ tokenize userid) True "ok" )
        Nothing -> do 
            sendStatusJSON ok200 (object [ "status" .= False])

getBackLogoutR :: Handler TypedContent
getBackLogoutR = do 
    sendStatusJSON ok200 (object ["status" .= True])

