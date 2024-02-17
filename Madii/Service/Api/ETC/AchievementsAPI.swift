//
//  AchievementsAPI.swift
//  Madii
//
//  Created by 이안진 on 2/18/24.
//

import Alamofire
import KeychainSwift
import SwiftUI

class AchievementsAPI {
    let keychain = KeychainSwift()
    let baseUrl = "https://\(Bundle.main.infoDictionary?["BASE_URL"] ?? "nil baseUrl")"
    static let shared = AchievementsAPI()
    
    // 캘린더 소확행 커버 조회
    func getJoyIconsForMonth(date: Date, completion: @escaping (_ isSuccess: Bool, _ response: GetJoyIconsForMonthResponse) -> Void) {
        let month: String = date.month.count < 2 ? "0\(date.month)" : date.month
        let startDate: String = "\(date.year)-\(month)-01"
        let endDate: String = "\(date.year)-\(month)-\(countDates(date: date))"
        let url = "\(baseUrl)/achievements/calender?startDate=\(startDate)&endDate=\(endDate)"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(keychain.get("accessToken") ?? "")",
            "Content-Type": "application/json"
        ]
        
        let dummy = GetJoyIconsForMonthResponse(dailyAchievementColorInfos: [])
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: BaseResponse<GetJoyIconsForMonthResponse>.self) { response in
                switch response.result {
                case .success(let response):
                    guard let data = response.data else {
                        print("DEBUG(get joy icons for month): data nil")
                        completion(false, dummy)
                        return
                    }
                    
                    let statusCode = response.status
                    if statusCode == 200 {
                        // status 200으로 -> isSuccess: true
                        print("DEBUG(get joy icons for month): success")
                        completion(true, data)
                    } else {
                        // status 200 아님 -> isSuccess: false
                        print("DEBUG(get joy icons for month): status \(statusCode))")
                        completion(false, data)
                    }
                    
                case .failure(let error):
                    print("DEBUG(get joy icons for month): error \(error))")
                    completion(false, dummy)
                }
            }
    }
    
    // 캘린더 소확행 일자별 상세 조회
    func getAchievedJoyForDay(date: Date, completion: @escaping (_ isSuccess: Bool, _ response: GetJoyIconsForDayResponse) -> Void) {
        let month: String = date.month.count < 2 ? "0\(date.month)" : date.month
        let day: String = date.day.count < 2 ? "0\(date.day)" : date.day
        let dateString: String = "\(date.year)-\(month)-\(day)"
        let url = "\(baseUrl)/achievements/calender/detail?date=\(dateString)"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(keychain.get("accessToken") ?? "")",
            "Content-Type": "application/json"
        ]
        
        let dummy = GetJoyIconsForDayResponse(dailyJoyAchievementInfos: [])
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: BaseResponse<GetJoyIconsForDayResponse>.self) { response in
                switch response.result {
                case .success(let response):
                    guard let data = response.data else {
                        print("DEBUG(get joy icons for day): data nil")
                        completion(false, dummy)
                        return
                    }
                    
                    let statusCode = response.status
                    if statusCode == 200 {
                        // status 200으로 -> isSuccess: true
                        print("DEBUG(get joy icons for day): success")
                        completion(true, data)
                    } else {
                        // status 200 아님 -> isSuccess: false
                        print("DEBUG(get joy icons for day): status \(statusCode))")
                        completion(false, data)
                    }
                    
                case .failure(let error):
                    print("DEBUG(get joy icons for day): error \(error))")
                    completion(false, dummy)
                }
            }
    }
    
    func countDates(date: Date) -> Int {
        let calendar = Calendar.current
        let monthRange = calendar.range(of: .day, in: .month, for: date)!

        return monthRange.count
    }
}

struct GetJoyIconsForMonthResponse: Codable {
    let dailyAchievementColorInfos: [JoyColorInfoForDate]
}

struct JoyColorInfoForDate: Codable {
    let date: String
    let achievementColorInfos: [JoyColorInfo]
}

struct JoyColorInfo: Codable {
    let joyId, joyIconNum: Int
}

struct GetJoyIconsForDayResponse: Codable {
    let dailyJoyAchievementInfos: [JoyColorInfoForDay]
}

struct JoyColorInfoForDay: Codable {
    let joyId, achievementId, joyIconNum: Int
    let contents, satisfaction: String
}

/*
 "dailyJoyAchievementInfos": [
             {
                 "joyId": 1,
                 "achievementId": 4,
                 "joyIconNum": 2,
                 "contents": "낮잠 자기1",
                 "satisfaction": "SO_SO"
             }
         ]
 */
