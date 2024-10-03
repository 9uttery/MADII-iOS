//
//  AlbumDTO.swift
//  Madii
//
//  Created by 정태우 on 2/15/24.
//

import Foundation

struct GetAlbumByIdResponse: Codable {
    let isAlbumOfficial: Bool
    let albumIconNum, albumColorNum: Int
    let isAlbumSaved: Bool?
    let name: String
    let nickname: String?
    let description: String
    let joyInfoList: [GetAlbumByIdResponseJoyInfo]
}

struct GetAlbumByIdResponseJoyInfo: Codable {
    let joyId: Int
    let joyIconNum: Int
    let contents: String
    let isJoySaved: Bool?
}

struct GetAlbumsCreatedByMeResponse: Codable {
    let albumId: Int
    let name: String
}

struct JoyResponse: Encodable {
    var joyId: Int?
    var contents: String
    var joyOrder: Int
    
    func toDictionary() -> [String: Any] {
        return [
            "joyId": joyId ?? NSNull(), // nil인 경우 NSNull()으로 처리
            "contents": contents,
            "joyOrder": joyOrder
        ]
    }
}
