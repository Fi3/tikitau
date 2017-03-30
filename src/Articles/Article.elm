module Articles.Article exposing (article)

import Html exposing (Html, beginnerProgram, div, text, h2, a, nav, i, span)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class, style)
import Models exposing (Article)
import Msgs exposing (Msg)
import Plot exposing (..)


article : Article -> Html Msg
article model =
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
                            [ a
                                [ class "nav-item"
                                , style [ ( "font-size", "2em" ) ]
                                ]
                                [ text model.title
                                ]
                            ]
                        , div [ class "nav-right" ]
                            [ a [ class "nav-item" ]
                                [ a
                                    [ class "button"
                                    , style [ ( "margin-right", "1em" ) ]
                                    , onClick (Msgs.DecreaseArticleScore model.articleId)
                                    ]
                                    [ span [ class "icon" ]
                                        [ i [ class "fa fa-plus" ] [] ]
                                    ]
                                , text <| toString model.score
                                , a
                                    [ class "button"
                                    , style [ ( "margin-left", "1em" ) ]
                                    , onClick (Msgs.IncreaseArticleScore model.articleId)
                                    ]
                                    [ span [ class "icon" ]
                                        [ i [ class "fa fa-minus" ] [] ]
                                    ]
                                ]
                            ]
                        ]
                    , div [ class "cloumns is-mobile" ]
                        [ div
                            [ class "column"
                            ]
                            [ a
                                [ class "button"
                                ]
                                [ text "Sources" ]
                            , a
                                [ class "button is-pulled-right"
                                ]
                                [ text "Transformations" ]
                            ]
                        ]
                    , div [ class "cloumns is-mobile" ]
                        [ div
                            [ class "column"
                            , style [ ( "margin-top", "3em" ) ]
                            ]
                            [ plot ]
                        ]
                    , div [ class "cloumns is-mobile" ]
                        [ div
                            [ class "column"
                            , style [ ( "margin-top", "3em" ) ]
                            ]
                            [ text model.text ]
                        ]
                    ]
                ]
            ]
        ]


plot : Html Msg
plot =
    viewSeries
        [ area (List.map (\{ x, y } -> circle x y)) ]
        [ { x = 0, y = 1 }
        , { x = 2, y = 2 }
        , { x = 3, y = 3 }
        , { x = 4, y = 5 }
        , { x = 5, y = 8 }
        ]
