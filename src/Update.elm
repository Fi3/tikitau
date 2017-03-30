module Update exposing (..)

import Models exposing (Model, Article)
import RemoteData
import Msgs exposing (..)
import Commands exposing (..)


update : Msg -> Models.Model -> ( Models.Model, Cmd Msg )
update msg model =
    case msg of
        NewArticle response ->
            ( Models.Model <| fetch response, Cmd.none )

        DecreaseArticleScore articleId ->
            let
                article =
                    model.article
            in
                ( { model | article = { article | score = article.score - 1 } }
                , saveArticle { article | score = article.score - 1 }
                )

        IncreaseArticleScore articleId ->
            let
                article =
                    model.article
            in
                ( { model | article = { article | score = article.score + 1 } }
                , saveArticle { article | score = article.score + 1 }
                )

        OnArticleSave (Ok newArticle) ->
            ( { model | article = newArticle }, Cmd.none )

        OnArticleSave (Err error) ->
            ( model, Cmd.none )


fetch : RemoteData.WebData Article -> Article
fetch response =
    case response of
        RemoteData.NotAsked ->
            Article 3 "noteaked" "noteaked" 0 "wait"

        RemoteData.Loading ->
            Article 3 "loading" "loading" 0 "wait"

        RemoteData.Success article ->
            Article article.articleId article.articleAuthor article.title article.score article.text

        RemoteData.Failure error ->
            Article 3 (toString error) "err" 0 "error"
