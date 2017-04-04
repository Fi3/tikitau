module Main exposing (..)

import View exposing (..)
import Models exposing (..)
import Commands exposing (..)
import Update exposing (..)
import Msgs exposing (..)
import Routing exposing (..)
import Navigation exposing (Location)


main =
    Navigation.program Msgs.OnLocationChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL
--init : ArticleId -> ( Model, Cmd Msg )
--init articleId =
--    ( Model <| Article articleId "unknowb" "unknown" 0 "unknown"
--    , fetchArticle articleId
--    )


initArticle : ArticleId -> Article
initArticle articleId =
    Article articleId "unknowb" "unknown" 0 "unknown"


init : Location -> ( Model, Cmd Msg )
init location =
    let
        currentRoute =
            Routing.parseLocation location
    in
        ( initialModel (initArticle 1) currentRoute, fetchArticle 1 )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
