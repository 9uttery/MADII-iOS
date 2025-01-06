//
//  UsersDTO.swift
//  Madii
//
//  Created by 이안진 on 2/10/24.
//

import Foundation

struct LoginResponse: Codable {
    let accessToken, refreshToken: String
    let agreedMarketing, hasProfile: Bool
}
