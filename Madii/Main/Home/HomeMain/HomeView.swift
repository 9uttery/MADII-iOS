//
//  HomeView.swift
//  Madii
//
//  Created by 이안진 on 11/29/23.
//

import SwiftUI

struct HomeView: View {
    @State private var showSaveJoyPopUp: Bool = false
    
    @Binding var updatePlaylistBar: Bool /// 플리바 업데이트

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 0) {
                Image("madiiLogo")
                    .resizable()
                    .frame(width: 160, height: 22)
                    .padding(.horizontal, 22)
                    .padding(.vertical, 12)

                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        HomeTodayJoyView(updatePlaylistBar: $updatePlaylistBar) // 오늘의 소확행
                        HomeRecommendView() // 나만의 취향저격 소확행
                        HomePlayJoyView() // 행복을 재생해요
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 40) // 하단 여백 40
                }
                .scrollIndicators(.never)
            }
        }
        .navigationTitle("")
    }
}
