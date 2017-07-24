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

## Material Design

```bash  {class: line-numbers}
# Das Elm MDL Package laden
$ elm package install -y debois/elm-mdl
```

