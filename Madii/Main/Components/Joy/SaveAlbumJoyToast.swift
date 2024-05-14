//
//  SaveAlbumJoyToast.swift
//  Madii
//
//  Created by 정태우 on 5/11/24.
//

import SwiftUI

struct SaveAlbumJoyToast: View {
    var transitionEdge: Edge = .bottom
    var albumName: String
    
    var body: some View {
        HStack {
            Text("소확행이 \(albumName)에 저장되었어요")
                .madiiFont(font: .madiiBody4, color: .black)
            
            Spacer()
            
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 12)
        .frame(height: 40)
        .background(Color.white)
        .cornerRadius(6)
        .padding(.horizontal, 16)
        .offset(y: -20)
        .transition(.move(edge: transitionEdge))
    }
}
