//
//  PlaylistBar.swift
//  Madii
//
//  Created by 이안진 on 2/9/24.
//

import SwiftUI

struct PlaylistBar: View {
    @State private var draggedOffset = CGSize.zero
    
    @State private var todayJoys: MyJoy = MyJoy(date: "", joys: [])
    @State private var showPlaylist: Bool = false
    @Binding var updatePlaylistBar: Bool /// 플리바 업데이트
    
    @Binding var showPlaylistBar: Bool
    @State private var selectedJoyIndex: Int = 0
    
    var isLeftButtonActive: Bool { selectedJoyIndex > 0 }
    
    @State private var selectedJoy: Joy?
    
    @State private var textTimer: Timer?
    @State private var startTime: Date?
    @State private var textWidth: CGFloat = 1
    @State private var xOffset: CGFloat = 0
    @State private var direction: CGFloat = -1
    @State private var isPaused: Bool = false
    @State private var joy: Joy = Joy(joyId: 0, achievementId: 0, isAchieved: false, icon: 1, title: "", counts: 0, satisfaction: .bad, isSaved: false, isMine: false, rank: 0)
    
    var body: some View {
        VStack(spacing: 0) {
            if showPlaylistBar {
                ZStack {
                    HStack {
                        Text(todayJoys.joys.isEmpty == false ? joy.title : "오늘의 플레이리스트를 담아보세요!")
                            .madiiFont(font: .madiiBody1, color: .white)
                            .offset(x: xOffset)
                            .clipShape(HalfClipShape())
                            .readSize { new in
                                textWidth = new.width
                                print(textWidth)
                            }
                        
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        HStack(spacing: 12) {
                            leftButton
                            
                            if joy.isAchieved {
                                // 실천한 경우 -> 실천 해제
                                Button {
                                    if todayJoys.joys.isEmpty == false {
                                        cancelAchievement(id: joy.achievementId)
                                        AnalyticsManager.shared.logEvent(name: "플리바_플리바실천해제클릭")
                                    }
                                } label: {
                                    Image(systemName: "checkmark.circle.fill")
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                        .foregroundStyle(Color.madiiYellowGreen)
                                        .padding()
                                        .frame(width: 28, height: 28)
                                }
                            } else {
                                // 실천하지 않은 경우 -> bottomsheet
                                Button {
                                    if todayJoys.joys.isEmpty == false {
                                        selectedJoy = joy
                                        AnalyticsManager.shared.logEvent(name: "플리바_플리바실천클릭")
                                    }
                                } label: {
                                    Image(systemName: "checkmark.circle")
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                        .foregroundStyle(Color(red: 0.37, green: 0.37, blue: 0.37))
                                        .padding()
                                        .frame(width: 28, height: 28)
                                }
                                .sheet(item: $selectedJoy, onDismiss: getPlaylist) { joy in
                                    JoySatisfactionBottomSheet(joy: joy, fromPlaylistBar: true)
                                        .presentationDetents([.height(300)])
                                    .presentationDragIndicator(.hidden) } }
                            
                            rightButton
                            
                            Button {
                                withAnimation {
                                    showPlaylist = true
                                    AnalyticsManager.shared.logEvent(name: "플리바_오플리띄우기클릭")
                                }
                            } label: {
                                Image(systemName: "line.3.horizontal")
                                    .frame(width: 18, height: 18)
                                    .foregroundStyle(Color.gray500)
                                    .padding()
                                    .frame(width: 22, height: 22)
                                    .padding(.leading, 9.5)
                            }
                        }
                    }
                }
                .padding(16)
                .overlay(
                    Rectangle()
                        .frame(height: 1, alignment: .top)
                        .foregroundColor(Color.madiiYellowGreen),
                    alignment: .top
                )
                .background(Color.black)
            }
        }
        .frame(height: 60)
        .onAppear {
            getPlaylist()
            stopTimer()
            xOffset = 0
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                startTimer()
            }
        }
        .onDisappear {
            stopTimer()
        }
        .onChange(of: showPlaylist) { _ in
            // 오플리 사라지면 플리바 새로고침
            if showPlaylist == false { getPlaylist() }
        }
        .onChange(of: selectedJoyIndex) { _ in
            joy = todayJoys.joys[selectedJoyIndex]
        }
        .onChange(of: updatePlaylistBar) { _ in
            if updatePlaylistBar { getPlaylist() }
        }
        .onTapGesture {
            showPlaylist = true
        }
        .sheet(isPresented: $showPlaylist) {
            TodayPlaylistView(showPlaylist: $showPlaylist)
        }
        .analyticsScreen(name: "플리바")
    }
    
    private var leftButton: some View {
        Button {
            if isLeftButtonActive {
                selectedJoyIndex -= 1
                xOffset = 0
                stopTimer()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    startTimer()
                }
                AnalyticsManager.shared.logEvent(name: "플리바_플리왼쪽클릭")
            }
        } label: {
            Image(isLeftButtonActive ? "pl_left_active" : "pl_left")
                .resizable()
                .frame(width: 14, height: 16)
        }
        .disabled(isLeftButtonActive == false)
    }
    
    private var rightButton: some View {
        Button {
            if selectedJoyIndex < (todayJoys.joys.count - 1) {
                selectedJoyIndex += 1
                xOffset = 0
                stopTimer()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    startTimer()
                }
                AnalyticsManager.shared.logEvent(name: "플리바_플리오른쪽클릭")
            }
        } label: {
            Image(selectedJoyIndex < (todayJoys.joys.count - 1) ? "pl_right_active" : "pl_right")
                .resizable()
                .frame(width: 14, height: 16)
        }
        .disabled(selectedJoyIndex >= (todayJoys.joys.count - 1))
    }
    
    private func getPlaylist() {
        AchievementsAPI.shared.getPlaylist { isSuccess, response in
            if isSuccess {
                print("DEBUG TodayPlaylistView getPlaylist: isSuccess true")
                
                let today = response.todayJoyPlayList
                var newJoys: [Joy] = []
                for joy in today.joyAchievementInfos {
                    let newJoy = Joy(joyId: joy.joyId, achievementId: joy.achievementId, isAchieved: joy.isAchieved, icon: joy.joyIconNum, title: joy.contents, satisfaction: JoySatisfaction.fromServer(joy.satisfaction ?? ""))
                    newJoys.append(newJoy)
                }
                todayJoys = MyJoy(date: today.date, joys: newJoys)
                
                if todayJoys.joys.isEmpty == false {
                    joy = todayJoys.joys[selectedJoyIndex]
                }
            } else {
                print("DEBUG TodayPlaylistView getPlaylist: isSuccess false")
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
    
    var swipeDownToDismiss: some Gesture {
        DragGesture()
            .onChanged { gesture in
                // 아래로만 드래그 되도록 구현
                guard gesture.translation.height > 0 else { return }
                
                draggedOffset.height = gesture.translation.height
            }
            .onEnded { gesture in
                if checkIsDismissable(gesture: gesture) {
                    showPlaylist = false
                }
                
                withAnimation {
                    draggedOffset = .zero
                }
            }
    }

    func checkIsDismissable(gesture: _ChangedGesture<DragGesture>.Value) -> Bool {
        let dismissableLocation = gesture.translation.height > 100
        let dismissableVolocity = (gesture.predictedEndLocation - gesture.location).y > 100
        return dismissableLocation || dismissableVolocity
    }
    
    private func startTimer() {
        if textWidth < UIScreen.main.bounds.width - 185 {
            stopTimer()
            return
        }
        if textTimer == nil {
            textTimer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
                if (textWidth + xOffset <= UIScreen.main.bounds.width - 185 && direction == -1) || (xOffset >= 0 && direction == 1) {
                    stopTimer()
                    direction *= -1
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        self.startTimer()
                    }
                } else {
                    withAnimation {
                        xOffset += direction
                    }
                }
            }
        }
    }

    private func stopTimer() {
        textTimer?.invalidate()
        textTimer = nil
    }
}

extension CGPoint {
    static func - (lhs: Self, rhs: Self) -> Self {
        CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
}

struct HalfClipShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRect(CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 185, height: rect.height))
        return path
    }
}
