module Styles exposing (..)

import Element as E
import Element.Background as B
import Element.Border as Border
import Element.Events as Events
import Element.Font as Font
import Html.Attributes exposing (class)


addTransition : E.Attribute msg
addTransition =
    E.htmlAttribute <| class "transition"



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


textButton : List (E.Attribute msg)
textButton =
    [ E.padding 20
    , E.width buttonWidth
    , Font.color white
    , B.color primaryColor
    , E.mouseOver [ Font.color secondaryColor, E.scale 1.2 ]
    , Border.rounded 5
    , addTransition
    ]


bigButton : List (E.Attribute msg)
bigButton =
    [ E.padding 20
    , E.width buttonWidth
    , Font.color primaryColor
    , B.color secondaryColor
    , E.mouseOver [ Font.color white, E.scale 1.1 ]
    , Border.rounded 5
    , addTransition
    ]


buttonRowStyles : List (E.Attribute msg)
buttonRowStyles =
    [ E.centerY, E.centerX, E.spacingXY 40 0 ]


textInput : List (E.Attribute msg)
textInput =
    [ E.centerX
    , E.centerY
    , E.width (E.px 350)
    , E.height (E.px 35)
    , B.color offWhite
    , Font.size 16
    , Font.color primaryColor
    ]


textInputLabel : List (E.Attribute msg)
textInputLabel =
    [ Font.color secondaryColor, E.alignLeft ]


placeHolder : List (E.Attribute msg)
placeHolder =
    [ Font.size 13, Font.color primaryColor ]
