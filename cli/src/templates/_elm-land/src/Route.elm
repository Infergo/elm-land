module Route exposing (Route, fromUrl, toString)

{-|

@docs Route, fromUrl, toString

-}

import Dict exposing (Dict)
import Route.Path
import Route.Query
import Url exposing (Url)
import Url.Parser exposing ((</>), query)


type alias Route params =
    { path : Route.Path.Path
    , params : params
    , query : Dict String String
    , hash : Maybe String
    , url : Url
    }


fromUrl : params -> Url -> Route params
fromUrl params url =
    { path = Route.Path.fromUrl url
    , params = params
    , query = Route.Query.fromUrl url
    , hash = url.fragment
    , url = url
    }


toString :
    { route
        | path : Route.Path.Path
        , query : Dict String String
        , hash : Maybe String
    }
    -> String
toString route =
    String.join ""
        [ Route.Path.toString route.path
        , Route.Query.toString route.query |> Maybe.withDefault ""
        , route.hash |> Maybe.map (String.append "#") |> Maybe.withDefault ""
        ]
