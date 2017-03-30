module Commands exposing (fetchArticle)

import Http
import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import RemoteData
import Msgs exposing (..)
import Models exposing (ArticleId, Article)


fetchArticle : ArticleId -> Cmd Msg
fetchArticle articleId =
    let
        url =
            "http://filippomerli.xyz:4000/articles/" ++ (toString articleId)
    in
        Http.get url decodeArticle
            |> RemoteData.sendRequest
            |> Cmd.map NewArticle


decodeArticle : Decode.Decoder Article
decodeArticle =
    decode Article
        |> required "id" Decode.int
        |> required "author" Decode.string
        |> required "title" Decode.string
        |> required "score" Decode.int
        |> required "text" Decode.string
