//
//  View+MadiiFont.swift
//  Madii
//
//  Created by 정태우 on 6/6/25.
//

import SwiftUI

enum MadiiFontType {
    case title1
    case title2
    case subTitle
    case body1
    case body2
    case body3
    case caption
    
    var fontName: SpoqaHanSansNeoWeight {
        switch self {
        case .title1, .title2, .subTitle, .body1: return .bold
        case .body2, .body3, .caption: return .medium
        }
    }
    
    var fontSize: CGFloat {
        switch self {
        case .title1: return 24
        case .title2: return 20
        case .subTitle: return 18
        case .body1, .body2: return 16
        case .body3: return 14
        case .caption: return 12
        }
    }
    
    var lineHeight: CGFloat {
        switch self {
        case .title1, .title2, .subTitle: return 150
        case .body1, .body2, .body3, .caption: return 160
        }
    }
}

enum SpoqaHanSansNeoWeight: String {
    case bold = "SpoqaHanSansNeo-Bold"
    case medium = "SpoqaHanSansNeo-Medium"
}

extension View {
    /// 뷰에 madiiFont 메소드를 활용하여 폰트를 지정합니다.
    func madiiFont(_ type: MadiiFontType) -> some View {
        let font = UIFont(name: type.fontName.rawValue, size: type.fontSize) ?? UIFont.systemFont(ofSize: type.fontSize)
        let calculatedLineHeight = type.fontSize * (type.lineHeight / 100)
        let lineSpacing = max(0, calculatedLineHeight - font.lineHeight)
        let verticalPadding = max(0, lineSpacing / 2)
        
        return self
            .font(Font(font))
            .lineSpacing(lineSpacing)
            .padding(.vertical, verticalPadding)
    }
}
