module Msgs exposing (..)

import RemoteData
import Models exposing (Model, Article)


type Msg
    = NewArticle (RemoteData.WebData Article)
