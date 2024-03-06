//
//  AddTodayPlaylistBarToast.swift
//  Madii
//
//  Created by 이안진 on 3/6/24.
//

import SwiftUI

struct AddTodayPlaylistBarToast: View {
    @Binding var showTodayPlaylist: Bool
    var transitionEdge: Edge = .bottom
    
    var body: some View {
        HStack {
            Text("오늘의 플레이리스트에 추가되었어요")
                .madiiFont(font: .madiiBody4, color: .black)
            
            Spacer()
            
            Button {
                showTodayPlaylist = true
            } label: {
                Text("바로가기")
                    .madiiFont(font: .madiiBody4, color: .madiiOrange)
                    .padding(.horizontal, 8)
            }
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
