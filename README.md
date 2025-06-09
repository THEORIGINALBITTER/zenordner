# Ordnerfarben auf macOS ändern – ganz einfach mit unserer App!

Jeder macOS-Nutzer kennt das Problem: Die Standard-Ordnerfarbe ist immer gleich und lässt sich nicht so einfach anpassen. Dabei wäre es oft praktisch, wichtige Ordner farblich hervorzuheben oder einfach optisch zu ordnen.

Wir haben eine **einfach zu bedienende App** entwickelt, mit der du genau das machen kannst:

- **Ordnerfarben auf macOS ändern**  
- **Optional ein individuelles Logo / Icon zum Ordner hinzufügen**  
- Alles läuft **nativ in Swift** – schnell, schlank und sicher  
- Einfach als eigenständige App, ohne komplizierte Einstellungen oder Terminal-Befehle  

So kannst du deine Ordner personalisieren und besser organisieren – direkt per Drag & Drop oder mit wenigen Klicks.

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

## Tipps zur Weiterentwicklung

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

## Beispiel: IconGenerator.swift

```swift
import Cocoa

struct IconGenerator {
    
    /// Erstellt ein NSImage mit einer farbigen Hintergrundfläche und optional einem Logo (Asset oder Datei)
    /// - Parameters:
    ///   - color: Hintergrundfarbe (NSColor)
    ///   - logoURL: URL zum Logo (optional)
    ///   - assetIconName: Name des Asset-Icons (optional)
    /// - Returns: NSImage für Ordnericon oder nil bei Fehler
    static func makeIcon(color: NSColor, logoURL: URL? = nil, assetIconName: String? = nil) -> NSImage? {
        
        let size = NSSize(width: 512, height: 512)
        let image = NSImage(size: size)
        
        image.lockFocus()
        
        // Hintergrund mit Farbe füllen (rund oder rechteckig)
        let rect = NSRect(origin: .zero, size: size)
        color.setFill()
        let path = NSBezierPath(roundedRect: rect, xRadius: 80, yRadius: 80)
        path.fill()
        
        // Logo laden (Asset oder Datei)
        var logoImage: NSImage? = nil
        
        if let assetName = assetIconName {
            logoImage = NSImage(named: NSImage.Name(assetName))
        } else if let url = logoURL {
            logoImage = NSImage(contentsOf: url)
        }
        
        // Logo zeichnen, mittig und skaliert
        if let logo = logoImage {
            let maxLogoSize = NSSize(width: 256, height: 256)
            let aspectRatio = min(maxLogoSize.width / logo.size.width, maxLogoSize.height / logo.size.height)
            let logoSize = NSSize(width: logo.size.width * aspectRatio, height: logo.size.height * aspectRatio)
            
            let logoOrigin = NSPoint(
                x: (size.width - logoSize.width) / 2,
                y: (size.height - logoSize.height) / 2
            )
            
            logo.draw(in: NSRect(origin: logoOrigin, size: logoSize),
                      from: .zero,
                      operation: .sourceOver,
                      fraction: 1.0,
                      respectFlipped: true,
                      hints: nil)
        }
        
        image.unlockFocus()
        return image
    }
}




Bei Interesse oder Feedback einfach melden!  
Freue mich auf dein Feedback :)




