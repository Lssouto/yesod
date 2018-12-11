{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Balance where

import Import
import Network.HTTP.Types.Status
import Database.Persist.Postgresql
import Prelude (read)

getHomeR :: Handler Html
getHomeR = undefined

getBalanceR :: Handler TypedContent
getBalanceR = do
    usrid <- maybeAuthId
    case usrid of
        Just uid -> do 
                    balance <- runDB $ selectList [ BalanceIdUser ==. uid ] []
                    sendStatusJSON ok200 (object [ "data" .= balance
                                                 , "status" .= True 
                                                 ])
        _ -> sendStatusJSON ok200 (object ["status" .= False])
    
 
