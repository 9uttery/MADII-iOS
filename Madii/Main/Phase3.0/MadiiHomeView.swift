//
//  MadiiHomeView.swift
//  Madii
//
//  Created by 정태우 on 8/7/25.
//

import MadiiDesignSystem
import SwiftUI

struct MadiiHomeView: View {
    @State var isClicked: Bool = false
    @State var isMonthly: Bool = false
    @State var isTodayJoy: Bool = false
    @State private var todayJoy: Joy = Joy(title: "")
    @State var joyList: [Joy] = []
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0) {
                MadiiHomeNavigation {
                    
                }
                .padding(.bottom, 12)
                
                if isTodayJoy {
                    HStack(spacing: 16) {
                        Image("Cover1")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .cornerRadius(32)
                        
                        VStack(alignment: .leading, spacing: 3) {
                            HStack(spacing: 4) {
                                Image("home_selected")
                                    .resizable()
                                    .frame(width: 12.6, height: 12.36)
                                
                                Text("오늘의 소확행 선물")
                                    .madiiFont(font: .madiiCaption, color: .madiiGreen100)
                                    .padding(.vertical, 4.5)
                            }
                            .padding(.horizontal, 8)
                            .background(.madiiGreen10)
                            .cornerRadius(8)
                            
                            Text(todayJoy.title)
                                .madiiFont(font: .madiiBody2, color: .madiiGray100)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            HStack(spacing: 8) {
                                Button {
                                    playJoy()
                                } label: {
                                    Image("playCircle")
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                }
                                
                                Button {
                                    
                                } label: {
                                    Image(systemName: "ellipsis")
                                        .resizable()
                                        .frame(width: 30, height: 6.67)
                                        .foregroundStyle(.madiiAlternative)
                                }
                            }
                        }
                    }
                    .padding(.vertical, 20)
                    .padding(.horizontal, 18)
                    .background(.madiiElevated)
                    .cornerRadius(32)
                    .padding(.bottom, 24)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                } else {
                    VStack(spacing: 6) {
                        Image("todayClover")
                        
                        Button {
                            withAnimation(.easeInOut(duration: 0.4)) {
                                getTodayJoy()
                                isTodayJoy = true
                            }
                        } label: {
                            Text("클릭해 보세요!")
                                .madiiFont(font: .madiiSubTitle, color: .madiiStrong)
                                .padding(.vertical, 16)
                                .frame(width: UIScreen.main.bounds.width - 80)
                                .background(.gray100.opacity(0.52))
                                .cornerRadius(20)
                        }
                    }
                    .padding(20)
                    .background(
                        Image("todayJoy")
                            .resizable()
                            .scaledToFill()
                            .cornerRadius(40)
                    )
                    .padding(.bottom, 24)
                    .transition(.move(edge: .top).combined(with: .opacity))
                }
                
                Button {
                    
                } label: {
                    Text("오늘 하루 돌아보기")
                        .madiiFont(font: .madiiSubTitle, color: .madiiContrast)
                        .padding(.vertical, 16)
                        .frame(maxWidth: .infinity)
                        .background(.madiiGreen100)
                        .cornerRadius(20)
                }
                .padding(.bottom, 16)
                
                HomeCalendar(isMonthly: $isMonthly)
            }
            .padding(.horizontal, 20)
        }
        .animation(.easeInOut, value: isMonthly)
        .animation(.easeInOut, value: isTodayJoy)
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
        AchievementsAPI.shared.playJoy(joyId: todayJoy.joyId ?? 0) { isSuccess, isDuplicate in
            if isSuccess {
                print("DEBUG HomeTodayJoyView playJoy: isSuccess true")
            } else if isDuplicate {
                withAnimation {
                    print("DEBUG HomeTodayJoyView playJoy: isSuccess false and isDuplicate true")
                }
            } else {
                print("DEBUG HomeTodayJoyView playJoy: isSuccess false")
            }
        }
    }
}

#Preview {
    MadiiHomeView()
}
