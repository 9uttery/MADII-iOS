//
//  LoginWithIDViewModel.swift
//  Madii
//
//  Created by 정태우 on 12/16/25.
//

import Foundation
import SwiftUI

@Observable
class LoginWithIDViewModel {
    var email: String = ""
    var password: String = ""
    var validate: Bool = false
    var loginError: LoginError?
    private let router: Router

    init(router: Router) {
        self.router = router
    }

    enum Action {
        case loginWithID
        case findPassword
        case validateLogin
    }

    func action(_ action: Action) {
        switch action {
        case .loginWithID:
            loginWithID()
        case .findPassword:
            findPassword()
        case .validateLogin:
            validateLogin()
        }
    }

    private func loginWithID() {
        UsersAPI.shared.loginWithId(id: email, password: password) { isSuccess, error, response in
            if isSuccess {
                // api 통신 성공
                if response.hasProfile {
                    // 프로필 저장 완료 -> 메인 화면으로
                    self.router.isLoggedIn = true
                    self.router.popToRoot()
                } else {
                    // 프로필 저장 전 -> 프로필 설정 화면으로
                    print("DEBUG(LoginWithIdView): login() hasProfile false")
                }
            } else {
                withAnimation {
                    self.loginError = error
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    self.loginError = nil
                }
                
                // api 통신 실패 || 계정 정보 없음
                print("DEBUG(LoginWithIdView): login() isSuccess false")
            }
        }
    }

    private func findPassword() {
        router.push(.findPassword)
    }

    func validateLogin() {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
//        let passwordRegex = #"^(?=.*[A-Za-z])(?=.*\d)(?=.*[!_*@])[A-Za-z\d!_*@]{8,}$"#
        
        let isEmailValid = NSPredicate(format: "SELF MATCHES %@", emailRegex)
            .evaluate(with: self.email)
        
//        let isPasswordValid = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
//            .evaluate(with: self.password)
        
        self.validate = isEmailValid && self.password.isEmpty == false
    }
}
