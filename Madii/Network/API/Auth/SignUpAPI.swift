//
//  SignUpAPI.swift
//  Madii
//
//  Created by Anjin on 1/7/25.
//

import Foundation

struct SignUpAPI {
    // 회원가입 - 이메일 인증번호 전송
    func sendVerificationCodeToEmail(email: String, forSignUp: Bool = true) -> APIEndpoint<GetSendVerificationCodeResponse> {
        let type = forSignUp ? "sign-up" : "password-reset"
        let path = APIPaths.mail.rawValue + "/\(type)?email=\(email)"
        return APIEndpoint(method: .get, path: path, headerType: .withoutAuth)
    }
    
    // 회원가입 - 입력한 인증번호 인증
    func verifyCode(email: String, code: String) -> APIEndpoint<EmptyResponse?> {
        let path = APIPaths.mail.rawValue + "/verify?email=\(email)&code=\(code)"
        return APIEndpoint(method: .get, path: path, headerType: .withoutAuth)
    }
    
    // 일반 회원가입
    func sighUpWithEmail(info: PostSignUpRequest) -> APIEndpoint<PostSignUpResponse> {
        let path = APIPaths.users.rawValue + "/sign-up"
        
        let encodedPassword = EncodingService().encodingPassword(info.password)
        let parameters: [String: Any] = [
            "loginId": info.email,
            "password": encodedPassword ?? "",
            "agreesMarketing": info.agree
        ]
        
        return APIEndpoint(
            method: .post,
            path: path,
            headerType: .withoutAuth,
            body: parameters
        )
    }
}
