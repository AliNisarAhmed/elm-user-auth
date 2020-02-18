module Routes exposing (..)

import Browser.Navigation as Nav
import Url exposing (Url)
import Url.Parser as UP


type Route
    = NotFoundPage
    | LandingPage
    | RegisterPage


pushUrl : Route -> Nav.Key -> Cmd msg
pushUrl route navKey =
    routeToString route
        |> Nav.pushUrl navKey


routeToString : Route -> String
routeToString route =
    case route of
        LandingPage ->
            "/"

        RegisterPage ->
            "/register"

        NotFoundPage ->
            "/404"


parseUrl : Url -> Route
parseUrl url =
    case UP.parse matchRoute url of
        Just route ->
            route

        Nothing ->
            NotFoundPage


matchRoute : UP.Parser (Route -> a) a
matchRoute =
    UP.oneOf
        [ UP.map LandingPage UP.top
        , UP.map RegisterPage (UP.s "register")
        ]
