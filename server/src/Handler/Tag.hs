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
    
    
getTagR :: Handler TypedContent
getTagR = do
    tag <- runDB $ selectList [] [Asc TagId]
    sendStatusJSON ok200 (object ["data" .= tag,
                                  "status" .= True ])
                                  
getTagInMateriaR :: MateriaId -> Handler TypedContent
getTagInMateriaR materiaId = do
    tag <- runDB $ selectList [TagIdMateria ==. materiaId] [Asc TagNome]
    sendStatusJSON ok200 (object [ "data" .= tag
                                 , "status" .= True
                                 ])
