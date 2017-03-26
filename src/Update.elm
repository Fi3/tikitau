module Update exposing (..)

import Models exposing (Model, Article)
import RemoteData
import Msgs exposing (..)


update : Msg -> Models.Model -> ( Models.Model, Cmd Msg )
update msg model =
    case msg of
        NewArticle response ->
            ( Models.Model <| fetch response, Cmd.none )


fetch : RemoteData.WebData Article -> Article
fetch response =
    case response of
        RemoteData.NotAsked ->
            Article 3 "noteaked" "noteaked" 0

        RemoteData.Loading ->
            Article 3 "loading" "loading" 0

        RemoteData.Success article ->
            Article article.articleId article.articleAuthor article.title article.score

        RemoteData.Failure error ->
            Article 3 (toString error) "err" 0
