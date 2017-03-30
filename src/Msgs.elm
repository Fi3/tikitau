module Msgs exposing (..)

import RemoteData
import Models exposing (Model, Article, ArticleId)


type Msg
    = NewArticle (RemoteData.WebData Article)
    | DecreaseArticleScore ArticleId
    | IncreaseArticleScore ArticleId
