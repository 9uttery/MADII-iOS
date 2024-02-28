//
//  TodayPlaylistView.swift
//  Madii
//
//  Created by 이안진 on 2/21/24.
//

import SwiftUI

struct TodayPlaylistView: View {
    @Binding var showPlaylist: Bool
    @State private var allJoys: [MyJoy] = MyJoy.dummys
    @State private var showEmptyView: Bool = false
    @State private var selectedJoy: Joy?
    @State private var showMoveJoyBottomSheet: Bool = false
    
    @State private var showAlert = false

    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 0) {
                TodayPlaylistNavigationBar(showPlaylist: $showPlaylist)
                    .frame(height: geo.safeAreaInsets.top + 60)
                
                if allJoys.isEmpty || showEmptyView {
                    // 내가 기록한 소확행 없을 때
                    emptyJoyView
                } else {
                    // 내가 기록한 소확행 있을 때
                    ScrollView {
                        VStack(spacing: 20) {
                            ForEach(0 ..< 2) { index in
                                let eachDayJoy = allJoys[index]
                                if eachDayJoy.joys.isEmpty == false {
                                    // 날짜별 소확행 박스
                                    joyBoxByDate(eachDayJoy.date, isYesterday: index == 1, joys: eachDayJoy.joys)
                                }
                            }
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
            .onAppear {
                getPlaylist()
            }
            .sheet(isPresented: $showMoveJoyBottomSheet) {
                GeometryReader { geo in
                    PlaylistBarMoveToTodayBottmSheet()
                        .presentationDetents([.height(160 + geo.safeAreaInsets.bottom)])
                        .presentationDragIndicator(.hidden)
                }
            }
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
    private func joyBoxByDate(_ date: String, isYesterday: Bool, joys: [Joy]) -> some View {
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
                    if joy.isAchieved {
                        // 실천한 경우 -> 실천 해제
                        Button {
                            cancelAchievement(id: joy.achievementId)
                        } label: {
                            Image(systemName: "checkmark.circle.fill")
                                .resizable()
                                .foregroundStyle(Color.madiiYellowGreen)
                                .frame(width: 24, height: 24)
                        }
                    } else {
                        if isYesterday {
                            // 어제 실천하지 않은 경우 -> 오늘로
                            Button {
                                moveAchievementToToday(id: joy.achievementId)
                            } label: {
                                ZStack {
                                    Circle()
                                        .foregroundStyle(Color.madiiPurple)
                                    
                                    Image(systemName: "plus")
                                        .resizable()
                                        .frame(width: 13, height: 13)
                                }
                                .frame(width: 24, height: 24)
                            }
                        } else {
                            // 오늘 실천하지 않은 경우 -> bottomsheet
                            Button {
                                selectedJoy = joy
                            } label: {
                                Image(systemName: "checkmark.circle")
                                    .resizable()
                                    .foregroundStyle(Color(red: 0.37, green: 0.37, blue: 0.37))
                                    .frame(width: 28, height: 28)
                            }
                            .sheet(item: $selectedJoy, onDismiss: getPlaylist) { joy in
                                JoySatisfactionBottomSheet(joy: joy, fromPlaylistBar: true)
                                    .presentationDetents([.height(300)])
                                .presentationDragIndicator(.hidden) } }
                    }
                }
                .padding(.leading, 12)
                .padding(.trailing, 16)
                .padding(.vertical, 4)
                .onLongPressGesture { self.showAlert = true }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("소확행 실행 취소"),
                          message: Text("\(joy.title)의 실천을 취소할까요?"),
                          primaryButton: .cancel(Text("취소")),
                          secondaryButton: .destructive(Text("삭제"),
                          action: { self.deleteAchivement(id: joy.achievementId) }))
                }
            }
        }
        .padding(.bottom, 20)
        .background(Color.madiiBox)
        .cornerRadius(20)
    }
    
    private func getPlaylist() {
        AchievementsAPI.shared.getPlaylist { isSuccess, response in
            if isSuccess {                allJoys = []
                
                let today = response.todayJoyPlayList
                var newJoys: [Joy] = []
                for joy in today.joyAchievementInfos {
                    let newJoy = Joy(joyId: joy.joyId, achievementId: joy.achievementId, isAchieved: joy.isAchieved, icon: joy.joyIconNum, title: joy.contents, satisfaction: JoySatisfaction.fromServer(joy.satisfaction ?? ""))
                    newJoys.append(newJoy)
                }
                allJoys.append(MyJoy(date: today.date, joys: newJoys))
                
                let yesterday = response.yesterdayJoyPlayList
                newJoys = []
                for joy in yesterday.joyAchievementInfos {
                    let newJoy = Joy(joyId: joy.joyId, achievementId: joy.achievementId, isAchieved: joy.isAchieved, icon: joy.joyIconNum, title: joy.contents, satisfaction: JoySatisfaction.fromServer(joy.satisfaction ?? ""))
                    newJoys.append(newJoy)
                }
                allJoys.append(MyJoy(date: yesterday.date, joys: newJoys))
                
                showMoveJoyBottomSheet = allJoys[1].joys.contains { $0.isAchieved == false }
                
                if allJoys[0].joys.isEmpty && allJoys[1].joys.isEmpty {
                    showEmptyView = true
                }
            } else {
                print("DEBUG TodayPlaylistView: isSuccess false")
            }
        }
    }
    
    private func cancelAchievement(id: Int) {
        AchievementsAPI.shared.cancelAchievement(achievementId: id) { isSuccess in
            if isSuccess {
                print("DEBUG PlaylistBar cancelAchievement: isSuccess true")
                getPlaylist()
            } else {
                print("DEBUG PlaylistBar cancelAchievement: isSuccess false")
            }
        }
    }
    
    private func moveAchievementToToday(id: Int) {
        AchievementsAPI.shared.moveAchievementToToday(achievementId: id) { isSuccess in
            if isSuccess {
                print("DEBUG PlaylistBar moveAchievementToToday: isSuccess true")
                getPlaylist()
            } else {
                print("DEBUG PlaylistBar moveAchievementToToday: isSuccess false")
            }
        }
    }
    
    private func deleteAchivement(id: Int) {
        AchievementsAPI.shared.deleteJoy(achievementId: id) { isSuccess in
            if isSuccess {
                print("DEBUG PlaylistBar deleteJoy: isSuccess true")
                getPlaylist()
            } else {
                print("DEBUG PlaylistBar deleteJoy: isSuccess false")
            }
        }
    }
}

#Preview {
    TodayPlaylistView(showPlaylist: .constant(true))
}
