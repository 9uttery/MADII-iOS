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
    
    @Binding var showPlaylistBar: Bool
    @State private var selectedJoyIndex: Int = 0
    
    var isLeftButtonActive: Bool { selectedJoyIndex > 0 }
    
    @State private var selectedJoy: Joy?
    
    var body: some View {
        VStack(spacing: 0) {
            if showPlaylistBar {
                let joy = todayJoys.joys[selectedJoyIndex]
                
                HStack(spacing: 22) {
                    Text(joy.title)
                        .madiiFont(font: .madiiBody1, color: .white)
                        .lineLimit(1)
                    
                    Spacer()
                    
                    HStack(spacing: 12) {
                        leftButton
                        
                        if joy.isAchieved {
                            // 실천한 경우 -> 실천 해제
                            Button {
                                cancelAchievement(id: joy.achievementId)
                            } label: {
                                Image(systemName: "checkmark.circle.fill")
                                    .frame(width: 24, height: 24)
                                    .foregroundStyle(Color.madiiYellowGreen)
                                    .padding()
                                    .frame(width: 28, height: 28)
                            }
                        } else {
                            // 실천하지 않은 경우 -> bottomsheet
                            Button {
                                selectedJoy = joy
                            } label: {
                                Image(systemName: "checkmark.circle")
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
                    }
                    
                    Button {
                        withAnimation { showPlaylist = true }
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .frame(width: 18, height: 18)
                            .foregroundStyle(Color.gray500)
                            .padding()
                            .frame(width: 22, height: 22)
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
        .frame(height: showPlaylistBar ? 60 : 0)
        .opacity(showPlaylistBar ? 1.0 : 0.0)
        .onAppear { getPlaylist() }
        .onChange(of: showPlaylist) { _ in
            // 오플리 사라지면 플리바 새로고침
            if showPlaylist == false { getPlaylist() }
        }
        .transparentFullScreenCover(isPresented: $showPlaylist) {
            TodayPlaylistView(showPlaylist: $showPlaylist)
                .offset(draggedOffset)
                .gesture(swipeDownToDismiss)
        }
    }
    
    private var leftButton: some View {
        Button {
            if isLeftButtonActive {
                selectedJoyIndex -= 1
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
                
                showPlaylistBar = todayJoys.joys.isEmpty == false // 없으면 안띄우기
                
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
}

extension CGPoint {
    static func - (lhs: Self, rhs: Self) -> Self {
        CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
}
