//
//  DailySummaryDTO.swift
//  Madii
//
//  Created by 정태우 on 9/27/25.
//

import Foundation

struct GetDailySummaryDTO: Codable {
    let dailySummaryId: Int
    let satisfaction: Int
    let createdDate: String
    let savingJoys: [JoyDTO]
    let attachedImages: [String]
    let diaryContent: String
}

struct JoyDTO: Codable {
    let joyId: Int
    let emotions: [String]
}

struct GetAchievementByDateDTO: Codable {
    let date: String
    let joyAchievementInfos: [JoyAchievementsInfosDTO]
}

struct JoyAchievementsInfosDTO: Codable {
    let joyID: Int
    let achievementId: Int
    let joyIconNum: Int
    let conetnets: String
    let isachieved: Bool
}
