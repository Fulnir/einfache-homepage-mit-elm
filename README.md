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

