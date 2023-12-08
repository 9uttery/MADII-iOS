//
//  Joy.swift
//  Madii
//
//  Created by 이안진 on 12/8/23.
//

import Foundation

struct Joy: Identifiable {
    let id = UUID()
    let title: String
    var counts: Int = 0
    var satisfaction: Float = 100.0
    
    static let manyAchievedDummy: [Joy] = [Joy(title: "샤브샤브 먹기", counts: 21),
                                           Joy(title: "방어 먹기", counts: 17),
                                           Joy(title: "열라면 먹기", counts: 12),
                                           Joy(title: "연어 먹기", counts: 5),
                                           Joy(title: "돈까스 먹기", counts: 3)]
    
    static let dailyJoyDummy: [Joy] = [
        Joy(title: "샤브샤브 냠냠", satisfaction: 80.0),
        Joy(title: "방어 냠냠", satisfaction: 65.0),
        Joy(title: "전기장판에 누워서 귤 까먹기", satisfaction: 90.0)]
}

struct RecentAchievedJoy: Identifiable {
    let id = UUID()
    let date: String
    let joys: [Joy]
    
    static let dummys: [RecentAchievedJoy] = [RecentAchievedJoy(date: "2023.12.25", joys: [Joy(title: "넷플릭스 보면서 귤 까먹기"), Joy(title: "넷플릭스 보면서 귤 까먹기"), Joy(title: "넷플릭스 보면서 귤 까먹기")]), RecentAchievedJoy(date: "2023.12.24", joys: [Joy(title: "넷플릭스 보면서 귤 까먹기"), Joy(title: "넷플릭스 보면서 귤 까먹기")]), RecentAchievedJoy(date: "2023.12.23", joys: [Joy(title: "넷플릭스 보면서 귤 까먹기")])]
}
