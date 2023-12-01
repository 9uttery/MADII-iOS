//
//  RoundBoxBackground.swift
//  Madii
//
//  Created by 이안진 on 11/30/23.
//

import SwiftUI

struct RoundBoxBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            // FIXME: Color System에 없는 색상 -> 추후 추가해서 넣기
            .background(Color(red: 0.1, green: 0.1, blue: 0.15))
            .cornerRadius(20)
    }
}

extension View {
    func roundBackground() -> some View {
        modifier(RoundBoxBackground())
    }
}
