{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Faq where

import Import
import Network.HTTP.Types.Status
import Database.Persist.Postgresql
import qualified Network.Mail.Mime as Mail

postFaqR :: Handler TypedContent
postFaqR = do 
    information <- requireJsonBody :: Handler Faq
    -- liftIO $ Mail.renderSendMail $ Mail.simpleMail'
    --     (Mail.Address Nothing "lssouto96@gmail.com") -- EMAIL DO FOCAASK
    --     (Mail.Address (Just "The Foca") "noreply@foca.com.br") -- From addres
    --     "Assunto" -- Subject
    --     ("Email de " ++ "Lucas" ++ "\n"++ "Corpo") -- Body of the email
    sendStatusJSON ok200 (object ["status" .= True])