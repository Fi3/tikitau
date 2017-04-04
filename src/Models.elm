module Models exposing (..)


type alias Model =
    { article : Article
    , route : Route
    }


type alias User =
    String


type alias Article =
    { articleId : ArticleId
    , articleAuthor : String
    , title : String
    , score : Int
    , text : String
    }


initialModel : Article -> Route -> Model
initialModel article route =
    { article = article
    , route = route
    }


type alias ArticleId =
    Int


type Route
    = ArticleRoute ArticleId
    | SourceRoute ArticleId
    | TransformationRoute ArticleId
    | NotFoundRoute
