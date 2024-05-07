//
//  StyleJoyButton.swift
//  Madii
//
//  Created by 정태우 on 12/24/23.
//

import SwiftUI

struct StyleJoyButton: View {
    var label: String
    @Binding var isClicked: Bool
    var buttonColor: Color
    var action: (() -> Void)?

    var body: some View {
        Button {
            isClicked.toggle()
            action?()
        } label: {
            HStack {
                Text(label)
                    .madiiFont(font: .madiiBody4, color: isClicked ? .black : .white)
                if isClicked {
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width: 8, height: 8)
                        .foregroundColor(.gray)
                }
            }
            .padding(.vertical, 10)
            .padding(.horizontal, isClicked ? 14 : 18)
            .background(isClicked ? Color.white : buttonColor.opacity(0.3))
            .cornerRadius(90)
        }
    }
}
