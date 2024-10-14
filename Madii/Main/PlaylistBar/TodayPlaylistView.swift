//
//  TodayPlaylistView.swift
//  Madii
//
//  Created by 이안진 on 2/21/24.
//

import SwiftUI

struct TodayPlaylistView: View {
    @Environment(\.scenePhase) private var scenePhase
    @EnvironmentObject var appStatus: AppStatus
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
                            
                            ForEach(0 ..< 2) { index in
                                let eachDayJoy = allJoys[index]
                                if eachDayJoy.joys.isEmpty == false {
                                    joyToday(index == 0, date: eachDayJoy.date, joys: eachDayJoy.joys)
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
            .onChange(of: scenePhase) { newScenePhase in
                switch newScenePhase {
                case .active:
                    print("App is active")
                    getPlaylist()
                case .inactive:
                    print("App is inactive")
                case .background:
                    print("App is in background")
                @unknown default:
                    break
                }
            }
            .analyticsScreen(name: "오늘의플레이리스트뷰")
        }
    }
    
    private var emptyJoyView: some View {
        VStack(spacing: 28) {
            Image("myJoyEmpty")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 233)
                .padding(.top, 47)
            
            Text("아직 기록한 소확행이 없어요")
                .madiiFont(font: .madiiBody3, color: .gray500)
                .multilineTextAlignment(.center)
    
            Spacer()
            
            VStack(spacing: 0) {
                Text("소확행을 찾는 게 어려우신가요? 소확행을 탐색할 수 있는 두 가지 방법을 알려드릴게요")
                    .madiiFont(font: .madiiBody4, color: .white)
                    .lineSpacing(8)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 20)
                
                Button {
                    showPlaylist = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        appStatus.isNaviRecommend = true
                    }
                } label: {
                    HStack {
                        Text("나만의 맞춤형 소확행 찾기")
                            .madiiFont(font: .madiiBody2, color: .white)
                        
                        Spacer()
                        
                        Image("arrowRight")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.gray400)
                    }
                }
                .frame(height: 56)
                .padding(.horizontal, 16)
                .background(Color.buttonGray)
                .cornerRadius(12)
                .padding(.bottom, 16)
                
                Button {
                    showPlaylist = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        appStatus.isNaviPlayJoy = true
                    }
                } label: {
                    HStack {
                        Text("다른 사람들의 소확행 구경하기")
                            .madiiFont(font: .madiiBody2, color: .white)
                        
                        Spacer()
                        
                        Image("arrowRight")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.gray400)
                    }
                }
                .frame(height: 56)
                .padding(.horizontal, 16)
                .background(Color.buttonGray)
                .cornerRadius(12)
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 16)
            .background(Color.madiiBox)
            .cornerRadius(12)
            .padding(20)
            .padding(.bottom, 20)
        }
        .background(Color.black)
    }
    
    @ViewBuilder
    private func joyToday(_ isToday: Bool, date: String, joys: [Joy]) -> some View {
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
                    playlistJoyRow(joy: joy, isToday: isToday)
                        .listRowBackground(Color.madiiBox)
                        .listRowSeparator(.hidden)
                        .swipeActions(edge: .trailing) {
                            if isToday || !joy.isAchieved {
                                Button {
                                    withAnimation {
                                        deleteAchivement(id: joy.achievementId)
                                    }
                                    AnalyticsManager.shared.logEvent(name: "오늘의플레이리스트뷰_오늘추가한소확행삭제클릭")
                                } label: {
                                    Label("Trash", systemImage: "trash")
                                }
                                .tint(Color(red: 1.0, green: 0.231, blue: 0.188))
                            }
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
    
    private func playlistJoyRow(joy: Joy, isToday: Bool) -> some View {
        JoyRowWithButton(joy: joy) {
        } buttonLabel: {
            Button {
                if isToday && joy.isAchieved {
                    fromPlaylistBar = true
                    cancelAchievement(id: joy.achievementId)
                    AnalyticsManager.shared.logEvent(name: "오늘의플레이리스트뷰_오늘추가한소확행실천해제클릭")
                } else if isToday && !joy.isAchieved {
                    fromPlaylistBar = true
                    selectedJoy = joy
                    AnalyticsManager.shared.logEvent(name: "오늘의플레이리스트뷰_오늘추가한소확행실천클릭")
                } else if !isToday && !joy.isAchieved {
                    moveAchievementToToday(id: joy.achievementId)
                    AnalyticsManager.shared.logEvent(name: "오늘의플레이리스트뷰_어제실천못한소확행오늘로이동클릭")
                } else {
                    
                }
            } label: {
                if joy.isAchieved {
                    Image(joy.satisfaction.imageName)
                        .resizable()
                        .foregroundStyle(Color.madiiYellowGreen)
                        .frame(width: 24, height: 24)
                } else if isToday {
                    Image(systemName: "checkmark.circle")
                        .resizable()
                        .foregroundStyle(Color.gray200.opacity(0.4))
                        .frame(width: 24, height: 24)
                } else {
                    Image(systemName: "plus")
                        .resizable()
                        .foregroundStyle(Color.white)
                        .frame(width: 13, height: 13)
                        .padding(5.5)
                        .background(Color.madiiPurple)
                        .cornerRadius(14)
                }
            }
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
}

//#Preview {
//    TodayPlaylistView(showPlaylist: .constant(true))
//}
