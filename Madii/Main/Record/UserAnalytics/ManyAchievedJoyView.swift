//
//  ManyAchievedJoyView.swift
//  Madii
//
//  Created by 이안진 on 12/1/23.
//

import SwiftUI

struct ManyAchievedJoyView: View {
    @EnvironmentObject var appStatus: AppStatus
    @State private var joys: [Joy] = []
    @State private var selectedJoy: Joy?
    
    @State private var showTodayPlaylist: Bool = false /// 오플리 sheet 열기
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
            if joys.isEmpty {
                emptyView
            } else {
                ScrollView {
                    VStack(alignment: .center, spacing: 32) {
                        // 1등
                        Button {
                            selectedJoy = joys[0]
                        } label: {
                            firstRank
                        }
                        
                        if joys.count > 1 {
                            // 2등 ~ 5등
                            VStack(spacing: 16) {
                                let count = joys.count
                                ForEach(0 ..< count, id: \.self) { index in
                                    if index > 0 {
                                        joyRow(index: index, joy: joys[index])
                                    }
                                }
                            }
                            .roundBackground(bottomPadding: 32)
                        }
                    }
                    .padding(.top, 28)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 60)
                }
                .scrollIndicators(.hidden)
                .sheet(item: $selectedJoy) { joy in
                    JoyMenuBottomSheet(joy: $selectedJoy, isMine: joy.isMine, isFromTodayJoy: true) }
            }
        }
            
            // 오플리 추가 안내 토스트
            if appStatus.showAddPlaylistToast {
                AddTodayPlaylistBarToast(showTodayPlaylist: $showTodayPlaylist) }
            
            if appStatus.isDuplicate {
                JoyDuplicateToast() }
        }
        .navigationTitle("많이 실천한 소확행")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color.madiiBox, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .onAppear { getJoys() }
        // 오늘의 소확행 오플리에 추가 후, 바로가기에서 sheet
        .sheet(isPresented: $showTodayPlaylist) {
            TodayPlaylistView(showPlaylist: $showTodayPlaylist) }
    }
    
    private var firstRank: some View {
        VStack(spacing: 12) {
            ZStack(alignment: .topLeading) {
                ZStack {
                    Circle()
                        .frame(width: 100, height: 100)
                        .foregroundStyle(Color.black)
                        .overlay { Circle().stroke(Color.white.opacity(0.2), lineWidth: 1) }
                    
                    Image("icon_\(joys[0].icon)")
                        .resizable()
                        .frame(width: 50, height: 50)
                }
                
                Image("first")
                    .resizable()
                    .frame(width: 28, height: 28)
            }
            
            Text(joys[0].title)
                .madiiFont(font: .madiiBody1, color: .white)
                .frame(width: 200)
                .multilineTextAlignment(.center)
            
            Text("\(joys[0].counts) 회")
                .madiiFont(font: .madiiBody1, color: .white)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(Color.madiiBox)
                .cornerRadius(90)
        }
        .padding(.vertical, 32)
        .padding(.horizontal, 10)
        .frame(maxWidth: .infinity)
        .background(Color.madiiOption)
        .cornerRadius(20)
    }
    
    @ViewBuilder
    private func joyRow(index: Int, joy: Joy) -> some View {
        Button {
            selectedJoy = joy
        } label: {
            HStack(spacing: 15) {
                // 순위
                Text("\(joy.rank)")
                    .madiiFont(font: .madiiBody3, color: .gray500)
                
                ZStack {
                    Circle()
                        .frame(width: 48, height: 48)
                        .foregroundStyle(Color.black)
                        .overlay {
                            Circle()
                                .stroke(Color.white.opacity(0.2), lineWidth: 1)
                        }
                    
                    Image("icon_\(joy.icon)")
                        .resizable()
                        .frame(width: 26, height: 26)
                }
                
                Text(joy.title)
                    .madiiFont(font: .madiiBody3, color: .white)
                    .multilineTextAlignment(.leading)
                
                Spacer(minLength: 15)
                
                // 실천 횟수
                Text("\(joy.counts) 회")
                    .madiiFont(font: .madiiBody5, color: .gray400)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.madiiOption)
                    .cornerRadius(6)
            }
        }
    }
    
    private var emptyView: some View {
        VStack(spacing: 60) {
            Spacer()
            
            Image("myJoyEmpty")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 240)
            
            VStack(spacing: 20) {
                Text("아직 여러 번 실천한 소확행이 없어요\n2회 이상 실천한 소확행부터 확인할 수 있어요")
                    .madiiFont(font: .madiiBody3, color: .gray500)
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
            Spacer()
        }
    }
    
    private func getJoys() {
        RecordAPI.shared.getMostAchievedJoy { isSuccess, joyList in
            if isSuccess {
                joys = []
                for joy in joyList.mostAchievedJoyInfos {
                    let newJoy = Joy(joyId: joy.joyId, icon: joy.joyIconNum, title: joy.contents, counts: joy.achieveCount, isMine: joy.isCreatedByMe, rank: joy.rank)
                    joys.append(newJoy)
                }
            } else {
                print("DEBUG ManyAchievedJoyView: isSuccess false")
            }
        }
    }
}

#Preview {
    ManyAchievedJoyView()
}
