module Models exposing (Model, Article, ArticleId)


type alias Model =
    { article : Article }


type alias User =
    String


type alias Article =
    { articleId : ArticleId
    , articleAuthor : String
    , title : String
    , score : Int
    , text : String
    }


type alias ArticleId =
    Int
