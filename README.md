# Eine einfache Homepage mit Elm

Elm wird als installiert vorausgesetzt. Siehe: [Elm-Lang](https://guide.elm-lang.org/install.html)

## Vorbereitung

Zuerst wird ein Ordner erzeugt und `Main.elm` erzeugt.

```bash  {class: line-numbers}
$ mkdir mdl-beispiel
$ cd mdl-beispiel
# Die Datei Main.elm erzeugen und in Visual Code Editor öffnen
$ code Main.elm
```


Nun starten wir den **Elm reactor**.
```bash
$ elm reactor
```

Im Browser öffnen wir die Seite [http://localhost:8000](http://localhost:8000) und klicken auf den Link `Main.elm`.

Die Elmdatei wird nun kompiliert und einige Dateien werden erzeugt.

Im Browser erscheint nun "Meine Homepage".

## Elm Architektur

```
main =
  text "Meine Homepage"
```

### Das Grundgerüst

Jedes Elmprogrogramm besteht aus 3 Teilen
- Model — Speichert den Status der Anwendung
- Update — Ändert den Status
- View — Zeigt den Status in HTML an

```Elm {class: line-numbers}
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
```

## Material Design

```bash  {class: line-numbers}
# Das Elm MDL Package laden
$ elm package install -y debois/elm-mdl
```


Jetzt den Inhalt vom Beispiel `Counter.elm` nach `Main.elm`kopieren.
```Elm  {class: line-numbers}

{- This file re-implements the Elm Counter example (1 counter) with elm-mdl
   buttons. Use this as a starting point for using elm-mdl components in your own
   app.
-}


module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (href, class, style)
import Material
import Material.Scheme
import Material.Button as Button
import Material.Options as Options exposing (css)


-- MODEL


type alias Model =
    { count : Int
    , mdl :
        Material.Model
        -- Boilerplate: model store for any and all Mdl components you use.
    }


model : Model
model =
    { count = 0
    , mdl =
        Material.model
        -- Boilerplate: Always use this initial Mdl model store.
    }



-- ACTION, UPDATE


type Msg
    = Increase
    | Reset
    | Mdl (Material.Msg Msg)



-- Boilerplate: Msg clause for internal Mdl messages.


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increase ->
            ( { model | count = model.count + 1 }
            , Cmd.none
            )

        Reset ->
            ( { model | count = 0 }
            , Cmd.none
            )

        -- Boilerplate: Mdl action handler.
        Mdl msg_ ->
            Material.update Mdl msg_ model



-- VIEW


type alias Mdl =
    Material.Model


view : Model -> Html Msg
view model =
    div
        [ style [ ( "padding", "2rem" ) ] ]
        [ text ("Current count: " ++ toString model.count)
          {- We construct the instances of the Button component that we need, one
             for the increase button, one for the reset button. First, the increase
             button. The first three arguments are:

               - A Msg constructor (`Mdl`), lifting Mdl messages to the Msg type.
               - An instance id (the `[0]`). Every component that uses the same model
                 collection (model.mdl in this file) must have a distinct instance id.
               - A reference to the elm-mdl model collection (`model.mdl`).

             Notice that we do not have to add fields for the increase and reset buttons
             separately to our model; and we did not have to add to our update messages
             to handle their internal events.

             Mdl components are configured with `Options`, similar to `Html.Attributes`.
             The `Options.onClick Increase` option instructs the button to send the `Increase`
             message when clicked. The `css ...` option adds CSS styling to the button.
             See `Material.Options` for details on options.
          -}
        , Button.render Mdl
            [ 0 ]
            model.mdl
            [ Options.onClick Increase
            , css "margin" "0 24px"
            ]
            [ text "Increase" ]
        , Button.render Mdl
            [ 1 ]
            model.mdl
            [ Options.onClick Reset ]
            [ text "Reset" ]
        ]
        |> Material.Scheme.top



-- Load Google Mdl CSS. You'll likely want to do that not in code as we
-- do here, but rather in your master .html file. See the documentation
-- for the `Material` module for details.


main : Program Never Model Msg
main =
    Html.program
        { init = ( model, Cmd.none )
        , view = view
        , subscriptions = always Sub.none
        , update = update
        }

```

Nun starten wir den Elm reactor.
```bash
$ elm reactor
```

Im Browser öffnen wir die Seite [http://localhost:8000](http://localhost:8000) und klicken auf den Link `Main.elm`.

Nun nutzen wir das MDL-Layout.
Dazu fügen wir der Importliste  folgendes hinzu:
```Elm
import Material.Layout as Layout
```

Die Zeilen
```Elm
view : Model -> Html Msg
view model =
``` 
wird geändert zu:
```Elm
viewBody : Model -> Html Msg
viewBody model =
```
Dann  fügen wird den Header hinzu.
```Elm
view : Model -> Html Msg
view model =
    Layout.render Mdl
        model.mdl
        [ Layout.fixedHeader
        ]
        { header = [ h1 [ style [ ( "padding", "2rem" ) ] ] [ text "Counter" ] ]
        , drawer = []
        , tabs = ( [], [] )
        , main = [ viewBody model ]
        }
```

Jetzt fügen  wir noch tabs hinzu.
```Elm
# , tabs = ( [], [] ) ändern zu
, tabs = ( [ text "Milk", text "Oranges" ], [] )
```

Die Tabs haben noch kkeine Funktion.
Dem Typ `Msg` fügen wir `| SelectTab In` hinzu.
```Elm {class: line-numbers}
type Msg
    = Increase
    | Reset
    | Mdl (Material.Msg Msg)
    -- Hinzufügen
    | SelectTab Int
```

In Model fügen wir `, Layout.onSelectTab SelectTa` hinzu.
```Elm
view : Model -> Html Msg
view model =
    Layout.render Mdl
        model.mdl
        [ Layout.fixedHeader
        -- Hinzufügen
        , Layout.onSelectTab SelectTab
        ]
```

Und im update fügen wir vorläufig eine Debugmeldung ein. Die Browserkonsole zeigt dann an, welcher Tab angeklickt wurde.

```Elm
update msg model =
    case msg of
        ...
        -- Hinzufügen
        SelectTab num ->
            let
                _ =
                    Debug.log "SelectTab: " num
            in
                model ! []
```

Nun ändern wir den Code für die Tabauswahl

```Elm
type alias Model =
    { count : Int
... -- Hinzufügen
    , selectedTab : Int
    }
```

```Elm
model : Model
model =
... -- Hinzufügen
    , selectedTab = 0
    }
```

In `update` ändern wir die Debugausgabe zu
```Elm
SelectTab num ->
            { model | selectedTab = num } ! []
```

Die View `viewBody` benennen wir `viewCounter`
```Elm
viewCounter : Model -> Html Msg
viewCounter model =
    -- ...
```
Und fügen eine neue View hinzu.
```Elm
viewBody : Model -> Html Msg
viewBody model =
    case model.selectedTab of
        0 ->
            viewCounter model

        1 ->
            text "something else"

        _ ->
            text "404"
```

Jetzt ist MDL aber nur in einer Tabview. Deshalb verschieben wir das MDL-Schema
in die Hauptview.
Vom `viewCounter`ende die Zeile `|> Material.Scheme.top` entfernen
```Elm
viewCounter : Model -> Html Msg
viewCounter model =
...
        |> Material.Scheme.top
```

und am Anfang der View einfügen
```Elm
view : Model -> Html Msg
view model =
    Material.Scheme.top <|
        Layout.render Mdl
            -- ...
```


### Farben

Zuerst importieren wir `Color`mit
```Elm
import Material.Color as Color
```

Mit der  `Material.Scheme.topWithScheme` Funktion weisen wir ein Farbschema zu. 

```Elm
view : Model -> Html Msg
view model =
    Material.Scheme.topWithScheme Color.Teal Color.LightGreen <|
        Layout.render Mdl
            -- ...
```

Das Layout soll auch wissen welcher Tab slektiert wurde. In der View fügen wir `, Layout.selectedTab model.selectedTa` hinzu.
```
view : Model -> Html Msg
view model =
...
            , Layout.selectedTab model.selectedTab
            , Layout.onSelectTab SelectTab
...
```
Der Selektierte Tab wir nun hervorgehoben.

Dem zweiten Element unseres Tabtuples fügen wir nun einige Styles hinzu.
```Elm
, tabs = ( [ text "Milk", text "Oranges" ], [Color.background (Color.color Color.Teal Color.S400)] )
```

### Jetzt ohne Counterbeispiel

Zwei Views. Für die Startseite und sie Aboutseite.

```Elm
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
```

### Die Indexseite

In `Main.elm` ändern wir die erste Ziele in `module MeineHomepage exposing (..)`. Danach
änder wir den Dateinamen zu `MeineHomepage.elm`.

Dann erzeugen wir die Datei `index.html` mit folgendem Inhalt.

```html
<!doctype html>
<html>
    <head>
        <style>
            body { background-color: rgb(44, 44, 44); color: white; }
            img { border: 1px solid white; margin: 5px; }
            .large { width: 500px; float: right; }
            .selected { margin: 0; border: 6px solid #60b5cc; }
            .content { margin: 40px auto; width: 960px; }
            #thumbnails { width: 440px; float: left }
            h1 { font-family: Verdana; color: #60b5cc; }
        </style>
    </head>

    <body>
        <div id="elm-area"></div>

        <script src="elm.js"></script>
        <script>
            Elm.MeineHomepage.embed(document.getElementById("elm-area"));
        </script>
    </body>
</html>
```

#### elm.js erzeugen

Die Seite `index.html` benötigt die kompilierte elm Datei `elm.js`.

```bash
$ elm-make MeineHomepage.elm --output elm.js
```


