//
//  ConfettiType.swift
//  PracticeAnimation
//
//  Created by 이안진 on 12/21/23.
//

import SwiftUI

public enum ConfettiType: CaseIterable, Hashable {
    public enum Shape {
        case circle
        case triangle
        case square
        case slimRectangle
        case roundedCross
    }
    
    case shape(Shape)
    case text(String)
    case sfSymbol(symbolName: String)
    
    public var view: AnyView {
        switch self {
        case .shape(.square):
            return AnyView(Rectangle())
        case .shape(.triangle):
            return AnyView(Triangle())
        case .shape(.slimRectangle):
            return AnyView(SlimRectangle())
        case .shape(.roundedCross):
            return AnyView(RoundedCross())
        case let .text(text):
            return AnyView(Text(text))
        case .sfSymbol(let symbolName):
            return AnyView(Image(systemName: symbolName))
        default:
            return AnyView(Circle())
        }
    }
    public static var allCases: [ConfettiType] {
        return [.shape(.circle), .shape(.triangle), .shape(.square), .shape(.slimRectangle), .shape(.roundedCross)]
    }
}
