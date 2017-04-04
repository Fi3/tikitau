module Sources.Sources exposing (source)

import Html exposing (Html, beginnerProgram, div, text, h2, a, nav, i, span)
import Html.Attributes exposing (class, style)
import Models exposing (Model)
import Msgs exposing (Msg)


source : Model -> Html Msg
source model =
    div [ class "section" ] [ text "CIAO!!" ]
