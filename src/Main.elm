module Main exposing (..)

import Browser as Browser exposing (UrlRequest)
import Browser.Navigation as Nav
import Element as E
import Element.Input as Input
import Styles as S
import Url as U
import Page.RegisterPage as RegisterRoute

type Page
    = MainPage
    | RegisterPage RegisterRoute.Model



type Msg
    = OnUrlRequest UrlRequest
    | OnUrlChange U.Url
    | RegisterPageMsg RegisterRoute.Msg


---- MODEL ----


type alias Model =
    { page : Page
    , navKey : Nav.Key
    }


init : () -> U.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url navKey =
    let
        model =
            { navKey = navKey
            , page = MainPage
            }
    in
    ( model, Cmd.none )



---- UPDATE ----



update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case (msg, model.page) of



---- VIEW ----


view : Model -> Browser.Document Msg
view model =
    { title = "User Auth"
    , body =
        [ E.layout [] <|
            E.column S.pageStyles <|
                currentView model
        ]
    }


currentView : Model -> List (E.Element msg)
currentView model =
    case model.page of
        MainPage ->
            viewMainPage


viewMainPage : List (E.Element msg)
viewMainPage =
    [ E.row S.buttonRowStyles
        [ Input.button S.loginButton { onPress = Nothing, label = E.text "Log In" }
        , Input.button S.registerButton { onPress = Nothing, label = E.text "Register" }
        ]
    ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        , onUrlRequest = OnUrlRequest
        , onUrlChange = OnUrlChange
        }
