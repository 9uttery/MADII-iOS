//
//  HomeTodayJoyView.swift
//  Madii
//
//  Created by 정태우 on 12/23/23.
//

import SwiftUI

struct HomeTodayJoyView: View {
    @EnvironmentObject var appStatus: AppStatus

    @State private var todayJoy: Joy = Joy(title: "") /// 오늘의 소확행
    @AppStorage("todayJoyId") var todayJoyId = 0
//    @State private var todayJoyId: Int = UserDefaults.standard.integer(forKey: "todayJoyId") /// 클릭 여부
    @State private var counter = 0 /// 파티클 애니메이션 추가
    @State var selectedJoy: Joy? /// 소확행 메뉴 bottom sheet 연결 joy
    
    @Binding var updatePlaylistBar: Bool /// 플리바 업데이트
    
    @State private var isFinishedGetJoy: Bool = false
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                if isFinishedGetJoy {
                    if todayJoyId == todayJoy.joyId {
                        JoyRowWithButton(joy: todayJoy) { } buttonLabel: {
                            Button {
                                // 소확행 오플리에 추가하기
                                playJoy()
                                AnalyticsManager.shared.logEvent(name: "홈뷰_오플리에추가하기클릭")
                            } label: {
                                Image("play")
                                    .resizable()
                                    .foregroundColor(.gray300)
                                    .frame(width: 16, height: 18)
                            }
                            
                            Button {
                                // 소확행 메뉴 bottom sheet
                                selectedJoy = todayJoy
                                AnalyticsManager.shared.logEvent(name: "홈뷰_오플리ellipsis클릭")
                            } label: {
                                Image(systemName: "ellipsis")
                                    .foregroundColor(.gray500)
                                    .rotationEffect(Angle(degrees: 90))
                            }
                            .sheet(item: $selectedJoy) { _ in
                                JoyMenuBottomSheet(joy: $selectedJoy, isMine: false, isFromTodayJoy: true) }
                        }
                    } else {
                        // 클릭해보세요! 버튼
                        TodayJoyBeforeClickButton(todayJoyId: $todayJoyId, counter: $counter, todayJoy: $todayJoy)
                    }
                }
            }
            .frame(height: 56)
            .roundBackground("오늘의 소확행 선물")
            .padding(.top, 14)
            .padding(.bottom, 16)
            
            ParticleView(counter: $counter)
        }
        .onAppear {
            getTodayJoy()
        }
    }
    
    private func getTodayJoy() {
        HomeAPI.shared.getJoyToday { isSuccess, todayJoy in
            if isSuccess {
                print("DEBUG HomeTodayJoyView getTodayJoy isSuccess true, \(todayJoy)")
                self.todayJoy = Joy(joyId: todayJoy.joyId, icon: todayJoy.joyIconNum, title: todayJoy.contents)
                isFinishedGetJoy = true
            } else {
                print("DEBUG HomeTodayJoyView getTodayJoy isSuccess false")
            }
        }
    }
    
    private func playJoy() {
        AchievementsAPI.shared.playJoy(joyId: todayJoy.joyId ?? 0) { isSuccess, isDuplicate in
            if isSuccess {
                appStatus.showAddPlaylistToast.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        appStatus.showAddPlaylistToast = false
                    }
                }
                print("DEBUG HomeTodayJoyView playJoy: isSuccess true")
                updatePlaylistBar.toggle()
            } else if isDuplicate {
                withAnimation {
                    appStatus.isDuplicate.toggle()
                    print("DEBUG HomeTodayJoyView playJoy: isSuccess false and isDuplicate true")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        withAnimation {
                            appStatus.isDuplicate = false
                        }
                    }
                }
            } else {
                print("DEBUG HomeTodayJoyView playJoy: isSuccess false")
            }
        }
    }
}
