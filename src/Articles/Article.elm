module Articles.Article exposing (article)

import Html exposing (Html, beginnerProgram, div, text, h2, a, nav, i, span)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class, style)
import Models exposing (Article, Sources, PlotData)
import Msgs exposing (Msg)
import Plot exposing (..)


article : Article -> Sources -> Html Msg
article model sources =
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
                                    , onClick (Msgs.IncreaseArticleScore model.articleId)
                                    ]
                                    [ span [ class "icon" ]
                                        [ i [ class "fa fa-plus" ] [] ]
                                    ]
                                , text <| toString model.score
                                , a
                                    [ class "button"
                                    , style [ ( "margin-left", "1em" ) ]
                                    , onClick (Msgs.DecreaseArticleScore model.articleId)
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
                            [ plot <| List.head sources ]
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


plot : Maybe PlotData -> Html Msg
plot plotData =
    viewSeries
        [ area (List.map (\{ x, y } -> circle x y)) ]
        (dataParser plotData)


fakeData =
    { observed = [ 0, 2, 3, 4, 5 ]
    , variable = [ 1, 2, 3, 5, 8 ]
    }


dataParser : Maybe PlotData -> List { x : Float, y : Float }
dataParser data =
    case data of
        Nothing ->
            [ { x = 1.0, y = 1.0 }
            , { x = 2.0, y = 2.0 }
            , { x = 3.0, y = 4.0 }
            , { x = 4.0, y = 5.0 }
            , { x = 5.0, y = 6.0 }
            ]

        Just data ->
            List.map2 (\x y -> { x = toFloat x, y = toFloat y }) data.observed data.variable
