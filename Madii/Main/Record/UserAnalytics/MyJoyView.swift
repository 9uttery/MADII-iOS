//
//  MyJoyView.swift
//  Madii
//
//  Created by 이안진 on 12/1/23.
//

import SwiftUI

struct MyJoyView: View {
    @EnvironmentObject var appStatus: AppStatus
    @Environment(\.dismiss) private var dismiss
    
    @State private var allJoys: [MyJoy] = []
    @State private var selectedJoy: Joy?

    @State private var showTodayPlaylist: Bool = false /// 오플리 sheet 열기
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                if allJoys.isEmpty {
                    // 내가 기록한 소확행 없을 때
                    emptyJoyView
                } else {
                    // 내가 기록한 소확행 있을 때
                    ScrollView {
                        VStack(spacing: 20) {
                            ForEach(allJoys) { eachDayJoy in
                                // 날짜별 소확행 박스
                                joyBoxByDate(eachDayJoy.date, joys: eachDayJoy.joys)
                            }
                            .sheet(item: $selectedJoy, onDismiss: getJoy) { _ in
                                JoyMenuBottomSheet(joy: $selectedJoy, isMine: true) }
                        }
                        .padding(.top, 28)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 60)
                    }
                    .scrollIndicators(.hidden)
                }
            }
            
            // 오플리 추가 안내 토스트
            if appStatus.showAddPlaylistToast {
                AddTodayPlaylistBarToast(showTodayPlaylist: $showTodayPlaylist) }
            
            // 오플리 중복 안내 토스트
            if appStatus.isDuplicate {
                VStack {
                    Spacer()
                    JoyDuplicateToast()
                }
            }
            if appStatus.isDuplicate {
                JoyDuplicateToast() }
        }
        // 오늘의 소확행 오플리에 추가 후, 바로가기에서 sheet
        .sheet(isPresented: $showTodayPlaylist) {
            TodayPlaylistView(showPlaylist: $showTodayPlaylist) }
        .navigationTitle("내가 기록한 소확행")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear { getJoy() }
        .toolbarBackground(Color.madiiBox, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .analyticsScreen(name: "내가 기록한 소확행뷰")
    }
    
    private var emptyJoyView: some View {
        VStack(spacing: 60) {
            Spacer()
            
            Image("myJoyEmpty")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 240)
            
            VStack(spacing: 20) {
                Text("아직 기록한 소확행이 없어요")
                    .madiiFont(font: .madiiBody3, color: .gray500)
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
            Spacer()
        }
    }
    
    @ViewBuilder
    private func joyBoxByDate(_ date: String, joys: [Joy]) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(date)
                .madiiFont(font: .madiiSubTitle, color: .white)
                .padding(.horizontal, 16)
                .padding(.vertical, 20)
            
            ForEach(joys) { joy in
                Button {
                    playJoy(joy: joy)
                    AnalyticsManager.shared.logEvent(name: "내가기록한소확행뷰_소확행클릭오플리추가")
                } label: {
                    JoyRowWithButton(joy: joy) {
                        // 메뉴 버튼 action
                        selectedJoy = joy
                        AnalyticsManager.shared.logEvent(name: "내가기록한소확행뷰_소확행ellipsis클릭")
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
        }
        .padding(.bottom, 20)
        .background(Color.madiiBox)
        .cornerRadius(20)
    }
    
    private func getJoy() {
        RecordAPI.shared.getJoy { isSuccess, joyList in
            if isSuccess {
                allJoys = []
                for date in joyList {
                    var joys: [Joy] = []
                    for joy in date.joyList {
                        let newJoy = Joy(joyId: joy.joyId, icon: joy.joyIconNum, title: joy.contents)
                        joys.append(newJoy)
                    }
                    
                    let newDate = MyJoy(date: date.createdAt, joys: joys)
                    allJoys.append(newDate)
                }
            } else {
                print("DEBUG MyJoyView: isSuccess false")
            }
        }
    }
    
    private func playJoy(joy: Joy) {
        AchievementsAPI.shared.playJoy(joyId: joy.joyId ?? 0) { isSuccess, isDuplicate in
            if isSuccess {
                print("DEBUG AlbumDetailView: 오플리에 추가 true")
                
                // 오플리 추가 안내 토스트 띄우기
                withAnimation {
                    appStatus.showAddPlaylistToast = true
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        appStatus.showAddPlaylistToast = false
                    }
                }
            } else if isDuplicate {
                withAnimation {
                    appStatus.isDuplicate = true
                }
                print("DEBUG AlbumDetailView playJoy: isSuccess false and isDuplicate true")

                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        appStatus.isDuplicate = false
                    }
                }
            } else {
                print("DEBUG AlbumDetailView: 오플리에 추가 false")
            }
        }
    }
}

#Preview {
    MyJoyView()
}
