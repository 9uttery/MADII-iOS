//
//  TodayPlaylistView.swift
//  Madii
//
//  Created by 이안진 on 2/21/24.
//

import SwiftUI

struct TodayPlaylistView: View {
    @Binding var showPlaylist: Bool
    @State private var allJoys: [MyJoy] = []
    @State private var showEmptyView: Bool = false
    @State private var selectedJoy: Joy?

    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 0) {
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
                        } label: {
                            Image(systemName: "chevron.down")
                        }.padding(.leading, 20)
                    }
                }
                .frame(height: geo.safeAreaInsets.top + 60)
                
                if allJoys.isEmpty || showEmptyView {
                    // 내가 기록한 소확행 없을 때
                    emptyJoyView
                } else {
                    // 내가 기록한 소확행 있을 때
                    ScrollView {
                        VStack(spacing: 20) {
                            ForEach(allJoys) { eachDayJoy in
                                if eachDayJoy.joys.isEmpty == false {
                                    // 날짜별 소확행 박스
                                    joyBoxByDate(eachDayJoy.date, joys: eachDayJoy.joys)
                                }
                            }
                            .sheet(item: $selectedJoy) { item in
                                JoyMenuBottomSheet(joy: item, isMine: true) }
                        }
                        .padding(.top, 28)
                        .padding(.bottom, 60)
                    }
                    .padding(.horizontal, 16)
                    .scrollIndicators(.hidden)
                    .background(Color.black)
                }
            }
            .ignoresSafeArea()
            .onAppear { getPlaylist() }
        }
    }
    
    private var emptyJoyView: some View {
        VStack(spacing: 60) {
            Spacer()
            
            Image("myJoyEmpty")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 240)
            
            Text("아직 기록한 소확행이 없어요")
                .madiiFont(font: .madiiBody3, color: .gray500)
                .multilineTextAlignment(.center)
            
            Spacer()
            Spacer()
            HStack { Spacer() }
        }
        .background(Color.madiiBox)
    }
    
    @ViewBuilder
    private func joyBoxByDate(_ date: String, joys: [Joy]) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text(date)
                    .madiiFont(font: .madiiSubTitle, color: .white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 20)
                
                Spacer()
            }
            
            ForEach(joys) { joy in
                JoyRowWithButton(joy: joy) {
                    // 메뉴 버튼 action
                    selectedJoy = joy
                } buttonLabel: {
                    // 메뉴 버튼 이미지
                    Image(systemName: "ellipsis")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .foregroundStyle(Color.gray500)
                        .padding(10)
                }
                .padding(.leading, 12)
                .padding(.trailing, 16)
                .padding(.vertical, 4)
            }
        }
        .padding(.bottom, 20)
        .background(Color.madiiBox)
        .cornerRadius(20)
    }
    
    private func getPlaylist() {
        AchievementsAPI.shared.getPlaylist { isSuccess, response in
            if isSuccess {
                print("DEBUG TodayPlaylistView: isSuccess true")
                print("DEBUG TodayPlaylistView: response \(response)")
                allJoys = []
                
                let today = response.todayJoyPlayList
                var newJoys: [Joy] = []
                for joy in today.joyAchievementInfos {
                    let newJoy = Joy(joyId: joy.joyId, achievementId: joy.achievementId, icon: joy.joyIconNum, title: joy.contents, satisfaction: JoySatisfaction.fromServer(joy.satisfaction ?? ""))
                    newJoys.append(newJoy)
                }
                allJoys.append(MyJoy(date: today.date, joys: newJoys))
                
                let yesterday = response.yesterdayJoyPlayList
                newJoys = []
                for joy in yesterday.joyAchievementInfos {
                    let newJoy = Joy(joyId: joy.joyId, achievementId: joy.achievementId, icon: joy.joyIconNum, title: joy.contents, satisfaction: JoySatisfaction.fromServer(joy.satisfaction ?? ""))
                    newJoys.append(newJoy)
                }
                
                allJoys.append(MyJoy(date: yesterday.date, joys: newJoys))
                
                if allJoys[0].joys.isEmpty && allJoys[1].joys.isEmpty {
                    showEmptyView = true
                }
            } else {
                print("DEBUG TodayPlaylistView: isSuccess false")
            }
        }
    }
}

#Preview {
    TodayPlaylistView(showPlaylist: .constant(true))
}
