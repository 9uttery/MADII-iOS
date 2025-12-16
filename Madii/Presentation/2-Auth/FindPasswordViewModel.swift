//
//  FindPasswordViewModel.swift
//  Madii
//
//  Created by 정태우 on 12/16/25.
//

import Foundation
import SwiftUI

@Observable
class FindPasswordViewModel {
    var email: String = ""
    var code: String = ""
    var validateEmail: Bool = false
    var validateCode: Bool = false
    private let router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    enum Action {
    }
    
    func action(_ action: Action) {
        switch action {
        }
    }
    
    private func loginWithID() {
        
    }
    
    private func findPassword() {
        router.push(.findPassword)
    }
    
    func emailValidate(){
        let emailRegex =
        #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        
        let passwordRegex =
        #"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$"#
        
        let isEmailValid = NSPredicate(format: "SELF MATCHES %@", emailRegex)
            .evaluate(with: self.email)
        
        self.validateEmail = isEmailValid
    }
}
