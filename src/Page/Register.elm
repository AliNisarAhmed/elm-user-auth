module Page.Register exposing (..)

import Browser.Navigation as Nav
import Element as E
import Element.Font as Font
import Element.Input as Input
import Styles as S



---- TYPES ----


type Msg
    = NoOp
    | OnUserNameChange String
    | OnFirstNameChange String
    | OnLastNameChange String
    | OnEmailChange String
    | OnNewPasswordChange String
    | OnRepeatPasswordChange String
    | RegisterUser


type alias Model =
    { userName : String
    , firstName : String
    , lastName : String
    , email : String
    , password : String
    , repeatPassword : String
    }


init : Nav.Key -> ( Model, Cmd Msg )
init navKey =
    ( { userName = "", firstName = "", lastName = "", email = "", password = "", repeatPassword = "" }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case ( msg, model ) of
        ( OnUserNameChange s, _ ) ->
            ( { model | userName = s }, Cmd.none )

        ( OnFirstNameChange s, _ ) ->
            ( { model | firstName = s }, Cmd.none )

        ( OnLastNameChange s, _ ) ->
            ( { model | lastName = s }, Cmd.none )

        ( OnEmailChange s, _ ) ->
            ( { model | email = s }, Cmd.none )

        ( OnNewPasswordChange s, _ ) ->
            ( { model | password = s }, Cmd.none )

        ( OnRepeatPasswordChange s, _ ) ->
            ( { model | repeatPassword = s }, Cmd.none )

        _ ->
            ( model, Cmd.none )


view : Model -> E.Element Msg
view model =
    E.row [ E.width E.fill, E.height E.fill ] <|
        [ E.column [ E.width E.fill, E.centerY, E.spacingXY 0 20 ]
            [ Input.text
                (S.textInput
                    ++ [ Input.focusedOnLoad ]
                )
                { onChange = OnFirstNameChange
                , text = model.firstName
                , placeholder = Just (Input.placeholder [ E.alignLeft ] <| E.text "First Name")
                , label = Input.labelBelow S.textInputLabel <| E.text "First Name"
                }
            , Input.text S.textInput
                { onChange = OnLastNameChange
                , text = model.lastName
                , placeholder = Just (Input.placeholder [ E.alignLeft ] <| E.text "Last Name")
                , label = Input.labelBelow S.textInputLabel <| E.text "Last Name"
                }
            , Input.email S.textInput
                { onChange = OnEmailChange
                , text = model.email
                , placeholder = Just <| Input.placeholder [ E.alignLeft ] <| E.text "Your Email"
                , label = Input.labelBelow S.textInputLabel <| E.text "Email"
                }
            , Input.username S.textInput
                { onChange = OnUserNameChange
                , text = model.userName
                , placeholder = Just <| Input.placeholder [ E.alignLeft ] <| E.text "Username"
                , label = Input.labelBelow S.textInputLabel <| E.text "User Name"
                }
            , Input.newPassword S.textInput
                { onChange = OnNewPasswordChange
                , text = model.password
                , placeholder = Just <| Input.placeholder [ E.alignLeft ] <| E.text "Password"
                , label = Input.labelBelow S.textInputLabel <| E.text "Password"
                , show = False
                }
            , Input.newPassword S.textInput
                { onChange = OnRepeatPasswordChange
                , text = model.repeatPassword
                , placeholder = Just <| Input.placeholder [ E.alignLeft ] <| E.text "Repeat Password"
                , label = Input.labelBelow S.textInputLabel <| E.text "Repeat Password"
                , show = False
                }
            , Input.button
                (S.registerButton
                    ++ [ E.centerX
                       , E.width (E.px 400)
                       ]
                )
                { onPress = Just RegisterUser
                , label = E.text "Submit"
                }
            ]
        ]
