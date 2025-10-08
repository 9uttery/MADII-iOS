//
//  KakaoLoginButton_P3.swift
//  Madii
//
//  Created by Anjin on 10/9/25.
//

import KakaoSDKAuth
import KakaoSDKCommon
import KakaoSDKUser
import SwiftUI

struct KakaoLoginButton_P3: View {
    @Environment(Router.self) var router
    
    var body: some View {
        Button {
            kakaoLogin()
        } label: {
            ZStack {
                Color(red: 1, green: 0.9, blue: 0)
                
                HStack {
                    Image(.kakaoLogo22)
                        .resizable()
                        .frame(width: 22, height: 22)
                    
                    Spacer()
                }
                .padding(.leading, 20)
                
                Text("카카오 로그인")
                    .madiiFont(.body1)
                    .foregroundStyle(Color.black)
            }
            .frame(height: 60)
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
    
    private func login(idToken: String) {
        UsersAPI.shared.loginWithKakao(idToken: idToken) { isSuccess, response in
            if isSuccess {
                // TODO: UserDefatuls 추가 필요 -> 이거 뭐임?
//                hasEverLoggedIn = true
                
                if response.hasProfile {
                    router.isLoggedIn = true
                    print("DEBUG KakaoLoginButton: isSuccess true profile yes")
                } else {
                    // TODO: 프로필 화면 없으면 약관 동의 + 프로필 등록
//                    showSignUpView = true
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
}
