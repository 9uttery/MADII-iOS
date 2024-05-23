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
            VStack(alignment: .center, spacing: 12) {
                Text("바쁜 일상 속\n나만의 일시정지 버튼")
                    .font(.spoqaHanSansNeo(weight: .bold, size: 28))
                    .foregroundStyle(Color.white)
                    .multilineTextAlignment(.center)
                
                Image("LaunchScreenGreen")
                    .resizable()
                    .frame(width: 168, height: 24)
            }
            .padding(.top, 96)
            
            Spacer()
            
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
                    button(image: "arrow.forward", title: "이메일로 로그인")
                }
                
                NavigationLink {
                    SignUpView(from: .id).navigationBarBackButtonHidden()
                } label: {
                    button(image: "person", title: "간편 회원가입")
                }
            }
            .padding(.bottom, 28)
        }
        .padding(.horizontal, 16)
        .background(OnboardingBackgroundGradient())
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .analyticsScreen(name: "로그인뷰")
    }
    
    @ViewBuilder
    private func button(image: String, title: String) -> some View {
        HStack(spacing: 8) {
            Spacer()
            
            Image(systemName: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20)
                .foregroundStyle(Color.black)
            
            Text(title)
                .madiiFont(font: .madiiBody2, color: .black)
            
            Spacer()
        }
        .frame(height: 56)
        .background(Color.white)
        .cornerRadius(12)
    }
}

#Preview {
    LoginView()
}
