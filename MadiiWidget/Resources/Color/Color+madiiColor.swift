//
//  Color+madiiColor.swift
//  MadiiDesignSystem
//
//  Created by Anjin on 2/1/25.
//

import SwiftUI

public extension Color {
    static var madiiYellowGreen: Color {
        return Color(red: 0.81, green: 0.98, blue: 0.32)
    }
    
    init(hex: String) {
        var hex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hex = hex.replacingOccurrences(of: "#", with: "")
        
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        
        let red, green, blue: Double
        switch hex.count {
        case 6: // RGB (예: "0E152C")
            red = Double((int >> 16) & 0xFF) / 255
            green = Double((int >> 8) & 0xFF) / 255
            blue = Double(int & 0xFF) / 255
        default:
            red = 0; green = 0; blue = 0
        }
        self.init(red: red, green: green, blue: blue)
    }
}
