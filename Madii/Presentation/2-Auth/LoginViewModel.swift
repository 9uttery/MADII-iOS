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
    private let appleLoginManager = AppleLoginManager()
    
    init(router: Router) {
        self.router = router
    }
    
    enum Action {
        case kakaoLogin
        case appleLogin
        case signInWithID
        case loginWithID
    }
    
    func action(_ action: Action) {
        switch action {
        case .kakaoLogin:
            kakaoLogin()
        case .appleLogin:
            appleLogin()
        case .signInWithID:
            router.push(.signInWithID)
        case .loginWithID:
            router.push(.loginWithID)
        }
    }
    
    private func login(idToken: String) {
        UsersAPI.shared.loginWithKakao(idToken: idToken) { isSuccess, response in
            if isSuccess {
                UserDefaultsService()
                    .save(value: true, key: .hasEverOnboarded)
                
                if response.hasProfile {
                    self.router.isLoggedIn = true
                    print("DEBUG KakaoLoginButton: isSuccess true profile yes")
                } else {
                    self.router.push(.setProfile)
                    print("DEBUG KakaoLoginButton: isSuccess true profile no")
                }
            } else {
                print("DEBUG KakaoLoginButton: isSuccess false")
            }
        }
    }
    
    private func loginWithApple(idToken: String) {
        UsersAPI.shared.loginWithApple(idToken: idToken) { isSuccess, response in
            if isSuccess {
                UserDefaultsService()
                    .save(value: true, key: .hasEverOnboarded)
                
                if response.hasProfile {
                    self.router.isLoggedIn = true
                    print("DEBUG AppleLoginButton: isSuccess true profile yes")
                } else {
                    self.router.push(.setProfile)
                    print("DEBUG AppleLoginButton: isSuccess true profile no")
                }
            } else {
                print("DEBUG AppleLoginButton: isSuccess false")
            }
        }
    }
    
    private func appleLogin() {
        appleLoginManager.signIn { result in
            switch result {
            case .success(let credential):
                print("AppleLoginButton 로그인 성공:", credential.user)

                if let idToken = credential.identityToken,
                   let idTokenString = String(data: idToken, encoding: .utf8) {
                    print("AppleLoginButton DEBUG identityToken:", idTokenString)
                    self.loginWithApple(idToken: idTokenString)
                }

            case .failure(let error):
                print("AppleLoginButton 애플 로그인 실패:", error)
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
