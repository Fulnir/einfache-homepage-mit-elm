
{- This file re-implements the Elm Counter example (1 counter) with elm-mdl
   buttons. Use this as a starting point for using elm-mdl components in your own
   app.
-}


module MeineHomepage exposing (..)

import Html exposing (..)
import Html.Attributes exposing (href, class, style)
import Material
import Material.Scheme
import Material.Button as Button
import Material.Options as Options exposing (css)
import Material.Layout as Layout
import Material.Color as Color

-- MODEL

type alias Model =
    { mdl :
        Material.Model
        , selectedTab : Int
    }


model : Model
model =
    { mdl =
        Material.model
    , selectedTab = 0
    }

-- ACTION, UPDATE

type Msg
    = Mdl (Material.Msg Msg)
    | SelectTab Int

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Mdl msg_ ->
            Material.update Mdl msg_ model

        SelectTab num ->
            { model | selectedTab = num } ! []

-- VIEW

type alias Mdl =
    Material.Model

view : Model -> Html Msg
view model =
    Material.Scheme.topWithScheme Color.Teal Color.Lime <|
        Layout.render Mdl
            model.mdl
            [ Layout.fixedHeader
            , Layout.selectedTab model.selectedTab
            , Layout.onSelectTab SelectTab
            ]
            { header = [ h1 [ style [ ( "padding", "2rem" ) ] ] [ text "Meine Homepage" ] ]
            , drawer = []
            , tabs = ( [ text "Start", text "Über" ], [Color.background (Color.color Color.LightGreen Color.S400)] )
            , main = [ viewBody model ]
            }

viewBody : Model -> Html Msg
viewBody model =
    case model.selectedTab of
        0 ->
            viewStart model

        1 ->
            viewAbout model

        _ ->
            text "404"

viewStart : Model -> Html Msg
viewStart model =
    div
        [ style [ ( "padding", "2rem" ) ] ]
        [ h1 [] [ text "Willkommen" ] 
        
        ]

viewAbout : Model -> Html Msg
viewAbout model =
    div
        [ style [ ( "padding", "2rem" ) ] ]
        [ h1 [] [ text "Über" ] 
        
        ]

main : Program Never Model Msg
main =
    Html.program
        { init = ( model, Cmd.none )
        , view = view
        , subscriptions = always Sub.none
        , update = update
        }
