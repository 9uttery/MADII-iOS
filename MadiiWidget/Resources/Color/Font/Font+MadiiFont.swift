//
//  Font+MadiiFont.swift
//  MadiiDesignSystem
//
//  Created by Anjin on 2/1/25.
//

import SwiftUI

extension Font {
    enum MadiiFont {
        case regular
        case bold
        
        var weight: String {
            switch self {
            case .regular:
                return "SpoqaHanSansNeo-Regular"
            case .bold:
                return "SpoqaHanSansNeo-Bold"
            }
        }
    }

    static func spoqaHanSansNeo(weight: MadiiFont, size: CGFloat) -> Font {
        return .custom(weight.weight, size: size)
    }
}

public extension Font {
    static var madiiTitle: Font { Font.spoqaHanSansNeo(weight: .bold, size: 20) } // line height: -
    static var madiiSubTitle: Font { Font.spoqaHanSansNeo(weight: .bold, size: 18) } // line height: -
    
    static var madiiBody1: Font { Font.spoqaHanSansNeo(weight: .bold, size: 16) } // line height: -
    static var madiiBody2: Font { Font.spoqaHanSansNeo(weight: .regular, size: 16) } // line height: -
    static var madiiBody3: Font { Font.spoqaHanSansNeo(weight: .regular, size: 15) } // line height: 140%
    static var madiiBody4: Font { Font.spoqaHanSansNeo(weight: .regular, size: 12) } // line height: 20
    static var madiiBody5: Font { Font.spoqaHanSansNeo(weight: .bold, size: 12) } // line height: 20
    
    static var madiiCaption: Font { Font.spoqaHanSansNeo(weight: .regular, size: 10) } // line height: 16
    
    static var madiiCalendar: Font { Font.spoqaHanSansNeo(weight: .regular, size: 20)} // line height: 140%
}
