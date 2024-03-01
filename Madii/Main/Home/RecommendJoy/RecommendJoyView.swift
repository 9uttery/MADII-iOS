//
//  RecommendJoyView.swift
//  Madii
//
//  Created by 정태우 on 1/28/24.
//

import SwiftUI

struct RecommendJoyView: View {
    @State private var updatePlaylistBar: Bool = false
    @Environment(\.presentationMode) var presentationMode
    @State var nickname: String = "코코"
    @State var recommendJoy: GetJoyResponseJoy = GetJoyResponseJoy(joyId: 0, joyIconNum: 1, contents: "넷플릭스 보면서 귤까기")
    @Binding var isActive: Bool
    var body: some View {
        VStack(spacing: 0) {
            Text("\(nickname)님을 위한 소확행이에요!")
                .madiiFont(font: .madiiSubTitle, color: .white)
                .padding(.top, 28)
                .padding(.bottom, 68)
            VStack(spacing: 0) {
                ZStack {
                    Circle()
                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                        .frame(width: 220, height: 220)
                        .background(Color.black)
                        .cornerRadius(110)
                    
                    Image("icon_\(recommendJoy.joyIconNum)")
                        .resizable()
                        .frame(width: 118, height: 118)
                }
                .padding(.bottom, 42)
                
                Text(recommendJoy.contents)
                .madiiFont(font: .madiiSubTitle, color: .white)
                .padding(.bottom, 20)
            }
            .padding(.top, 40)
            .padding(.horizontal, 50)
            .padding(.bottom, 48)
            .background(Color.madiiBox)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .inset(by: 0.5)
                    .stroke(
                        LinearGradient(
                            stops: [
                                Gradient.Stop(color: .white, location: 0.00),
                                Gradient.Stop(color: .white.opacity(0.2), location: 0.27),
                                Gradient.Stop(color: .white, location: 0.51),
                                Gradient.Stop(color: .white.opacity(0.2), location: 0.77),
                                Gradient.Stop(color: .white, location: 1.00)
                            ],
                        startPoint: UnitPoint(x: 0.5, y: 0),
                        endPoint: UnitPoint(x: 0.5, y: 1)
                    ), lineWidth: 1)
            )
            .padding(.bottom, 28)
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("다시 고르기")
                    .madiiFont(font: .madiiBody4, color: .white)
                    .underline()
            }
            Spacer()
    
            Button {
                isActive = true
                presentationMode.wrappedValue.dismiss()
            } label: {
                StyleJoyNextButton(label: "오늘의 플레이 리스트에 추가하기", isDisabled: true)
            }
            .simultaneousGesture(TapGesture().onEnded {
                AchievementsAPI.shared.playJoy(joyId: recommendJoy.joyId) { isSuccess in
                    if isSuccess {
                        print("DEBUG JoyMenuBottomSheet: 오플리에 추가 true")
                    } else {
                        print("DEBUG JoyMenuBottomSheet: 오플리에 추가 false")
                    }
                }
            })
        }
        .navigationTitle("\(nickname)님의 취향저격 소확행")
        .toolbarBackground(Color.clear, for: .navigationBar)
        .padding(.horizontal, 16)
        .background(
            LinearGradient(
            stops: [
            Gradient.Stop(color: Color(red: 0.61, green: 0.42, blue: 1).opacity(0.2), location: 0.00),
            Gradient.Stop(color: Color(red: 0.5, green: 0.77, blue: 0.91).opacity(0.2), location: 0.48),
            Gradient.Stop(color: Color(red: 0.81, green: 0.98, blue: 0.32).opacity(0.2), location: 1.00)
            ],
            startPoint: UnitPoint(x: 0.5, y: -0.19),
            endPoint: UnitPoint(x: 0.5, y: 1.5)
            )
        )
        .background(Color(red: 0.06, green: 0.06, blue: 0.13))
        .onAppear {
            ProfileAPI.shared.getUsersProfile { isSuccess, userProfile in
                if isSuccess {
                    nickname = userProfile.nickname
                }
            }
        }
    }
}

#Preview {
    RecommendJoyView(isActive: .constant(false))
}
