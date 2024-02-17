//
//  AppleLoginButton.swift
//  Madii
//
//  Created by 이안진 on 1/15/24.
//

import AuthenticationServices
import SwiftUI

struct AppleLoginButton: View {
    @State private var showMainView: Bool = false
    @State private var showSignUpView: Bool = false
    
    var body: some View {
        SignInWithAppleButton { request in
            request.requestedScopes = [.fullName]
        } onCompletion: { result in
            switch result {
            case .success(let auth):
                switch auth.credential {
                case let credential as ASAuthorizationAppleIDCredential:
                    print("DEBUG(애플 로그인 success): \(credential.realUserStatus)")

                    guard let idToken = credential.identityToken else { return }
                    guard let idTokenString = String(data: idToken, encoding: .utf8) else { return }
                    print("DEBUG identityToken: \(idTokenString)")
                    loginWithApple(idToken: idTokenString)

                default:
                    print("DEBUG(애플 로그인): sign success but credetial is nil")
                }
            case .failure(let error):
                print("DEBUG(애플 로그인 error): \(error.localizedDescription)")
            }
        }
        .frame(height: 56)
        .cornerRadius(12)
        .navigationDestination(isPresented: $showMainView) {
            MadiiTabView().navigationBarBackButtonHidden() }
        .navigationDestination(isPresented: $showSignUpView) {
            SignUpView(from: .kakao).navigationBarBackButtonHidden() }
    }
    
    private func loginWithApple(idToken: String) {
        UsersAPI.shared.loginWithApple(idToken: idToken) { isSuccess, response in
            if isSuccess {
                if response.hasProfile {
                    showMainView = true
                    print("DEBUG AppleLoginButton: isSuccess true profile yes")
                } else {
                    // 프로필 화면 없으면 약관 동의 + 프로필 등록
                    showSignUpView = true
                    print("DEBUG AppleLoginButton: isSuccess true profile no")
                }
            } else {
                print("DEBUG AppleLoginButton: isSuccess false")
            }
        }
    }
}

#Preview {
    AppleLoginButton()
}
