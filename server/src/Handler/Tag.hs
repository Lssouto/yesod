{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE DeriveGeneric #-}
module Handler.Tag where

import Import
    
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

getOneTagR :: TagId -> Handler TypedContent
getOneTagR tagId = do
    tag <- runDB $ get404 tagId :: Handler Tag
    sendStatusJSON ok200 (object [ "data" .= tag
                                 , "status" .= True
                                 ])