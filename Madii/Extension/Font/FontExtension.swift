//
//  FontExtension.swift
//  Madii
//
//  Created by 이안진 on 11/28/23.
//

import Foundation
import SwiftUI

/*
 
 프로젝트에 설치된 폰트를 확인하는 방법
 
 for fontFamily in UIFont.familyNames {
     for fontName in UIFont.fontNames(forFamilyName: fontFamily) {
         print(fontName)
     }
 }
 
 */


/*
 
 Info.plist 추가
 
 Key: Fonts provided by application
 Value:
    Item 0: Pretendard-Medium.otf
    Item 1: Pretendard-SemiBold.otf
 
 */

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

extension Font {
    static var madiiTitle: Font { Font.spoqaHanSansNeo(weight: .bold, size: 20) } // line height: -
    static var madiiSubTitle: Font { Font.spoqaHanSansNeo(weight: .bold, size: 18) } // line height: -
    
    static var madiiBody1: Font { Font.spoqaHanSansNeo(weight: .bold, size: 16) } // line height: -
    static var madiiBody2: Font { Font.spoqaHanSansNeo(weight: .regular, size: 16) } // line height: -
    static var madiiBody3: Font { Font.spoqaHanSansNeo(weight: .regular, size: 15) } // line height: 140%
    static var madiiBody4: Font { Font.spoqaHanSansNeo(weight: .regular, size: 12) } // line height: 20
    
    static var madiiCaption: Font { Font.spoqaHanSansNeo(weight: .regular, size: 10) } // line height: 16
}
