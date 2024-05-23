//
//  TodayPlaylistNavigationBar.swift
//  Madii
//
//  Created by 이안진 on 2/21/24.
//

import SwiftUI

struct TodayPlaylistNavigationBar: View {
    @Binding var showPlaylist: Bool
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.madiiBox
            
            ZStack(alignment: .leading) {
                HStack {
                    Spacer()
                    Text("오늘의 플레이리스트")
                        .madiiFont(font: .madiiBody2, color: .white)
                    Spacer()
                }
                .padding(.vertical, 20)
                
                Button {
                    showPlaylist = false
                    AnalyticsManager.shared.logEvent(name: "오늘의플레이리스트뷰_오늘의플레이리스트내리기클릭")
                } label: {
                    Image(systemName: "chevron.down")
                }.padding(.leading, 20)
            }
        }
    }
}
