import SwiftUI
import UniformTypeIdentifiers


struct ContentView: View {
    @State private var folderURL: URL?
    @State private var selectedAssetIconName: String? = nil
    @State private var selectedColor: Color = .blue
    @State private var logoURL: URL?
    @State private var statusMessage: String = "Ordner hierher ziehen"
    
     // Assets Name um aus der Biblohtek zuzugreifen
    // Frage wie könnte man selfIcon hinzufügen eine Idee muss her
    let assetIcons = ["c4d-min", "blender-min", "react-min", "code-min", "2d-min", "3d-min", "cc3-min", "ae-min" ]


    var body: some View {
        VStack(spacing: 20) {
            Text(statusMessage)
                .font(.headline)

            // Drop-Zone
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [5]))
                    .frame(height: 100)
                    .foregroundColor(.gray.opacity(0.5))

                Text("Ordner hierher ziehen")
                    .foregroundColor(.secondary)
            }
            .padding()
            .onDrop(of: [.fileURL], isTargeted: nil) { providers in
                providers.first?.loadItem(forTypeIdentifier: UTType.fileURL.identifier, options: nil) { item, _ in
                    if let data = item as? Data,
                       let url = URL(dataRepresentation: data, relativeTo: nil),
                       url.hasDirectoryPath {
                        DispatchQueue.main.async {
                            folderURL = url
                            statusMessage = "📁 \(url.lastPathComponent)"
                        }
                    }
                }
                return true
            }

            // Ordnerpfad anzeigen
            if let folder = folderURL {
                Text("Pfad: \(folder.path)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            ColorPicker("Ordnerfarbe", selection: $selectedColor)
                .padding(.horizontal)

            HStack {
                Button("Logo wählen…") {
                    let panel = NSOpenPanel()
                    panel.allowedFileTypes = ["png", "jpg", "jpeg"]
                    panel.canChooseDirectories = false
                    panel.canChooseFiles = true
                    panel.allowsMultipleSelection = false

                    panel.begin { response in
                        if response == .OK {
                            logoURL = panel.url
                        }
                    }
                }

                if let logo = logoURL {
                    Text(logo.lastPathComponent)
                        .font(.caption)
                }
            }
            
            // hier platzieren wir die Asset Auswahl der selectedAssetIconName AssetIcon
            Text ("wähle dein Icon aus der Liste")
                .font(.caption)
            
            Picker("Asset-Icon", selection: $selectedAssetIconName) {
                Text("kein Icon").tag(String?.none) // optional als Leer Eintrag

                ForEach(assetIcons, id: \.self) { iconName in
                    if let icon = NSImage(named: NSImage.Name(iconName)) {
                        Label {
                            Text(iconName)
                        } icon: {
                            Image(nsImage: icon)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 16, height: 16)
                        }
                        .tag(Optional(iconName))
                    } else {
                        Text(iconName).tag(Optional(iconName)) // Fallback
                    }
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding(.horizontal)

            
                   
        

            
            
            
            
            

            // 🖼️ Live-Vorschau
            if let preview = IconGenerator.makeIcon(color: NSColor(selectedColor), logoURL: logoURL, 
                                                    assetIconName: selectedAssetIconName) {
                VStack(spacing: 8) {
                    Text("Vorschau")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(NSColor.windowBackgroundColor))
                            .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 4)

                        Image(nsImage: preview)
                            .resizable()
                            .scaledToFit()
                            .padding(12)
                    }
                    .frame(width: 120, height: 120)

                    HStack(spacing: 8) {
                        Text("Farbe:")
                            .font(.caption2)
                        Circle()
                            .fill(selectedColor)
                            .frame(width: 16, height: 16)
                            .overlay(Circle().stroke(Color.black.opacity(0.2), lineWidth: 1))
                    }
                }
            }


            // Buttons
            HStack(spacing: 20) {
                Button("Einfärben") {
                    guard let folder = folderURL else { return }
                    applyIcon(to: folder)
                }
                .disabled(folderURL == nil)

                Button("Original wiederherstellen") {
                    guard let folder = folderURL else { return }
                    NSWorkspace.shared.setIcon(nil, forFile: folder.path, options: [])
                    statusMessage = "🔄 Original wiederhergestellt: \(folder.lastPathComponent)"
                }
                .disabled(folderURL == nil)
            }
        }
        .padding()
    }

    func applyIcon(to folder: URL) {
        let nsColor = NSColor(selectedColor)
        guard let image = IconGenerator.makeIcon(color: nsColor, logoURL: logoURL, assetIconName: selectedAssetIconName) else {

            statusMessage = "❌ Fehler beim Erstellen des Icons"
            return
        }

        NSWorkspace.shared.setIcon(image, forFile: folder.path, options: [])
        statusMessage = "✅ Icon angewendet: \(folder.lastPathComponent)"
    }
}

