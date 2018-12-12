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
    
postBalanceR :: Handler TypedContent
postBalanceR = do
    balance <- requireJsonBody :: Handler Balance
    usrid <- maybeAuthId
    case usrid of
        Just uid -> do 
                    runDB . insert $ balance { balanceIdUser = uid }
                    sendStatusJSON ok200 (object ["status" .= True])
        _ -> sendStatusJSON ok200 (object ["status" .= False])