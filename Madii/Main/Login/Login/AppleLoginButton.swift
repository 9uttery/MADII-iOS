//
//  AppleLoginButton.swift
//  Madii
//
//  Created by 이안진 on 1/15/24.
//

import AuthenticationServices
import SwiftUI

struct AppleLoginButton: View {
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
                    print("DEBUG identityToken: \(String(data: idToken, encoding: .utf8) ?? "")")

                default:
                    print("DEBUG(애플 로그인): sign success but credetial is nil")
                }
            case .failure(let error):
                print("DEBUG(애플 로그인 error): \(error.localizedDescription)")
            }
        }
        .frame(height: 56)
        .cornerRadius(12)
    }
}

#Preview {
    AppleLoginButton()
}
