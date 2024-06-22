//
//  TextFieldLabelViewModifier.swift
//  Madii
//
//  Created by Anjin on 6/11/24.
//

import SwiftUI

struct TextFieldLabelViewModifier: ViewModifier {
    let text: String
    
    func body(content: Content) -> some View {
        VStack(alignment: .leading, spacing: 14) {
            Text(text)
                .madiiFont(font: .madiiTitle, color: .white)
                .padding(.vertical, 10)
            
            content
        }
    }
}

extension View {
    func textFieldLabel(_ text: String) -> some View {
        modifier(TextFieldLabelViewModifier(text: text))
    }
}
