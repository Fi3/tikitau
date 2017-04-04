module Routing exposing (..)

import Navigation exposing (Location)
import Models exposing (ArticleId, Route(..))
import UrlParser exposing (..)


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map NotFoundRoute top
        , map ArticleRoute (s "article" </> int)
        , map SourceRoute (s "source" </> int)
        , map TransformationRoute (s "transformation" </> int)
        ]


parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route

        Nothing ->
            NotFoundRoute
