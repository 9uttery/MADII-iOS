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

struct GetUsersStatResponse: Codable {
    let nickname: String
    let activeDays: Int
    let achievedJoyCount: Int
    let achievementCount: Int
}

struct GetNotificationListResponse: Codable {
    let notificationInfos: [GetNotificationResponse]
}

struct GetNotificationResponse: Codable {
    let title, contents, createdAt: String
}

struct GetNoticeResponse: Codable {
    let notices: [GetNoticeItemResponse]
}

struct GetNoticeItemResponse: Codable {
    let id: Int
    let title, contents, createdAt: String
}
