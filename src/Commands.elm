module Commands exposing (fetchArticle, saveArticle)

import Http
import Http
import Json.Decode as Decode
import Json.Encode as Encode
import Json.Decode.Pipeline exposing (decode, required)
import RemoteData
import Msgs exposing (..)
import Models exposing (ArticleId, Article)


saveArticleScoreUrl : ArticleId -> String
saveArticleScoreUrl articleId =
    "http://filippomerli.xyz:4000/articles/" ++ (toString articleId)


saveArticleScoreRequest : Article -> Http.Request Article
saveArticleScoreRequest article =
    Http.request
        { body = encodeArticle article |> Http.jsonBody
        , expect = Http.expectJson decodeArticle
        , headers = []
        , method = "PATCH"
        , timeout = Nothing
        , url = saveArticleScoreUrl article.articleId
        , withCredentials = False
        }


fetchArticle : ArticleId -> Cmd Msg
fetchArticle articleId =
    let
        url =
            "http://filippomerli.xyz:4000/articles/" ++ (toString articleId)
    in
        Http.get url decodeArticle
            |> RemoteData.sendRequest
            |> Cmd.map NewArticle


saveArticle : Article -> Cmd Msg
saveArticle article =
    saveArticleScoreRequest article
        |> Http.send Msgs.OnArticleSave


decodeArticle : Decode.Decoder Article
decodeArticle =
    decode Article
        |> required "id" Decode.int
        |> required "author" Decode.string
        |> required "title" Decode.string
        |> required "score" Decode.int
        |> required "text" Decode.string


encodeArticle : Article -> Encode.Value
encodeArticle article =
    let
        attributes =
            [ ( "id", Encode.int article.articleId )
            , ( "author", Encode.string article.articleAuthor )
            , ( "title", Encode.string article.title )
            , ( "score", Encode.int article.score )
            , ( "text", Encode.string article.text )
            ]
    in
        Encode.object attributes
