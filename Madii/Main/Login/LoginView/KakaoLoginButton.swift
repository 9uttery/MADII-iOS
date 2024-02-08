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
    var body: some View {
        Button {
            
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
    }
    
    private func kakaoLogin() {
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
