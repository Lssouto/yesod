{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE DeriveGeneric #-}
module Handler.Usuario where

import Import

data PasswordExchange = PasswordExchange { password :: Text , newPassword :: Text } deriving Generic

instance FromJSON PasswordExchange

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
                                 
postChangePasswordR :: Handler TypedContent
postChangePasswordR = do 
    pwd <- requireJsonBody :: Handler PasswordExchange
    usrid <- maybeAuthId
    case usrid of
        Just uid -> do
            user <- runDB $ selectFirst [UserId ==. uid, UserPassword ==. (password pwd)] []
            case user of
                Just usr -> do
                    runDB $ update uid [UserPassword =. (newPassword pwd)]
                    sendStatusJSON ok200 (object ["status" .= True])
                _ -> sendStatusJSON ok200 (object ["status" .= False])        
        _ -> sendStatusJSON ok200 (object ["status" .= False])
        