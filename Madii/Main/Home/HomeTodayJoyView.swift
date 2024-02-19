//
//  HomeTodayJoyView.swift
//  Madii
//
//  Created by 정태우 on 12/23/23.
//

import SwiftUI

struct HomeTodayJoyView: View {
    @State var counter = 0
    @EnvironmentObject private var tabBarManager: TabBarManager
    @State var todayJoy: GetJoyResponseJoy?
    @State var todayJoyTitle: String = ""
    @State private var isClickedToday: Bool = false
    @State private var myNewJoy: String = "샤브샤브 먹고 싶어"
    @Binding var showSaveJoyPopUp: Bool
    @State var todayJoyEllipsis: GetJoyResponseJoy?
    var body: some View {
        Image("madiiLogo")
            .resizable()
            .frame(width: 160, height: 22)
            .padding(.leading, 6)
            .padding(.vertical, 12)
        ZStack {
            VStack(alignment: .leading, spacing: 20) {
                if !isClickedToday {
                    Button {
                        HomeAPI.shared.getJoyToday { isSuccess, todayJoy  in
                            if isSuccess {
                                self.todayJoy = todayJoy
                                self.todayJoyTitle = todayJoy.contents
                            }
                        }
                        isClickedToday.toggle()
                        counter += 1
                    } label: {
                        ZStack {
                            HStack {
                                Spacer()
                                Text("클릭해보세요!")
                                    .madiiFont(font: .madiiBody1, color: .black)
                                    .padding(.vertical, 18)
                                Spacer()
                            }
                            .background(isClickedToday ? Color.madiiYellowGreen : Color.madiiOrange)
                            .cornerRadius(90)
                        }
                    }
                } else {
                    HStack {
                        Image("play")
                            .resizable()
                            .frame(width: 56, height: 56)
                        Text(todayJoyTitle)
                            .madiiFont(font: .madiiBody3, color: .white)
                        Spacer()
                        Button {
                            // tabBarManager.isTabBarShown = false
                            showSaveJoyPopUp = true
                        } label: {
                            Image("play")
                                .resizable()
                                .foregroundColor(.gray300)
                                .frame(width: 16, height: 18)
                        }
                        Button {
                            guard let todayJoyEllipsis = todayJoy else { return }
                        } label: {
                            Image(systemName: "ellipsis")
                                .foregroundColor(.gray500)
                                .rotationEffect(Angle(degrees: 90))
                        }
                            .sheet(item: $todayJoyEllipsis, content: { item in
                                JoyMenuBottomSheet(joy: Joy(title: ""), isMine: false)
                            })
                    }
                }
            }
            .roundBackground("오늘의 소확행")
            .padding(.top, 14)
            .padding(.bottom, 16)
            
            ParticleView(counter: $counter)
        }
    }
}

#Preview {
    HomeTodayJoyView(todayJoy: GetJoyResponseJoy(joyId: 0, joyIconNum: 0, contents: ""), showSaveJoyPopUp: .constant(true))
}
