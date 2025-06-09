//
//  IconPickerView.swift
//  ZenOrdnerColor
//
//  Created by Denis Bitter by Bitter- Lern Einfach on 29.05.25.
//
//  Custom Picker mit Icon Vorschau
//
//  Template by ZenOrdnerColor

import SwiftUI

struct IconPickerView: View {
    let availableIcons: [String]
    @Binding var selectedIcon: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Icon auswählen")
                .font(.caption)
            
            Menu {
                // kein Icon
                Button(action: {
                    selectedIcon = nil
                }) {
                    Label("kein Icon", systemImage: "xmark.circle")
                }
                
                // Icon aus Assets holen
                ForEach(availableIcons, id: \.self) { iconName in
                    Button(action: {
                        selectedIcon = iconName
                    }) {
                        Label(iconName, systemImage: iconName)
                    }
                }
                
            } label: {
                Text(selectedIcon ?? "Icon wählen")
            }
        }
    }
}
