//
//  ToastMessage.swift
//  Madii
//
//  Created by Anjin on 4/29/24.
//

import SwiftUI

struct ToastMessage: View {
    var transitionEdge: Edge = .bottom
    let title: String
    enum ToastColor { case white, orange }
    var color: ToastColor = .white
    
    var body: some View {
        HStack {
            Text(title)
                .madiiFont(font: getFont(), color: getFontColor())
            Spacer()
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .frame(height: 40)
        .background(getBackgroundColor())
        .cornerRadius(6)
        .offset(y: -20)
        .transition(.move(edge: transitionEdge))
    }
    
    private func getFont() -> Font {
        switch color {
        case .white: .madiiBody4
        case .orange: .madiiBody5
        }
    }
    
    private func getFontColor() -> Color {
        switch color {
        case .white: .black
        case .orange: .white
        }
    }
    
    private func getBackgroundColor() -> Color {
        switch color {
        case .white: .white
        case .orange: Color.madiiOrange
        }
    }
}
