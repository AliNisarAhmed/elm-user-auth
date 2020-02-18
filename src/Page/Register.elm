module Page.Register exposing (..)

import Browser.Navigation as Nav
import Element as E



---- TYPES ----


type Msg
    = NoOp


type alias Model =
    {}


init : Nav.Key -> ( Model, Cmd Msg )
init navKey =
    ( {}, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )


view : Model -> E.Element Msg
view model =
    E.row [] [ E.text "Register Page" ]
