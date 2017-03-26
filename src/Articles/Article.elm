module Articles.Article exposing (article)

import Html exposing (Html, beginnerProgram, div, text, h2, a, nav, i, span)
import Html.Attributes exposing (class, style)
import Models exposing (Article)
import Msgs exposing (Msg)


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
