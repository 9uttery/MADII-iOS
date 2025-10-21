//
//  LoginViewModel.swift
//  Madii
//
//  Created by Anjin on 10/18/25.
//

import KakaoSDKAuth
import KakaoSDKCommon
import KakaoSDKUser
import Foundation

@Observable
class LoginViewModel {
    private let router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    enum Action {
        case kakaoLogin
    }
    
    func action(_ action: Action) {
        switch action {
        case .kakaoLogin:
            kakaoLogin()
        }
    }
    
    private func login(idToken: String) {
        UsersAPI.shared.loginWithKakao(idToken: idToken) { isSuccess, response in
            if isSuccess {
                // TODO: UserDefatuls 추가 필요 -> 이거 뭐임?
//                hasEverLoggedIn = true
                
                if response.hasProfile {
                    self.router.isLoggedIn = true
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
                    self.login(idToken: idToken)
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
                    self.login(idToken: idToken)
                }
            }
        }
    }
}
