module Styles exposing (..)

import Element as E
import Element.Background as B
import Element.Font as F



---- PAGE STYLES ----


pageStyles : List (E.Attribute msg)
pageStyles =
    [ E.height E.fill, E.width E.fill, B.color primaryColor ]



---- BUTTONS ----


primaryColor : E.Color
primaryColor =
    E.rgb255 36 37 130


secondaryColor : E.Color
secondaryColor =
    E.rgb255 246 76 114


white : E.Color
white =
    E.rgb255 255 255 255


buttonWidth : E.Length
buttonWidth =
    E.px 150


loginButton : List (E.Attribute msg)
loginButton =
    [ E.padding 20
    , E.width buttonWidth
    , F.color white
    , B.color primaryColor
    , E.mouseOver [ F.color secondaryColor ]
    ]


registerButton : List (E.Attribute msg)
registerButton =
    [ E.padding 20
    , E.width buttonWidth
    , F.color primaryColor
    , B.color secondaryColor
    , E.mouseOver [ F.color white, E.scale 1.1 ]
    ]


buttonRowStyles : List (E.Attribute msg)
buttonRowStyles =
    [ E.centerY, E.centerX, E.spacingXY 40 0 ]
