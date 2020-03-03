module Styles exposing (..)

import Element as E
import Element.Background as B
import Element.Border as Border
import Element.Font as Font



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


offWhite : E.Color
offWhite =
    E.rgba 255 255 255 0.8


buttonWidth : E.Length
buttonWidth =
    E.px 150


loginButton : List (E.Attribute msg)
loginButton =
    [ E.padding 20
    , E.width buttonWidth
    , Font.color white
    , B.color primaryColor
    , E.mouseOver [ Font.color secondaryColor ]
    ]


registerButton : List (E.Attribute msg)
registerButton =
    [ E.padding 20
    , E.width buttonWidth
    , Font.color primaryColor
    , B.color secondaryColor
    , E.mouseOver [ Font.color white, E.scale 1.1 ]
    ]


buttonRowStyles : List (E.Attribute msg)
buttonRowStyles =
    [ E.centerY, E.centerX, E.spacingXY 40 0 ]


textInput : List (E.Attribute msg)
textInput =
    [ E.centerX, E.width (E.px 400), E.height (E.px 40), B.color offWhite ]


textInputLabel : List (E.Attribute msg)
textInputLabel =
    [ Font.color secondaryColor, E.alignLeft ]
