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
    
    // 오늘, 어제의 플레이리스트 조회
//    func getPlaylist(completion: @escaping (_ isSuccess: Bool, _ response: GetJoyIconsForDayResponse) -> Void) {
//        let url = "\(baseUrl)/achievements"
//        let headers: HTTPHeaders = [
//            "Authorization": "Bearer \(keychain.get("accessToken") ?? "")",
//            "Content-Type": "application/json"
//        ]
//        
//        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers)
//            .responseDecodable(of: BaseResponse<GetJoyIconsForDayResponse>.self) { response in
//                switch response.result {
//                case .success(let response):
//                    guard let data = response.data else {
//                        print("DEBUG(get joy icons for day): data nil")
//                        completion(false, dummy)
//                        return
//                    }
//                    
//                    let statusCode = response.status
//                    if statusCode == 200 {
//                        // status 200으로 -> isSuccess: true
//                        print("DEBUG(get joy icons for day): success")
//                        completion(true, data)
//                    } else {
//                        // status 200 아님 -> isSuccess: false
//                        print("DEBUG(get joy icons for day): status \(statusCode))")
//                        completion(false, data)
//                    }
//                    
//                case .failure(let error):
//                    print("DEBUG(get joy icons for day): error \(error))")
//                    completion(false, dummy)
//                }
//            }
//    }
    
    // 소확행 만족도 수정
    func putJoySatisfaction(achievementId: Int, satisfacton: Int, completion: @escaping (_ isSuccess: Bool) -> Void) {
        let url = "\(baseUrl)/achievements/rate"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(keychain.get("accessToken") ?? "")"
        ]
        let parameters: [String: Any] = [
            "achievementId": achievementId,
            "satisfaction": "SO_SO"
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: BaseResponse<Bool?>.self) { response in
                switch response.result {
                case .success(let response):
                    
                    let statusCode = response.status
                    if statusCode == 200 {
                        // status 200으로 -> isSuccess: true
                        print("DEBUG(postAlbumsJoyByJoyId): success")
                        completion(true)
                    } else {
                        // status 200 아님 -> isSuccess: false
                        print("DEBUG(postAlbumsJoyByJoyId): status \(statusCode))")
                        completion(false)
                    }
                    
                case .failure(let error):
                    print("DEBUG(postAlbumsJoyByJoyId): error \(error))")
                    completion(false)
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
    let achievementColorInfos: [Int]
}

struct GetJoyIconsForDayResponse: Codable {
    let dailyJoyAchievementInfos: [JoyColorInfoForDay]
}

struct JoyColorInfoForDay: Codable {
    let joyId, achievementId, joyIconNum: Int
    let contents, satisfaction: String
}

struct GetPlaylistResponse: Codable {
    let todayJoyPlayList: TodayJoyPlaylistResponse
}

struct TodayJoyPlaylistResponse: Codable {
    let date: String
    let joyAchievementInfos: [JoyAchievementsInfosResponse]
}

struct JoyAchievementsInfosResponse: Codable {
    let joyId, achievementId, joyIconNum: Int
    let contents: Int
    let isAchieved: Bool
    let satisfaction: String?
}

/*
 "data": {
         "todayJoyPlayList": {
             "date": "2024-02-17",
             "joyAchievementInfos": [
                 {
                     "joyId": 1,
                     "achievementId": 5,
                     "joyIconNum": 2,
                     "contents": "낮잠 자기1",
                     "isAchieved": false,
                     "satisfaction": null
                 },
                 {
                     "joyId": 1,
                     "achievementId": 4,
                     "joyIconNum": 2,
                     "contents": "낮잠 자기1",
                     "isAchieved": false,
                     "satisfaction": null
                 },
                 {
                     "joyId": 1,
                     "achievementId": 3,
                     "joyIconNum": 2,
                     "contents": "낮잠 자기1",
                     "isAchieved": true,
                     "satisfaction": "SO_SO"
                 }
             ]
         },
         "yesterdayJoyPlayList": {
             "date": "2024-02-16",
             "joyAchievementInfos": [
                 {
                     "joyId": 1,
                     "achievementId": 2,
                     "joyIconNum": 2,
                     "contents": "낮잠 자기1",
                     "isAchieved": false,
                     "satisfaction": null
                 }
             ]
         }
     },
 */
