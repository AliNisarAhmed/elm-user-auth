module Json.Decoders exposing (..)

import Json.Decode as Decode


type alias RegisterUserResponse =
    { id : Int
    , firstName : String
    , lastName : String
    , userName : String
    }


type alias LoginResponse =
    { id : Int
    , firstName : String
    , lastName : String
    , token : String
    }


type alias Flags =
    { token : Maybe String }


registerUserResponse : Decode.Decoder RegisterUserResponse
registerUserResponse =
    Decode.map4 RegisterUserResponse
        (Decode.field "id" Decode.int)
        (Decode.field "firstName" Decode.string)
        (Decode.field "lastName" Decode.string)
        (Decode.field "userName" Decode.string)


loginResponseDecoder : Decode.Decoder LoginResponse
loginResponseDecoder =
    Decode.map4 LoginResponse
        (Decode.field "id" Decode.int)
        (Decode.field "firstName" Decode.string)
        (Decode.field "lastName" Decode.string)
        (Decode.field "token" Decode.string)


flagsDecoder : Decode.Decoder Flags
flagsDecoder =
    Decode.map Flags
        (Decode.field "token" (Decode.maybe Decode.string))
