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
    var action: () -> Void

    var body: some View {
        Button {
            isClicked.toggle()
            action()
        } label: {
            Text(label)
                .madiiFont(font: .madiiBody3, color: .black)
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .background(isClicked ? Color.white : Color.white.opacity(0.4))
                .cornerRadius(90)
                .overlay(
                    isClicked ?
                        RoundedRectangle(cornerRadius: 90)
                            .stroke(Color.madiiYellowGreen, lineWidth: 1) :
                        nil
                )
        }
    }
}
