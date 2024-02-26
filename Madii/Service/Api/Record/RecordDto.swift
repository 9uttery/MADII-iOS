//
//  RecordDto.swift
//  Madii
//
//  Created by 정태우 on 2/5/24.
//

import Foundation

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

struct GetMostAchievedJoyResponse: Codable {
    let mostAchievedJoyInfos: [GetMostAchievedJoyInfoResponse]
}

struct GetMostAchievedJoyInfoResponse: Codable {
    let joyId, joyIconNum: Int
    let contents: String
    let isCreatedByMe: Bool
    let achieveCount, rank: Int
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

struct GetAlbumsWithJoySavedResponse: Codable {
    let isSaved: Bool
    let albumId: Int
    let joyIconNum: Int
    let albumColorNum: Int
    let name: String
    let modifiedAt: String?
}

struct GetRandomAlbumsResponse: Codable {
    let albumId, joyIconNum, albumColorNum: Int
    let name: String
}

struct PostAlbumResponse: Codable {
    let albumId: Int
    let name: String
}

struct GetRecentAlbumResponse: Codable {
    let albumId, joyIconNum, albumColorNum: Int
    let name: String
}
