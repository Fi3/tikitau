module Msgs exposing (..)

import Http exposing (..)
import RemoteData
import Models exposing (Model, Article, ArticleId, PlotData)
import Navigation exposing (Location)


type Msg
    = NewArticle (RemoteData.WebData Article)
    | NewSource (RemoteData.WebData PlotData)
    | DecreaseArticleScore ArticleId
    | IncreaseArticleScore ArticleId
    | OnArticleSave (Result Http.Error Article)
    | OnLocationChange Location
