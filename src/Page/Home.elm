module Page.Home exposing (..)

import Element exposing (..)
import Element.Font as Font
import Styles as S


type alias Model =
    ()


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )


view : Model -> Element Msg
view model =
    el [ Font.color S.white ] <| text "Home Page"
