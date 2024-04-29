//
//  UserStatView.swift
//  Madii
//
//  Created by 정태우 on 3/1/24.
//

import SwiftUI

struct UserStatView: View {
    @State var nickname: String = "OO"
    @State var days: Int?
    @State var joy: Int?
    @State var play: Int?
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 0) {
                Text("\(nickname)님은")
                    .madiiFont(font: .madiiTitle, color: .white)
                    .padding(.bottom, 8)
                Text("\(days ?? 0)일 동안 일상 속에서")
                    .madiiFont(font: .madiiTitle, color: .white)
                    .padding(.bottom, 8)
                Text("\(joy ?? 0)개의 소확행을")
                    .madiiFont(font: .madiiTitle, color: .white)
                    .padding(.bottom, 8)
                HStack {
                    Text("\(play ?? 0)번 재생해왔어요")
                        .madiiFont(font: .madiiTitle, color: .white)
                    Spacer()
                }
            }
            .padding(.leading, 24)
            .padding(.bottom, 80)
            Image("CD")
                .resizable()
                .frame(width: 228, height: 228)
            Image("CDShadow")
                .resizable()
                .frame(width: 237, height: 139)
            Image("DownArrow")
                .resizable()
                .frame(width: 32, height: 80)
        }
        .id(0)
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(
            LinearGradient(
                stops: [
                    Gradient.Stop(color: Color(red: 0.16, green: 0.16, blue: 0.28), location: 0.00),
                    Gradient.Stop(color: Color(red: 0.09, green: 0.09, blue: 0.15), location: 0.79),
                    Gradient.Stop(color: Color(red: 0.1, green: 0.1, blue: 0.16), location: 1.00)
                ],
                startPoint: UnitPoint(x: 0.5, y: 0),
                endPoint: UnitPoint(x: 0.5, y: 1.62)
            )
        )
        .onAppear { getUserStat() }
    }
    private func getUserStat() {
        ProfileAPI.shared.getUsersStat { isSuccess, userStat in
            if isSuccess {
                nickname = userStat.nickname
                days = userStat.activeDays
                joy = userStat.achievedJoyCount
                play = userStat.achievementCount
            }
        }
    }
}

#Preview {
    UserStatView(nickname: "정태우", days: 24, joy: 113, play: 194)
}
