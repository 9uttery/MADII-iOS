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
    
    var body: some View {
        HStack {
            Text(title)
                .madiiFont(font: .madiiBody4, color: .black)
            Spacer()
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .frame(height: 40)
        .background(Color.white)
        .cornerRadius(6)
        .offset(y: -20)
        .transition(.move(edge: transitionEdge))
    }
}
