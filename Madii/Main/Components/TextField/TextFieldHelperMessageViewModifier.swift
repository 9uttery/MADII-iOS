//
//  TextFieldHelperMessageViewModifier.swift
//  Madii
//
//  Created by 이안진 on 1/12/24.
//

import SwiftUI

struct TextFieldHelperMessageViewModifier: ViewModifier {
    let text: String
    var color: Color
    
    func body(content: Content) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            content
            
            Text(text)
                .madiiFont(font: .madiiBody4, color: color)
        }
    }
}

extension View {
    func textFieldHelperMessage(_ text: String, color: Color) -> some View {
        modifier(TextFieldHelperMessageViewModifier(text: text, color: color))
    }
    
    func hideKeyboard() {
      UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
