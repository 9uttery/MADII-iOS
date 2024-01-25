//
//  MadiiTextField.swift
//  Madii
//
//  Created by 이안진 on 1/12/24.
//

import SwiftUI

struct MadiiTextField: View {
    let placeHolder: String
    @Binding var text: String
    
    var strokeColor: Color = .gray700
    
    var limit: Int = 0
    var limitText: Bool { limit != 0 }

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                TextField(placeHolder, text: $text, axis: .vertical)
                    .madiiFont(font: .madiiBody3, color: .white)
                    .onChange(of: text, perform: {
                        if limitText {
                            text = String($0.prefix(limit))
                        }
                    })
                
                Spacer()
                
                if limitText {
                    Text("\(text.count)/\(limit)")
                        .madiiFont(font: .madiiBody3, color: .gray500)
                }
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 12)
        }
        .background(Color(red: 0.21, green: 0.22, blue: 0.29))
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .inset(by: 1)
                .stroke(strokeColor, lineWidth: 1)
        )
    }
}
