module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)

-- Model

type alias Model
  =  {}

model : Model
model = {}

-- ACTION, UPDATE

type Msg
  = About

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  ( model, Cmd.none )

-- View

view : Model -> Html Msg
view model =
  div [ class "content" ]
    [ h1 [] [ text "Meine Homepage" ]
      , div [ id "eineDivID" ]
        [ text "Ein Text"
        , text " Noch ein Text"
      ]
      , br [] []
      , text "Und noch einer"
    ]

-- App

main : Program Never Model Msg
main =
    Html.program
        { init = ( model, Cmd.none )
        , view = view
        , subscriptions = always Sub.none
        , update = update
        }