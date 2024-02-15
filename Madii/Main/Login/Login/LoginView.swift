//
//  LoginView.swift
//  Madii
//
//  Created by 이안진 on 12/27/23.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            Rectangle()
                .frame(height: 392)
                .padding(.bottom, 40)
            
            KakaoLoginButton()
                .padding(.bottom, 12)
            
            AppleLoginButton()
            
            Rectangle()
                .foregroundStyle(Color.white.opacity(0.2))
                .frame(height: 1)
                .padding(.vertical, 20)

            HStack(spacing: 8) {
                NavigationLink {
                    LoginWithIdView()
                } label: {
                    MadiiButton(title: "아이디로 로그인", color: .yellowGreen, size: .big)
                }
                
                NavigationLink {
                    SignUpView(from: .id).navigationBarBackButtonHidden()
                } label: {
                    MadiiButton(title: "간편 회원가입", color: .yellowGreen, size: .big)
                }

            }
            .padding(.bottom, 28)
        }
        .padding(.horizontal, 16)
        .background(OnboardingBackgroundGradient())
        .navigationTitle("")
    }
}
