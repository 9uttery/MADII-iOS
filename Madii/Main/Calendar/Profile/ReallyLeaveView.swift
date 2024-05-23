//
//  ReallyLeaveView.swift
//  Madii
//
//  Created by 정태우 on 3/1/24.
//

import SwiftUI

struct ReallyLeaveView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
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
                }
            }
            .padding(.top, 44)
            .padding(.leading, 24)
            .padding(.bottom, 88)
            Image("TrashCan")
            
            Spacer()
            
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
                    AnalyticsManager.shared.logEvent(name: "탈퇴뷰_회원탈퇴클릭")
                })
                
                Button {
                    presentationMode.wrappedValue.dismiss()
                    AnalyticsManager.shared.logEvent(name: "탈퇴뷰_탈퇴안함클릭")
                } label: {
                    StyleJoyNextButton(label: "아니요, 탈퇴 안 할래요", isDisabled: true, color: .madiiYellowGreen)
                        .cornerRadius(6)
                }
            }
            .padding(.horizontal, 15)
            .padding(.bottom, 100)
        }
        .id(1)
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
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
}

#Preview {
    ReallyLeaveView()
}
