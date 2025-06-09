import Cocoa

struct IconGenerator {
    static func makeIcon(color: NSColor, logoURL: URL?, assetIconName: String?) -> NSImage? {
        guard let templateImage = NSImage(named: "folder_template") else {
            print("Template nicht gefunden.")
            return nil
        }

        let size = NSSize(width: 512, height: 512)
        let image = NSImage(size: size)

        image.lockFocus()
        NSGraphicsContext.saveGraphicsState()

        // 1) Template (Ordner-Grundbild)
        templateImage.draw(in: NSRect(origin: .zero, size: size),
                           from: .zero,
                           operation: .copy,
                           fraction: 1.0)

        // 2) Farbüberlagerung
        if let context = NSGraphicsContext.current {
            context.compositingOperation = .sourceAtop
            color.withAlphaComponent(0.4).set()
            NSBezierPath(rect: NSRect(origin: .zero, size: size)).fill()
            context.compositingOperation = .sourceOver
        }

        // 3) Logo laden (aus URL oder Asset)
        var logoImage: NSImage?
        if let url = logoURL {
            logoImage = NSImage(contentsOf: url)
        } else if let assetName = assetIconName {
            logoImage = NSImage(named: NSImage.Name(assetName))
        }

        // 4) Logo mit weißem Hintergrund platzieren
        if let logo = logoImage {
            let logoSize = NSSize(width: size.width * 0.4, height: size.height * 0.4)
            let logoOrigin = NSPoint(x: (size.width - logoSize.width) / 2,
                                     y: (size.height - logoSize.height) / 2)
            let logoRect = NSRect(origin: logoOrigin, size: logoSize)

            // Weißer Hintergrund
            NSColor.white.setFill()
            NSBezierPath(roundedRect: logoRect, xRadius: 32, yRadius: 32).fill()

            // Logo zeichnen
            logo.draw(in: logoRect,
                      from: .zero,
                      operation: .sourceOver,
                      fraction: 1.0)
        }

        NSGraphicsContext.restoreGraphicsState()
        image.unlockFocus()
        return image
    }
}

