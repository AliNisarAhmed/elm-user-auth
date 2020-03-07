module Page.Login exposing (..)

import Browser.Navigation as Nav
import Element exposing (..)
import Element.Input as Input
import Http
import Styles as S


type alias Model =
    { navKey : Nav.Key
    , userName : String
    , password : String
    }


init : Nav.Key -> String -> ( Model, Cmd Msg )
init navKey serverUrl =
    ( { navKey = navKey
      , userName = ""
      , password = ""
      }
    , Cmd.none
    )


type Msg
    = OnUserNameChange String
    | OnPasswordChange String
    | OnLoginRequest
    | OnLoginResponse


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnUserNameChange name ->
            ( { model | userName = name }, Cmd.none )

        OnPasswordChange s ->
            ( { model | password = s }, Cmd.none )

        _ ->
            ( model, Cmd.none )


view : Model -> Element Msg
view model =
    row [ width fill, height fill ]
        [ column [ width fill, centerY, spacingXY 0 30 ]
            [ Input.username S.textInput
                { onChange = OnUserNameChange
                , text = model.userName
                , placeholder = Just <| Input.placeholder S.placeHolder <| text "Username"
                , label = Input.labelAbove S.textInputLabel <| text "Username"
                }
            , Input.newPassword S.textInput
                { onChange = OnPasswordChange
                , text = model.password
                , placeholder = Just <| Input.placeholder S.placeHolder <| text "Password"
                , label = Input.labelAbove S.textInputLabel <| text "Password"
                , show = False
                }
            , Input.button
                (S.bigButton
                    ++ [ centerX
                       , width (px 300)
                       , spacingXY 0 100
                       ]
                )
                { onPress = Nothing
                , label = text "Submit"
                }
            ]
        ]
