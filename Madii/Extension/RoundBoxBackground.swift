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
            .background(Color.madiiBox)
            .cornerRadius(20)
    }
}

extension View {
    func roundBackground() -> some View {
        modifier(RoundBoxBackground())
    }
}
