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
    }


type alias ArticleId =
    Int
