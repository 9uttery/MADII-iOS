//
//  AlbumDTO.swift
//  Madii
//
//  Created by 정태우 on 2/15/24.
//

import Foundation

struct GetAlbumByIdResponse: Codable {
    let isAlbumSaved: Bool
    let name: String
    let nickname: String?
    let description: String
    let joyInfoList: [GetAlbumByIdResponseJoyInfo]
}

struct GetAlbumByIdResponseJoyInfo: Codable {
    let joyId: Int
    let joyIconNum: Int
    let contents: String
    let isJoySaved: Bool
}

struct GetAlbumsCreatedByMeResponse: Codable {
    let albumId: Int
    let name: String
}
