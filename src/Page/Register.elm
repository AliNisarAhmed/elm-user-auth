module Page.Register exposing (..)

import Browser.Navigation as Nav
import Element as E
import Element.Font as Font
import Element.Input as Input
import Http
import Json.Decoders exposing (..)
import Json.Encode as Encode
import Routes
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
    | OnRegisterUser (Result Http.Error RegisterUserResponse)


type alias Model =
    { navKey : Nav.Key
    , userName : String
    , firstName : String
    , lastName : String
    , email : String
    , password : String
    , repeatPassword : String
    , serverUrl : String
    }


init : Nav.Key -> String -> ( Model, Cmd Msg )
init navKey serverUrl =
    ( { navKey = navKey
      , userName = ""
      , firstName = ""
      , lastName = ""
      , email = ""
      , password = ""
      , repeatPassword = ""
      , serverUrl = serverUrl
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnUserNameChange s ->
            ( { model | userName = s }, Cmd.none )

        OnFirstNameChange s ->
            ( { model | firstName = s }, Cmd.none )

        OnLastNameChange s ->
            ( { model | lastName = s }, Cmd.none )

        OnEmailChange s ->
            ( { model | email = s }, Cmd.none )

        OnNewPasswordChange s ->
            ( { model | password = s }, Cmd.none )

        OnRepeatPasswordChange s ->
            ( { model | repeatPassword = s }, Cmd.none )

        RegisterUser ->
            ( model, sendRegisterRequest model )

        OnRegisterUser (Ok _) ->
            ( model, Nav.pushUrl model.navKey "/login" )

        OnRegisterUser (Err err) ->
            ( model, Cmd.none )

        _ ->
            ( model, Cmd.none )



---- COMMANDS ----


sendRegisterRequest : Model -> Cmd Msg
sendRegisterRequest model =
    Http.post
        { url = model.serverUrl ++ "/api/users/register"
        , body = Http.jsonBody (registerUserRequest model)
        , expect = Http.expectJson OnRegisterUser registerUserResponse
        }


registerUserRequest : Model -> Encode.Value
registerUserRequest { userName, firstName, lastName, email, password, repeatPassword } =
    Encode.object
        [ ( "userName", Encode.string userName )
        , ( "firstName", Encode.string firstName )
        , ( "lastName", Encode.string lastName )
        , ( "password", Encode.string password )
        ]


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
                , placeholder = Just (Input.placeholder S.placeHolder <| E.text "First Name")
                , label = Input.labelAbove S.textInputLabel <| E.text "First Name"
                }
            , Input.text S.textInput
                { onChange = OnLastNameChange
                , text = model.lastName
                , placeholder = Just (Input.placeholder S.placeHolder <| E.text "Last Name")
                , label = Input.labelAbove S.textInputLabel <| E.text "Last Name"
                }
            , Input.email S.textInput
                { onChange = OnEmailChange
                , text = model.email
                , placeholder = Just <| Input.placeholder S.placeHolder <| E.text "Your Email"
                , label = Input.labelAbove S.textInputLabel <| E.text "Email"
                }
            , Input.username S.textInput
                { onChange = OnUserNameChange
                , text = model.userName
                , placeholder = Just <| Input.placeholder S.placeHolder <| E.text "Username"
                , label = Input.labelAbove S.textInputLabel <| E.text "User Name"
                }
            , Input.newPassword S.textInput
                { onChange = OnNewPasswordChange
                , text = model.password
                , placeholder = Just <| Input.placeholder S.placeHolder <| E.text "Password"
                , label = Input.labelAbove S.textInputLabel <| E.text "Password"
                , show = False
                }
            , Input.newPassword S.textInput
                { onChange = OnRepeatPasswordChange
                , text = model.repeatPassword
                , placeholder = Just <| Input.placeholder S.placeHolder <| E.text "Repeat Password"
                , label = Input.labelAbove S.textInputLabel <| E.text "Repeat Password"
                , show = False
                }
            , Input.button
                (S.bigButton
                    ++ [ E.centerX
                       , E.width (E.px 400)
                       ]
                )
                { onPress = Just RegisterUser
                , label = E.text "Submit"
                }
            ]
        ]
