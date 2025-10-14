//
//  Color+Ext.swift
//  MealsApp
//
//  Created by Nunu Nugraha on 13/08/25.
//

import SwiftUI

// MARK: - Color helpers
extension Color {
    init(hex: UInt32) {
        self.init(red: Double((hex>>16)&0xFF)/255,
                  green: Double((hex>>8)&0xFF)/255,
                  blue: Double(hex&0xFF)/255)
    }
}

let pastelPalette: [Color] = [
    Color(hex: 0xE8F5E9), Color(hex: 0xE3F2FD), Color(hex: 0xFFF3E0),
    Color(hex: 0xF3E5F5), Color(hex: 0xE0F7FA), Color(hex: 0xFFFDE7),
    Color(hex: 0xFCE4EC),
]

func tileColor(for key: String) -> Color {
    let h = abs(key.unicodeScalars.reduce(0) { ($0 &* 31) &+ Int($1.value) })
    return pastelPalette[h % pastelPalette.count]
}
