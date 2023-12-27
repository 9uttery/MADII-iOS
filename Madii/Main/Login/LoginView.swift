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
        VStack {
            HStack { Spacer() }
            Spacer()

            Button {
                kakaoLogin()
            } label: {
                Text("카카오 로그인")
                    .font(.title.bold())
            }
            
            Button {
                kakaoLogout()
            } label: {
                Text("카카오 로그아웃")
                    .font(.title.bold())
            }
            
            Button {
                kakaoUnlink()
            } label: {
                Text("카카오 연결 해제")
                    .font(.title.bold())
            }

            Spacer()
        }
        .background(background())
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

    func background() -> LinearGradient {
        LinearGradient(
            stops: [
                Gradient.Stop(color: Color(red: 0.09, green: 0.09, blue: 0.15), location: 0.00),
                Gradient.Stop(color: Color(red: 0.42, green: 0.44, blue: 0.68), location: 1.00)
            ],
            startPoint: UnitPoint(x: 0.5, y: 0),
            endPoint: UnitPoint(x: 0.5, y: 1)
        )
    }
}

#Preview {
    LoginView()
}
