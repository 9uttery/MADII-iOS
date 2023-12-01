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

struct RoundBoxBackgroundWithTitle: ViewModifier {
    let title: String
    var bottomPadding: CGFloat = 20
    
    func body(content: Content) -> some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(title)
                .madiiFont(font: .madiiSubTitle, color: .white)
            
            content
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .padding(.bottom, bottomPadding)
        .background(Color.madiiBox)
        .cornerRadius(20)
    }
}

extension View {
    func roundBackground() -> some View {
        modifier(RoundBoxBackground())
    }
    
    func roundBackground(_ title: String) -> some View {
        modifier(RoundBoxBackgroundWithTitle(title: title))
    }
    
    func roundBackground(_ title: String, bottomPadding: CGFloat) -> some View {
        modifier(RoundBoxBackgroundWithTitle(title: title, bottomPadding: bottomPadding))
    }
}
