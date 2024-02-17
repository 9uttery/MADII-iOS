//
//  KakaoLoginButton.swift
//  Madii
//
//  Created by 이안진 on 2/8/24.
//

import KakaoSDKAuth
import KakaoSDKCommon
import KakaoSDKUser
import SwiftUI

struct KakaoLoginButton: View {
    @State private var showMainView: Bool = false
    @State private var showSignUpView: Bool = false
    
    var body: some View {
        Button {
            kakaoLogin()
        } label: {
            HStack {
                Image("kakaoLogin")
                    .frame(width: 22, height: 22)
                
                Spacer()
                
                Text("카카오 로그인")
                    .madiiFont(font: .madiiBody2, color: .black)
                
                Spacer()
            }
            .padding(16)
            .frame(height: 56)
            .background(Color(red: 1, green: 0.9, blue: 0))
            .cornerRadius(12)
        }
        .navigationDestination(isPresented: $showMainView) {
            MadiiTabView().navigationBarBackButtonHidden() }
        .navigationDestination(isPresented: $showSignUpView) {
            SignUpView(from: .kakao).navigationBarBackButtonHidden() }
    }
    
    private func login(idToken: String) {
        UsersAPI.shared.loginWithKakao(idToken: idToken) { isSuccess, response in
            if isSuccess {
                if response.hasProfile {
                    showMainView = true
                    print("DEBUG KakaoLoginButton: isSuccess true profile yes")
                } else {
                    // 프로필 화면 없으면 약관 동의 + 프로필 등록
                    showSignUpView = true
                    print("DEBUG KakaoLoginButton: isSuccess true profile no")
                }
            } else {
                print("DEBUG KakaoLoginButton: isSuccess false")
            }
        }
    }
    
    private func kakaoLogin() {
        if UserApi.isKakaoTalkLoginAvailable() {
            // 카카오톡 앱 실행 가능
            UserApi.shared.loginWithKakaoTalk { oauthToken, error in
                if let error = error {
                    print(error)
                } else {
                    print("DEBUG: loginWithKakaoTalk() success.")
                    
                    guard let idToken = oauthToken?.idToken else { return }
                    print("DEBUG: loginWithKakaoTalk() idToken - \(idToken)")
                    login(idToken: idToken)
                }
            }
        } else {
            // 카카오톡 앱 실행 불가능
            UserApi.shared.loginWithKakaoAccount { oauthToken, error in
                if let error = error {
                    print(error)
                } else {
                    print("DEBUG: loginWithKakaoAccount() success.")
                    
                    guard let idToken = oauthToken?.idToken else { return }
                    print("DEBUG: loginWithKakaoAccount() idToken - \(idToken)")
                    login(idToken: idToken)
                }
            }
        }
    }
    
    private func kakaoLogout() {
        UserApi.shared.logout { error in
            if let error = error {
                print("DEBUG: kakao logout error: \(error)")
            } else {
                print("DEBUG: kakao logout success.")
            }
        }
    }
    
    private func kakaoUnlink() {
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
    KakaoLoginButton()
}
