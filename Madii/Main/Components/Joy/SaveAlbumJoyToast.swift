//
//  SaveAlbumJoyToast.swift
//  Madii
//
//  Created by 정태우 on 5/11/24.
//

import SwiftUI

struct SaveAlbumJoyToast: View {
    var transitionEdge: Edge = .bottom
    var yOffset: Int = -20
    
    var body: some View {
        HStack {
            Text("소확행이 앨범에 저장되었어요")
                .madiiFont(font: .madiiBody4, color: .black)
            
            Spacer()
            
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 12)
        .frame(height: 40)
        .background(Color.white)
        .cornerRadius(6)
        .padding(.horizontal, 16)
        .offset(y: CGFloat(yOffset))
        .transition(.move(edge: transitionEdge))
    }
}
