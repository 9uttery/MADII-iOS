//
//  AuthDTO.swift
//  Madii
//
//  Created by Anjin on 1/6/25.
//

import Foundation

// 응답 - 인증코드 발송
struct GetSendVerificationCodeResponse: Codable {
    let code: String
}

// 요청 - 회원가입
struct PostSignUpRequest {
    let email: String
    let password: String
    let agree: Bool
}

// 응답 - 회원가입
struct PostSignUpResponse: Codable {
    let accessToken, refreshToken: String
    let agreedMarketing, hasProfile: Bool
}
