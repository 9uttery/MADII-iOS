//
//  HomeTodayJoyView.swift
//  Madii
//
//  Created by 정태우 on 12/23/23.
//

import SwiftUI

struct HomeTodayJoyView: View {
    @State private var todayJoy: Joy = Joy(title: "") /// 오늘의 소확행
    @State private var isClickedToday: Bool = true /// 클릭 여부
    @State private var counter = 0 /// 파티클 애니메이션 추가
    @State var selectedJoy: Joy? /// 소확행 메뉴 bottom sheet 연결 joy
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 20) {
                if isClickedToday == false {
                    // 클릭해보세요! 버튼
                    TodayJoyBeforeClickButton(isClickedToday: $isClickedToday, counter: $counter)
                } else {
                    JoyRowWithButton(joy: todayJoy) { } buttonLabel: {
                        Button {
                            // 소확행 오플리에 추가하기
                            playJoy()
                        } label: {
                            Image("play")
                                .resizable()
                                .foregroundColor(.gray300)
                                .frame(width: 16, height: 18)
                        }
                        
                        Button {
                            // 소확행 메뉴 bottom sheet
                            selectedJoy = todayJoy
                        } label: {
                            Image(systemName: "ellipsis")
                                .foregroundColor(.gray500)
                                .rotationEffect(Angle(degrees: 90))
                        }
                        .sheet(item: $selectedJoy) { joy in
                            JoyMenuBottomSheet(joy: joy, isMine: false) }
                    }
                }
            }
            .roundBackground("오늘의 소확행")
            .padding(.top, 14)
            .padding(.bottom, 16)
            
            ParticleView(counter: $counter)
        }
        .onAppear { getTodayJoy() }
    }
    
    private func getTodayJoy() {
        HomeAPI.shared.getJoyToday { isSuccess, todayJoy in
            if isSuccess {
                print("DEBUG HomeTodayJoyView getTodayJoy isSuccess true, \(todayJoy)")
                self.todayJoy = Joy(joyId: todayJoy.joyId, icon: todayJoy.joyIconNum, title: todayJoy.contents)
            } else {
                print("DEBUG HomeTodayJoyView getTodayJoy isSuccess false")
            }
        }
    }
    
    private func playJoy() {
        AchievementsAPI.shared.playJoy(joyId: todayJoy.joyId) { isSuccess in
            if isSuccess {
                print("DEBUG HomeTodayJoyView playJoy: isSuccess true")
            } else {
                print("DEBUG HomeTodayJoyView playJoy: isSuccess true")
            }
        }
    }
}
