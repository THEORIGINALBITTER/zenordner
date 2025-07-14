# Ordner in Farben legen  – ganz einfach mit ZenOrdner
---
<img width="748" height="301" alt="Bildschirmfoto 2025-07-14 um 08 58 55" src="https://github.com/user-attachments/assets/4c9c1cca-e33c-4352-8b17-01cef54f5b20" />

---

Jeder macOS-Nutzer kennt das Problem: Die Standard-Ordnerfarbe ist immer gleich und lässt sich nicht so einfach anpassen. Dabei wäre es oft praktisch, wichtige Ordner farblich hervorzuheben oder einfach optisch zu ordnen.

Wir haben eine **einfach zu bedienende App** entwickelt, mit der du genau das machen kannst:

- **Ordnerfarben auf macOS ändern** 

- **Optional ein individuelles Logo / Icon zum Ordner hinzufügen**  
- Alles läuft **nativ in Swift** – schnell, schlank und sicher  
- Einfach als eigenständige App, ohne komplizierte Einstellungen oder Terminal-Befehle  

So kannst du deine Ordner personalisieren und besser organisieren – direkt per Drag & Drop oder mit wenigen Klicks.

---

<img width="1124" height="1005" alt="Bildschirmfoto 2025-07-14 um 08 55 02" src="https://github.com/user-attachments/assets/d0f13d9a-c383-40b3-b2aa-c0f92689f713" />

---

### Warum unsere App?

- Keine komplizierten Workarounds mehr  
- Farben und Logos direkt am Ordner sichtbar  
- Nativ und performant dank Swift  

Probiere es aus und bring mehr Farbe in deinen Mac-Alltag!

---



---

## Beschreibung der wichtigsten Teile

- **Assets.xcassets**  
  Enthält alle Icon-Bilder, die als Ordnerlogos verwendet werden. Die `assetIcons`-Liste referenziert diese Namen.

- **IconGenerator.swift**  
  Zentrale Logik, die aus einer Farbe und einem optionalen Logo (Asset oder Datei) ein NSImage erstellt, das als Ordnericon gesetzt wird.

- **Views/ContentView.swift**  
  Haupt-UI mit:  
  - Drag & Drop für Ordnerauswahl  
  - ColorPicker für die Ordnerfarbe  
  - Picker zur Icon-Auswahl mit Live-Vorschau  
  - Buttons zum Anwenden und Rücksetzen des Icons

- **Views/IconPickerView.swift** (optional)  
  Eigene View zur modularen Icon-Auswahl (z.B. als Menü oder Grid).

- **Models/**  
  Für wachsende Komplexität können hier Datenmodelle ausgelagert werden (z.B. FolderModel).

- **LerneEinfachFolderColorApp.swift**  
  App-Einstiegspunkt mit `@main`-Annotation, der die App initialisiert und `ContentView` zeigt.

---

## Entwickllung zur Weiterentwicklung und was noch geplant ist.

- **Modularisierung**  
  UI in einzelne Views & Komponenten aufteilen (Drag&Drop, ColorPicker, IconPicker).

- **MVVM-Pattern**  
  Einführung von ViewModels zur Trennung von Logik und UI.

- **Dynamische Icon-Assets**  
  Laden von Icons aus dem Dateisystem oder externen Quellen zusätzlich zu den Assets.

- **Erweiterte Farb- und Icon-Presets**  
  Benutzerdefinierte Paletten oder Icon-Sammlungen.

- **Verbessertes Feedback**  
  Statusmeldungen, Ladeindikatoren oder Alerts zur besseren Nutzerführung.

---

<img width="1310" height="863" alt="Bildschirmfoto 2025-07-14 um 08 56 33" src="https://github.com/user-attachments/assets/7d795eab-6e12-4b20-a68b-e81c860a7aa9" />

---

<img width="1310" height="863" alt="Bildschirmfoto 2025-07-14 um 08 56 52" src="https://github.com/user-attachments/assets/95b53943-776d-49c0-adea-160e4b24e3e0" />

---

<img width="748" height="301" alt="Bildschirmfoto 2025-07-14 um 08 58 55" src="https://github.com/user-attachments/assets/4601aedd-7962-4329-97cb-e0406911e066" />







