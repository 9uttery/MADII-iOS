//
//  View+madiiFont.swift
//  MadiiDesignSystem
//
//  Created by Anjin on 2/1/25.
//

import SwiftUI

struct MadiiFontModifier: ViewModifier {
    let font: Font
    let color: Color
    
    var withHeight: Bool = false
    let heightFor: [Font: CGFloat] = [
        Font.madiiBody3: 21,
        Font.madiiBody4: 20,
        Font.madiiBody5: 20,
        Font.madiiCaption: 16,
        Font.madiiCalendar: 28
    ]
    
    func body(content: Content) -> some View {
        if withHeight {
            content
                .font(font)
                .foregroundColor(color)
                .frame(height: heightFor[font])
        } else {
            content
                .font(font)
                .foregroundColor(color)
        }
    }
}

public extension View {
    func madiiFont(font: Font, color: Color) -> some View {
        modifier(MadiiFontModifier(font: font, color: color))
    }
    
    func madiiFont(font: Font, color: Color, withHeight: Bool) -> some View {
        modifier(MadiiFontModifier(font: font, color: color, withHeight: withHeight))
    }
}
