//
//  MadiiButton.swift
//  MadiiDesignSystem
//
//  Created by 정태우 on 6/20/25.
//

import SwiftUI

public enum ButtonColor {
    case neutral, mainColor, opacity, violet, red
}

public enum ButtonSize {
    case large, medium, small
}

public struct MadiiButton: View {
    public let title: String
    public let color: ButtonColor
    public let type: ButtonSize
    public let action: (() -> Void)?
    
    public init(title: String, color: ButtonColor, type: ButtonSize = .large, action: (() -> Void)? = nil) {
        self.title = title
        self.color = color
        self.type = type
        self.action = action
    }
    
    public var body: some View {
        Button {
            action?()
        } label: {
            Text(title)
                .madiiFont(font())
                .frame(maxWidth: .infinity)
                .foregroundStyle(foregroundColor())
                .padding(.vertical, verticalPadding())
                .padding(.horizontal, horizontalPadding())
                .background(backgroundColor())
                .cornerRadius(16)
        }
    }
    
    func font() -> MadiiFontType {
        switch type {
        case .large: return .subTitle
        case .medium: return .body2
        case .small: return .body3
        }
    }
    
    func backgroundColor() -> Color {
        switch color {
        case .neutral: return .madiiContrast
        case .mainColor: return .madiiGreen100
        case .opacity: return .madiiStrong.opacity(0.35)
        case .violet: return .madiiViolet
        case .red: return .madiiNegative
        }
    }
    
    func foregroundColor() -> Color {
        switch color {
        case .neutral, .opacity, .violet, .red: return .madiiStrong
        case .mainColor: return .madiiContrast
        }
    }
    
    func verticalPadding() -> CGFloat {
        switch type {
        case .large: 16
        case .medium: 8
        case .small: 4
        }
    }
    
    func horizontalPadding() -> CGFloat {
        switch type {
        case .large: 24
        case .medium: 20
        case .small: 12
        }
    }
}
