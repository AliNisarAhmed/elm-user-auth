module Json.Decoders exposing (..)

import Json.Decode as Decode


type alias RegisterUserResponse =
    { id : Int
    , firstName : String
    , lastName : String
    , userName : String
    }


registerUserResponse : Decode.Decoder RegisterUserResponse
registerUserResponse =
    Decode.map4 RegisterUserResponse
        (Decode.field "id" Decode.int)
        (Decode.field "firstName" Decode.string)
        (Decode.field "lastName" Decode.string)
        (Decode.field "userName" Decode.string)
