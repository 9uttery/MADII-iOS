//
//  GradientBorder.swift
//  Madii
//
//  Created by 정태우 on 8/30/25.
//

import Foundation
import SwiftUI

struct GradientBorder: ViewModifier {
    let hexColors: [String]
    let lineWidth: CGFloat
    let cornerRadius: CGFloat
    let startPoint: UnitPoint
    let endPoint: UnitPoint
    let opacity: Double
    
    func body(content: Content) -> some View {
        content
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(
                        LinearGradient(
                            gradient: Gradient(colors: hexColors.map { Color(hex: $0) }),
                            startPoint: startPoint,
                            endPoint: endPoint
                        ),
                        lineWidth: lineWidth
                    ).opacity(opacity)
        )
    }
}

extension View {
    func gradientBorder(
        hexColors: [String],
        lineWidth: CGFloat = 1,
        cornerRadius: CGFloat = 12,
        startPoint: UnitPoint = .leading,
        endPoint: UnitPoint = .trailing,
        opacity: Double = 1.0
    ) -> some View {
        self.modifier(
            GradientBorder(
                hexColors: hexColors,
                lineWidth: lineWidth,
                cornerRadius: cornerRadius,
                startPoint: startPoint,
                endPoint: endPoint,
                opacity: opacity
            )
        )
    }
}

extension Color {
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
