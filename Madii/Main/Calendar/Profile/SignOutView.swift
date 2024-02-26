//
//  SignOutView.swift
//  Madii
//
//  Created by 정태우 on 1/26/24.
//

import SwiftUI

struct SignOutView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var nickname: String = "에몽"
    @State var days: Int = 96
    @State var joy: Int = 32
    @State var play: Int = 231
    var body: some View {
        GeometryReader { geo in
            TabView {
                VStack {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("\(nickname)님은")
                            .madiiFont(font: .madiiTitle, color: .white)
                            .padding(.bottom, 8)
                        Text("\(days)일 동안 일상 속에서")
                            .madiiFont(font: .madiiTitle, color: .white)
                            .padding(.bottom, 8)
                        Text("\(joy)개의 소학행을")
                            .madiiFont(font: .madiiTitle, color: .white)
                            .padding(.bottom, 8)
                        HStack {
                            Text("\(play)번 재생해왔어요")
                                .madiiFont(font: .madiiTitle, color: .white)
                            Spacer()
                                .frame(width: UIScreen.main.bounds.width - 210)
                        }
                    }
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
                .frame(width: geo.size.height, height: geo.size.width)
                .rotationEffect(.degrees(-90))
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
                
                VStack {
                    VStack(alignment: .leading) {
                        Text("정말 마디를 떠나시겠어요?")
                            .madiiFont(font: .madiiTitle, color: .white)
                            .padding(.top, 44)
                            .padding(.bottom, 8)
                        Text("지금 마디를 탈퇴하게 되면")
                            .madiiFont(font: .madiiBody3, color: .white)
                        Text("모든 데이터와 기록이 사라지고")
                            .madiiFont(font: .madiiBody3, color: .white)
                        HStack {
                            Text("복원되지 않아요")
                                .madiiFont(font: .madiiBody3, color: .white)
                            Spacer()
                                .frame(width: UIScreen.main.bounds.width - 150)
                        }
                    }
                    .padding(.bottom, 88)
                    Image("TrashCan")
                    Spacer()
                        .frame(height: UIScreen.main.bounds.height - 708)
                    HStack {
                        NavigationLink {
                            SplashView()
                        } label: {
                            StyleJoyNextButton(label: "네, 탈퇴할래요", isDisabled: true)
                                .cornerRadius(6)
                        }
                        .simultaneousGesture(TapGesture().onEnded {
                            ProfileAPI.shared.deleteUsersProfile { isSuccess in
                                if isSuccess {
                                    print("회원탈퇴에 성공하였습니다.")
                                }
                            }
                        })
                        
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            StyleJoyNextButton(label: "아니요, 탈퇴 안 할래요", isDisabled: true, color: .madiiYellowGreen)
                                .cornerRadius(6)
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width - 36)
                }
                .frame(width: geo.size.height + 10, height: geo.size.width + 10)
                .edgesIgnoringSafeArea(.all)
                .rotationEffect(.degrees(-90))
                .background(
                    LinearGradient(
                        stops: [
                        Gradient.Stop(color: Color(red: 0.16, green: 0.16, blue: 0.28), location: 0.00),
                        Gradient.Stop(color: Color(red: 0.09, green: 0.09, blue: 0.15), location: 0.79),
                        Gradient.Stop(color: Color(red: 0.1, green: 0.1, blue: 0.16), location: 1.00)
                        ],
                    startPoint: UnitPoint(x: 0.5, y: -0.55),
                    endPoint: UnitPoint(x: 0.5, y: 1)
                    )
                )
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .rotationEffect(.degrees(90))
            .frame(width: geo.size.height, height: geo.size.width)
            .offset(x: -165, y: 160)
            .onAppear {
                ProfileAPI.shared.getUsersStat { isSuccess, userStat in
                    if isSuccess {
                        nickname = userStat.nickname
                        days = userStat.activeDays
                        joy = userStat.achievedJoyCount
                        play = userStat.achievementCount
                    }
                }
            }
            .navigationTitle("회원 탈퇴")
            .toolbarBackground(Color.madiiBox, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}

#Preview {
    SignOutView()
}
