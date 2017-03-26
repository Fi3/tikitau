module Main exposing (..)

import Html exposing (Html, beginnerProgram, div, text, h2, a, nav, i, span)
import Html.Attributes exposing (class, style)
import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import RemoteData
import View
import Models


main =
    Html.program
        { init = init 1
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias User =
    String


type alias Article =
    { articleId : ArticleId
    , articleAuthor : String
    , title : String
    , score : Int
    }


type alias ArticleId =
    Int


init : ArticleId -> ( Article, Cmd Msg )
init articleId =
    ( Article articleId "unknowb" "unknown" 0
    , fetchArticle articleId
    )



-- UPDATE


type Msg
    = NewArticle (RemoteData.WebData Article)


update : Msg -> Article -> ( Article, Cmd Msg )
update msg model =
    case msg of
        NewArticle response ->
            ( fetch response, Cmd.none )



-- VIEW


view : Article -> Html Msg
view model =
    div [ class "section" ]
        [ div [ class "cloumns is-mobile" ]
            [ div [ class "column is-8 is-offset-2" ]
                [ div [ class "box" ]
                    [ nav [ class "nav" ]
                        [ div [ class "nav-left" ]
                            [ a [ class "nav-item" ]
                                [ text model.articleAuthor
                                ]
                            ]
                        , div [ class "nav-center" ]
                            [ a [ class "nav-item" ]
                                [ text model.title
                                ]
                            ]
                        , div [ class "nav-right" ]
                            [ a [ class "nav-item" ]
                                [ a [ class "button", style [ ( "margin-right", "1em" ) ] ]
                                    [ span [ class "icon" ]
                                        [ i [ class "fa fa-plus" ] [] ]
                                    ]
                                , text <| toString model.score
                                , a [ class "button", style [ ( "margin-left", "1em" ) ] ]
                                    [ span [ class "icon" ]
                                        [ i [ class "fa fa-minus" ] [] ]
                                    ]
                                ]
                            ]
                        ]
                    ]
                ]
            ]
        ]


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



-- HTTP


fetchArticle : ArticleId -> Cmd Msg
fetchArticle articleId =
    let
        url =
            "http://filippomerli.xyz:4000/articles/" ++ (toString articleId)
    in
        Http.get url decodeArticle
            |> RemoteData.sendRequest
            |> Cmd.map NewArticle


decodeArticle : Decode.Decoder Article
decodeArticle =
    decode Article
        |> required "id" Decode.int
        |> required "author" Decode.string
        |> required "title" Decode.string
        |> required "score" Decode.int



-- SUBSCRIPTIONS


subscriptions : Article -> Sub Msg
subscriptions model =
    Sub.none
