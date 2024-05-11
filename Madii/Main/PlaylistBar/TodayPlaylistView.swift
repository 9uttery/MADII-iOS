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
    @State private var showMoveJoyBottomSheet: Bool = false
    
    @State private var showAlert = false
    
    @State private var fromPlaylistBar = true

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
                            joyBoxByToday(allJoys[0].date, joys: allJoys[0].joys)
                            
                            ForEach(1 ..< 2) { index in
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
//            .sheet(isPresented: $showMoveJoyBottomSheet) {
//                GeometryReader { geo in
//                    PlaylistBarMoveToTodayBottmSheet()
//                        .presentationDetents([.height(160 + geo.safeAreaInsets.bottom)])
//                        .presentationDragIndicator(.hidden)
//                }
//            }
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
    
    private func joyBoxByToday(_ date: String, joys: [Joy]) -> some View {
        VStack {
            HStack {
                Text(date)
                    .madiiFont(font: .madiiSubTitle, color: .white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 20)
                
                Spacer()
            } 
            
            List {
                ForEach(joys) { joy in
                    Button {
                        if joy.isAchieved {
                            fromPlaylistBar = false
                            selectedJoy = joy
                        }
                    } label: {
                        HStack(spacing: 15) {
                            // 소확행 커버 이미지
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
                            
                            Spacer()
                            
                            if joy.isAchieved {
                                // 실천한 경우 -> 실천 해제
                                Button {
                                    fromPlaylistBar = true
                                    cancelAchievement(id: joy.achievementId)
                                } label: {
                                    Image(systemName: "checkmark.circle.fill")
                                        .resizable()
                                        .foregroundStyle(Color.madiiYellowGreen)
                                        .frame(width: 24, height: 24)
                                }
                            } else {
                                // 오늘 실천하지 않은 경우 -> bottomsheet
                                Button {
                                    fromPlaylistBar = true
                                    selectedJoy = joy
                                } label: {
                                    Image(systemName: "checkmark.circle")
                                        .resizable()
                                        .foregroundStyle(Color(red: 0.37, green: 0.37, blue: 0.37))
                                        .frame(width: 24, height: 24)
                                }
                            }
                        }
                    }
                    .listRowBackground(Color.madiiBox)
                    .listRowSeparator(.hidden)
                    .swipeActions(edge: .trailing) {
                        Button {
                            withAnimation {
                                deleteAchivement(id: joy.achievementId)
                            }
                        } label: {
                            Label("Trash", systemImage: "trash")
                        }
                        .tint(Color(red: 1.0, green: 0.231, blue: 0.188))
                    }
                }
            }
            .listStyle(.plain)
            .frame(maxWidth: .infinity)
            .frame(height: 56 * CGFloat(joys.count))
            .environment(\.defaultMinListRowHeight, 56)
            .padding(.bottom, 20)
            .sheet(item: $selectedJoy, onDismiss: getPlaylist) { joy in
                JoySatisfactionBottomSheet(joy: joy, fromPlaylistBar: fromPlaylistBar)
                    .presentationDetents([.height(300)])
                    .presentationDragIndicator(.hidden)
            }
        }
        .background(Color.madiiBox)
        .cornerRadius(20)
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
                Button {
                    if joy.isAchieved {
                        fromPlaylistBar = false
                        selectedJoy = joy
                    }
                } label: {
                    JoyRowWithButton(joy: joy) {
                        // 메뉴 버튼 action
                        fromPlaylistBar = true
                        selectedJoy = joy
                    } buttonLabel: {
                        // 메뉴 버튼 이미지
                        if joy.isAchieved {
                            // 실천한 경우 -> 실천 해제
                            achievedButton(joy: joy)
                        } else {
                            if isYesterday {
                                // 어제 실천하지 않은 경우 -> 오늘로
                                moveToTodayButton(joy: joy)
                            } else {
                                // 오늘 실천하지 않은 경우 -> bottomsheet
                                Button {
                                    selectedJoy = joy
                                } label: {
                                    Image(systemName: "checkmark.circle")
                                        .resizable()
                                        .foregroundStyle(Color(red: 0.37, green: 0.37, blue: 0.37))
                                        .frame(width: 24, height: 24)
                                }
                            }
                        }
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
            .sheet(item: $selectedJoy, onDismiss: getPlaylist) { joy in
                JoySatisfactionBottomSheet(joy: joy, fromPlaylistBar: fromPlaylistBar)
                    .presentationDetents([.height(300)])
                    .presentationDragIndicator(.hidden)
            }
        }
        .padding(.bottom, 20)
        .background(Color.madiiBox)
        .cornerRadius(20)
    }
    
    private func achievedButton(joy: Joy) -> some View {
        Button {
            cancelAchievement(id: joy.achievementId)
        } label: {
            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .foregroundStyle(Color.madiiYellowGreen)
                .frame(width: 24, height: 24)
        }
    }
    
    private func moveToTodayButton(joy: Joy) -> some View {
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
    
    func deleteJoy(at offsets: IndexSet) {
        
    }
}

#Preview {
    TodayPlaylistView(showPlaylist: .constant(true))
}
