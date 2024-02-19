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

struct GetJoyResponseJoy: Codable, Identifiable {
    var id: Int {
        return joyId
    }
    let joyId: Int
    let joyIconNum: Int
    let contents: String
}

struct GetAlbumsResponse: Codable, Identifiable {
    var id: Int {
        return albumId
    }
    let albumId: Int
    let joyIconNum: Int
    let albumColorNum: Int
    let name: String
    let modifiedAt: String?
    let nickname: String?
}

struct PostAlbumResponse: Codable {
    let albumId: Int
    let name: String
}
