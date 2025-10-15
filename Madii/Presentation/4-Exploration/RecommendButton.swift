//
//  RecommendButton.swift
//  Madii
//
//  Created by 정태우 on 8/29/25.
//

import SwiftUI

struct RecommendButton: View {
    let title: String
    var action: ((Bool) -> Void)?
    @State var isClicked: Bool = false
    
    var body: some View {
        Button {
            isClicked.toggle()
            action?(isClicked)
        } label: {
            Text(title)
                .madiiFont(font: .madiiBody2, color: isClicked ? .madiiContrast : .madiiStrong)
                .lineSpacing(9.6)
                .padding(.vertical, 8)
                .padding(.horizontal, 20)
                .background(isClicked ? .madiiGreen100 : .gray100.opacity(0.35))
                .cornerRadius(12)
        }
    }
}

#Preview {
    RecommendButton(title: "화창한 날씨", action: {_ in })
}
