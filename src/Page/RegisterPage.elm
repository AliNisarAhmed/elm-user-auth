module Page.RegisterPage exposing (..)

import Element as E



---- TYPES ----


type Msg
    = NoOp


type alias Model =
    {}


init : ( Model, Cmd Msg )
init =
    ( {}, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )


view : Model -> E.Element Msg
view model =
    E.row [] [ E.text "Register Page" ]
