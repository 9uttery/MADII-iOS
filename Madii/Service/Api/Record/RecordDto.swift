//
//  RecordDto.swift
//  Madii
//
//  Created by 정태우 on 2/5/24.
//

import Foundation

struct PostJoyResponse: Codable {
    let joyIconNum: Int
    let contents: String
}

struct GetJoyResponse: Codable {
    let createdAt: String
    let size: Int
    let joyList: [GetJoyResponseJoy]
}

struct GetJoyResponseJoy: Codable {
    let joyId: Int
    let joyIconNum: Int
    let contents: String
}

struct GetAlbumsResponse: Codable {
    let albumId: Int
    let joyIconNum: Int
    let albumColorNum: Int
    let name: String
    let modifiedAt: String?
    let nickName: String?
}

struct PostAlbumResponse: Codable {
    let albumId: Int
    let name: String
}
