//
//  SaveJoyToast.swift
//  Madii
//
//  Created by 이안진 on 12/11/23.
//

import SwiftUI

struct SaveJoyToast: View {
    var transitionEdge: Edge = .bottom
    
    var body: some View {
        HStack {
            Text("기록되었어요.")
                .madiiFont(font: .madiiBody4, color: .black)
            
            Spacer()
            
            Button {
                
            } label: {
                Text("앨범 저장")
                    .madiiFont(font: .madiiBody4, color: .madiiOrange)
                    .padding(.horizontal, 8)
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 12)
        .background(Color.white)
        .cornerRadius(6)
        .padding(.horizontal, 16)
        .offset(y: -20)
        .transition(.move(edge: transitionEdge))
    }
}
