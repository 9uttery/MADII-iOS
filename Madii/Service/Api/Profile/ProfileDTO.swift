//
//  ProfileDTO.swift
//  Madii
//
//  Created by 정태우 on 2/15/24.
//

import Foundation

struct GetUsersProfileResponse: Codable {
    let id: Int
    let nickname: String
    let image: String
}
