//
//  LoginView_P3.swift
//  Madii
//
//  Created by Anjin on 9/27/25.
//

import MadiiDesignSystem
import SwiftUI

struct LoginView_P3: View {
    @Environment(LoginViewModel.self) var viewModel
    
    var body: some View {
        ZStack {
            LoginBackground()
                .ignoresSafeArea()
            
            VStack(spacing: 40) {
                VStack(spacing: 20) {
                    Text("바쁜 일상 속\n나만의 일시정지 버튼")
                        .madiiFont(.subTitle)
                        .foregroundStyle(Color.madiiNormal)
                        .multilineTextAlignment(.center)
                    
                    Image(.splashLogo)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 240)
                }
                
                Spacer()
                
                VStack(spacing: 28) {
                    VStack(spacing: 10) {
                        // 카카오 로그인
                        KakaoLoginButton_P3()
                        
                        // 애플 로그인
                        AppleLoginButton_P3()
                    }
                    
                    // 아이디 로그인, 회원가입
                    HStack(spacing: 10) {
                        MadiiDesignSystem.MadiiButton(
                            title: "아이디로 로그인",
                            color: .mainColor,
                            type: .medium,
                            action: { viewModel.action(.loginWithID) }
                        )
                        
                        MadiiDesignSystem.MadiiButton(
                            title: "간편 회원가입",
                            color: .mainColor,
                            type: .medium,
                            action: { viewModel.action(.signInWithID) }
                        )
                    }
                }
            }
            .padding(.top, 130)
            .padding(.horizontal, 20)
            .padding(.bottom, 16)
        }
    }
}

private struct LoginBackground: View {
    var body: some View {
        LinearGradient(
            stops: [
                Gradient.Stop(color: .black, location: 0.00),
                Gradient.Stop(color: Color(red: 0.08, green: 0.1, blue: 0.21), location: 1.00)
            ],
            startPoint: UnitPoint(x: 0.5, y: 0),
            endPoint: UnitPoint(x: 0.5, y: 1)
        )
    }
}

#Preview {
    let router = Router(
        onboardingRepository: .init(userDefaults: .init()),
        container: .init()
    )
    
    LoginView_P3()
        .environment(router)
}
