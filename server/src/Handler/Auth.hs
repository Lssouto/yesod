{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE DeriveGeneric #-}
module Handler.Auth where

import Import
    
postAuthR :: Handler TypedContent
postAuthR = do 
    usuario <- requireJsonBody :: Handler User
    userExist <- runDB $ selectFirst [UserEmail ==. userEmail usuario, UserPassword ==. userPassword usuario] []
    case userExist of
        Just (Entity name user) -> do 
            sendStatusJSON ok200 (object ["status" .= True])
        Nothing -> do 
            sendStatusJSON ok200 (object ["status" .= False])
            
optionsAuthR :: Handler TypedContent
optionsAuthR = do 
    addHeader "Access-Control-Allow-Origin" "*"
    sendStatusJSON ok200 (object ["status" .= True])