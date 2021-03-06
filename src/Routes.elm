module Routes exposing (..)

import Browser.Navigation as Nav
import Url exposing (Url)
import Url.Parser as UP


type Route
    = NotFoundRoute
    | LandingRoute
    | RegisterRoute
    | LoginRoute
    | HomeRoute


pushUrl : Route -> Nav.Key -> Cmd msg
pushUrl route navKey =
    routeToString route
        |> Nav.pushUrl navKey


routeToString : Route -> String
routeToString route =
    case route of
        LandingRoute ->
            "/"

        RegisterRoute ->
            "/register"

        LoginRoute ->
            "/login"

        HomeRoute ->
            "/home"

        NotFoundRoute ->
            "/404"


parseUrl : Url -> Route
parseUrl url =
    case UP.parse matchRoute url of
        Just route ->
            route

        Nothing ->
            NotFoundRoute


matchRoute : UP.Parser (Route -> a) a
matchRoute =
    UP.oneOf
        [ UP.map LandingRoute UP.top
        , UP.map RegisterRoute (UP.s "register")
        , UP.map LoginRoute (UP.s "login")
        , UP.map HomeRoute (UP.s "home")
        ]
