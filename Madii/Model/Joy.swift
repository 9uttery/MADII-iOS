//
//  Joy.swift
//  Madii
//
//  Created by 이안진 on 12/8/23.
//

import Foundation

struct Joy: Identifiable, Equatable {
    let id = UUID()
    let title: String
    var counts: Int = 0
    var satisfaction: Float = 100.0
    var weather: Int = 1
    var with: Int = 1
    var happy: Int = 1
    
    static let manyAchievedDummy: [Joy] = [Joy(title: "샤브샤브 먹기", counts: 21),
                                           Joy(title: "방어 먹기", counts: 17),
                                           Joy(title: "열라면 먹기", counts: 12),
                                           Joy(title: "연어 먹기", counts: 5),
                                           Joy(title: "돈까스 먹기", counts: 3)]
    
    static let dailyJoyDummy: [Joy] = [
        Joy(title: "산책하면서 크리스마스 플리 듣기", satisfaction: 80.0),
        Joy(title: "샤워하고 아이스크림 먹기", satisfaction: 65.0),
        Joy(title: "전기장판에 누워서 귤 까먹기", satisfaction: 90.0)]
    
    static let styleJoyDummy: [Joy] = [
        Joy(title: "산책하면서 크리스마스 플리 듣기", weather: 1, with: 2, happy: 3),
        Joy(title: "샤워하고 아이스크림 먹기", weather: 3, with: 2, happy: 1),
        Joy(title: "전기장판에 누워서 귤 까먹기", weather: 2, with: 1, happy: 3),
        Joy(title: "목욕하면서 크리스마스 플리 듣기", weather: 2, with: 2, happy: 2),
        Joy(title: "샤워하고 붕어빵 먹기", weather: 2, with: 2, happy: 1),
        Joy(title: "전기장판에 누워서 밤 까먹기", weather: 1, with: 2, happy: 3),
        Joy(title: "산책하면서 부활절 플리 듣기", weather: 2, with: 1, happy: 1),
        Joy(title: "목욕하고 아이스크림 먹기", weather: 2, with: 1, happy: 3),
        Joy(title: "쿨매트에 누워서 귤 까먹기", weather: 3, with: 3, happy: 3),
        Joy(title: "스키타면서 크리스마스 플리 듣기", weather: 2, with: 1, happy: 2),
        Joy(title: "샤워하고 술 먹기", weather: 1, with: 1, happy: 1),
        Joy(title: "전기장판에 서서 귤 까먹기", weather: 1, with: 1, happy: 2),
        Joy(title: "산책하면서 크리스마스 플리 만들기", weather: 3, with: 2, happy: 3),
        Joy(title: "샤워하고 아이스크림 사기", weather: 3, with: 2, happy: 1),
        Joy(title: "전기장판에 누워서 귤 버리기", weather: 2, with: 3, happy: 3),
        Joy(title: "코딩하면서 크리스마스 플리 듣기", weather: 3, with: 2, happy: 1),
        Joy(title: "운동하고 아이스크림 먹기", weather: 2, with: 2, happy: 1),
        Joy(title: "전기장판에 누워서 굴 까먹기", weather: 3, with: 1, happy: 2),
        Joy(title: "산책하면서 한강 플리 듣기", weather: 2, with: 2, happy: 3),
        Joy(title: "샤워하고 호떡 먹기", weather: 1, with: 2, happy: 2),
        Joy(title: "전기장판에 누워서 귤 따기", weather: 2, with: 3, happy: 1),
    ]
}

struct RecentAchievedJoy: Identifiable {
    let id = UUID()
    let date: String
    let joys: [Joy]
    
    static let dummys: [RecentAchievedJoy] = [RecentAchievedJoy(date: "2023.12.25", joys: [Joy(title: "넷플릭스 보면서 귤 까먹기"), Joy(title: "넷플릭스 보면서 귤 까먹기"), Joy(title: "넷플릭스 보면서 귤 까먹기")]), RecentAchievedJoy(date: "2023.12.24", joys: [Joy(title: "넷플릭스 보면서 귤 까먹기"), Joy(title: "넷플릭스 보면서 귤 까먹기")]), RecentAchievedJoy(date: "2023.12.23", joys: [Joy(title: "넷플릭스 보면서 귤 까먹기")])]
}
