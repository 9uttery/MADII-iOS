//
//  LoginView.swift
//  Madii
//
//  Created by 이안진 on 12/27/23.
//

import KakaoSDKAuth
import KakaoSDKCommon
import KakaoSDKUser
import SwiftUI

struct LoginView: View {
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            Rectangle()
                .frame(height: 392)
                .padding(.bottom, 40)
            
            Button {
                kakaoLogin()
            } label: {
                Text("카카오 로그인")
            }
            
            Button {
                kakaoUnlink()
            } label: {
                Text("카카오 연결 해제")
            }
            
            HStack {
                Circle()
                    .frame(width: 22, height: 22)
                    .foregroundStyle(Color.black)
                Spacer()
                Text("카카오 로그인")
                    .madiiFont(font: .madiiBody2, color: .black)
                Spacer()
            }
            .padding(16)
            .background(Color(red: 1, green: 0.9, blue: 0))
            .cornerRadius(12)
            .padding(.bottom, 12)
            
            AppleLoginButton()
            
            Rectangle()
                .foregroundStyle(Color.white.opacity(0.2))
                .frame(height: 1)
                .padding(.vertical, 20)

            HStack(spacing: 8) {
                MadiiButton(title: "아이디로 로그인", color: .yellowGreen, size: .small)
                MadiiButton(title: "간편 회원가입", color: .yellowGreen, size: .small)
            }
            .padding(.bottom, 48)
        }
        .padding(.horizontal, 16)
        .background(OnboardingBackgroundGradient())
    }

    func kakaoLogin() {
        if UserApi.isKakaoTalkLoginAvailable() {
            // 카카오톡 앱 실행 가능
            UserApi.shared.loginWithKakaoTalk { oauthToken, error in
                if let error = error {
                    print(error)
                } else {
                    print("DEBUG: loginWithKakaoTalk() success.")

                    // do something
                    _ = oauthToken
                }
            }
        } else {
            // 카카오톡 앱 실행 불가능
            UserApi.shared.loginWithKakaoAccount { oauthToken, error in
                if let error = error {
                    print(error)
                } else {
                    print("DEBUG: loginWithKakaoAccount() success.")

                    // do something
                    _ = oauthToken
                }
            }
        }
    }
    
    func kakaoLogout() {
        UserApi.shared.logout { error in
            if let error = error {
                print("DEBUG: kakao logout error: \(error)")
            } else {
                print("DEBUG: kakao logout success.")
            }
        }
    }
    
    func kakaoUnlink() {
        UserApi.shared.unlink {(error) in
            if let error = error {
                print("DEBUG: kakao unlink error: \(error)")
            } else {
                print("DEBUG: kakao unlink success.")
            }
        }
    }
}

#Preview {
    LoginView()
}
