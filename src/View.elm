module View exposing (view)

import Html exposing (Html, div, text)
import Models exposing (..)
import Articles.Article exposing (article)
import Sources.Sources exposing (source)
import Msgs exposing (Msg)


view : Model -> Html Msg
view model =
    case model.route of
        ArticleRoute articleId ->
            article model.article

        SourceRoute articleId ->
            source model

        TransformationRoute articleId ->
            source model

        NotFoundRoute ->
            notFoundView


notFoundView : Html msg
notFoundView =
    div []
        [ text "Not found"
        ]
