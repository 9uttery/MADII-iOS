//
//  HomeView.swift
//  Madii
//
//  Created by 이안진 on 11/29/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appStatus: AppStatus
    @Binding var updatePlaylistBar: Bool /// 플리바 업데이트
    @State private var showTodayPlaylist: Bool = false /// 오플리 sheet 열기

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
            
            // 오플리 추가 안내 토스트
            if appStatus.showAddPlaylistToast {
                AddTodayPlaylistBarToast(showTodayPlaylist: $showTodayPlaylist) }
            
            if appStatus.isDuplicate {
                JoyDuplicateToast() }
        }
        .navigationTitle("")
        // 오늘의 소확행 오플리에 추가 후, 바로가기에서 sheet
        .sheet(isPresented: $showTodayPlaylist) {
            TodayPlaylistView(showPlaylist: $showTodayPlaylist) }
    }
}
