module Main exposing (..)

import Browser as Browser exposing (UrlRequest)
import Browser.Navigation as Nav
import Element as E
import Element.Input as Input
import Page.Login as Login
import Page.Register as Register
import Routes exposing (Route(..))
import Styles as S
import Url exposing (Url)


type Page
    = MainPage
    | RegisterPage Register.Model
    | LoginPage Login.Model
    | NotFoundPage


type Msg
    = OnUrlRequest UrlRequest
    | OnUrlChange Url.Url
    | RegisterPageMsg Register.Msg
    | LoginPageMsg Login.Msg



---- MODEL ----


type alias Model =
    { page : Page
    , navKey : Nav.Key
    , route : Route
    , serverUrl : String
    }


init : () -> Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url navKey =
    let
        model =
            { navKey = navKey
            , page = MainPage
            , route = Routes.parseUrl url
            , serverUrl = "https://localhost:44354"
            }
    in
    initCurrentPage ( model, Cmd.none )



-- This function is needed to display the page for the current
-- route


initCurrentPage : ( Model, Cmd Msg ) -> ( Model, Cmd Msg )
initCurrentPage ( model, currentCmds ) =
    let
        ( currentPage, mappedPageCmds ) =
            case model.route of
                Routes.LandingRoute ->
                    ( MainPage, currentCmds )

                Routes.RegisterRoute ->
                    let
                        ( pageModel, pageCmds ) =
                            Register.init model.navKey model.serverUrl
                    in
                    ( RegisterPage pageModel, Cmd.map RegisterPageMsg pageCmds )

                Routes.LoginRoute ->
                    let
                        ( pageModel, pageCmds ) =
                            Login.init model.navKey model.serverUrl
                    in
                    ( LoginPage pageModel, Cmd.map LoginPageMsg pageCmds )

                _ ->
                    ( NotFoundPage, Cmd.none )
    in
    ( { model | page = currentPage }
    , Cmd.batch [ currentCmds, mappedPageCmds ]
    )



---- UPDATE ----


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case ( msg, model.page ) of
        ( RegisterPageMsg pageMsg, RegisterPage pageModel ) ->
            let
                ( updatedPageModel, updatedCmds ) =
                    Register.update pageMsg pageModel
            in
            ( { model | page = RegisterPage updatedPageModel }
            , Cmd.map RegisterPageMsg updatedCmds
            )

        ( LoginPageMsg pageMsg, LoginPage pageModel ) ->
            let
                ( updatedPageModel, updatedCmds ) =
                    Login.update pageMsg pageModel
            in
            ( { model | page = LoginPage updatedPageModel }
            , Cmd.map LoginPageMsg updatedCmds
            )

        ( OnUrlRequest urlRequest, _ ) ->
            case urlRequest of
                Browser.Internal url ->
                    ( model
                    , Nav.pushUrl model.navKey (Url.toString url)
                    )

                Browser.External url ->
                    ( model
                    , Nav.load url
                    )

        ( OnUrlChange url, _ ) ->
            let
                newRoute =
                    Routes.parseUrl url
            in
            ( { model | route = newRoute }, Cmd.none )
                |> initCurrentPage

        ( _, _ ) ->
            ( model, Cmd.none )



---- VIEW ----


view : Model -> Browser.Document Msg
view model =
    { title = "User Auth"
    , body =
        [ E.layout [] <|
            E.column S.pageStyles <|
                [ currentView model ]
        ]
    }


currentView : Model -> E.Element Msg
currentView model =
    case model.page of
        MainPage ->
            viewMainPage

        RegisterPage pageModel ->
            Register.view pageModel
                |> E.map RegisterPageMsg

        LoginPage pageModel ->
            Login.view pageModel
                |> E.map LoginPageMsg

        NotFoundPage ->
            E.row [] [ E.text "Not found" ]


viewMainPage : E.Element Msg
viewMainPage =
    E.row S.buttonRowStyles
        [ E.link S.textButton { url = "/login", label = E.text "Log In" }
        , E.link S.bigButton { url = "/register", label = E.text "Register" }
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
