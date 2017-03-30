module View exposing (view)

import Html exposing (Html)
import Models exposing (Model)
import Articles.Article exposing (article)
import Msgs exposing (Msg)
import Commands exposing (..)


view : Model -> Html Msg
view model =
    article model.article
