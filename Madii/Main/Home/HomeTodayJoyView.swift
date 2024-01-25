//
//  HomeTodayJoyView.swift
//  Madii
//
//  Created by 정태우 on 12/23/23.
//

import SwiftUI

struct HomeTodayJoyView: View {
    @EnvironmentObject private var tabBarManager: TabBarManager
    @State private var todayJoy: String = "넷플릭스 보면서 귤 까먹기"
    @State private var isClickedToday: Bool = false
    @State private var myNewJoy: String = "샤브샤브 먹고 싶어"
    @Binding var showSaveJoyPopUp: Bool
    var body: some View {
        Image("madiiLogo")
            .resizable()
            .frame(width: 160, height: 22)
            .padding(.leading, 6)
            .padding(.vertical, 12)
        VStack(alignment: .leading, spacing: 20) {
            if !isClickedToday {
                Button {
                    isClickedToday.toggle()
                } label: {
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
            } else {
                HStack() {
                    Image("")
                        .resizable()
                        .frame(width: 56, height: 56)
                    Text(todayJoy)
                        .madiiFont(font: .madiiBody3, color: .white)
                    Spacer()
                    Button {
                        //                            tabBarManager.isTabBarShown = false
                        showSaveJoyPopUp = true
                    } label: {
                        Image(myNewJoy.isEmpty ? "inactiveSave" : "activeSave")
                            .resizable()
                            .frame(width: 36, height: 36)
                    }
                    .disabled(myNewJoy.isEmpty)
                }
            }
        }
        .roundBackground("오늘의 소확행")
        .padding(.top, 14)
        .padding(.bottom, 16)
    }
}

//#Preview {
//    HomeTodayJoyView()
//}
