//
//  Joy.swift
//  Madii
//
//  Created by 이안진 on 12/8/23.
//

import Foundation

struct Joy: Identifiable, Equatable {
    let id = UUID()
    var joyId: Int = 0 /// DB에서 사용하는 Joy id
    var achievementId: Int = 0 /// Server에서 사용하는 실천 Id
    var icon: Int = 1 /// Joy의 커버 아이콘 이미지
    let title: String
    var counts: Int = 0 /// 수행횟수
    var satisfaction: JoySatisfaction = .bad /// 만족도 1, 2, 3, 4, 5 가능
    var isSaved: Bool = false
}

enum JoySatisfaction: CaseIterable {
    case bad, soso, good, great, excellent
    
    var imageName: String {
        switch self {
        case .bad: "bad"
        case .soso: "soso"
        case .good: "good"
        case .great: "great"
        case .excellent: "excellent"
        }
    }
    
    var serverEnum: String {
        switch self {
        case .bad: "BAD"
        case .soso: "SO_SO"
        case .good: "GOOD"
        case .great: "GREAT"
        case .excellent: "EXCELLENT"
        }
    }
    
    // 서버에서 받은 String 값을 Enum으로 변환하는 메서드
    static func fromServer(_ string: String) -> JoySatisfaction {
        switch string {
        case "BAD": JoySatisfaction.bad
        case "SO_SO": JoySatisfaction.soso
        case "GOOD": JoySatisfaction.good
        case "GREAT": JoySatisfaction.great
        case "EXCELLENT": JoySatisfaction.excellent
        default: JoySatisfaction.bad
        }
    }
}

// dummy data
extension Joy {
    static let manyAchievedDummy: [Joy] = [Joy(title: "뜨끈한 메밀차 마시기 뜨끈한 메밀차 마시기 뜨끈한 메밀", counts: 21),
                                           Joy(title: "방어 먹기", counts: 17),
                                           Joy(title: "열라면 먹기", counts: 12),
                                           Joy(title: "연어 먹기", counts: 5),
                                           Joy(title: "돈까스 먹기", counts: 3)]
    
    static let dailyJoyDummy: [Joy] = [
        Joy(title: "산책하면서 크리스마스 플리 듣기", satisfaction: .soso),
        Joy(title: "샤워하고 아이스크림 먹기", satisfaction: .excellent),
        Joy(title: "전기장판에 누워서 귤 까먹기", satisfaction: .good)]
}

struct MyJoy: Identifiable {
    let id = UUID()
    let date: String
    let joys: [Joy]
    
    static let dummys: [MyJoy] = [MyJoy(date: "2023.12.25", joys: [Joy(title: "뜨끈한 메밀차 마시기 뜨끈한 메밀차 마시기 뜨끈한 메밀"), Joy(title: "넷플릭스 보면서 귤 까먹기"), Joy(title: "넷플릭스 보면서 귤 까먹기")]), 
                                  MyJoy(date: "2023.12.24", joys: [Joy(title: "넷플릭스 보면서 귤 까먹기"), Joy(title: "넷플릭스 보면서 귤 까먹기")]),
                                  MyJoy(date: "2023.12.23", joys: [Joy(title: "넷플릭스 보면서 귤 까먹기")]),
                                  MyJoy(date: "2023.12.22", joys: [Joy(title: "넷플릭스 보면서 귤 까먹기"), Joy(title: "넷플릭스 보면서 귤 까먹기"), Joy(title: "넷플릭스 보면서 귤 까먹기")])]
}
