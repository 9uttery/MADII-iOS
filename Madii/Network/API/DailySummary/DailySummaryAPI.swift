//
//  DailySummaryAPI.swift
//  Madii
//
//  Created by 정태우 on 9/27/25.
//

import PhotosUI
import Alamofire
import CryptoKit
import Foundation
import KeychainSwift
import SwiftUI

class DailySummaryAPI {
    let keychain = KeychainSwift()
    let baseUrl = "https://\(Bundle.main.infoDictionary?["BASE_URL"] ?? "nil baseUrl")/v2"
    static let shared = DailySummaryAPI()

    // 특정 날짜 오하돌 단건 조회
    func getDailySummary(date: Date, completion: @escaping (_ isSuccess: Bool, _ dailySummary: GetDailySummaryDTO) -> Void) {
        let url = "\(baseUrl)/daily-summary"
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: BaseResponse<GetDailySummaryDTO?>.self) { response in
                switch response.result {
                case .success(let response):
                    guard let data = response.data else {
                        print("DEBUG(getIdCheck): data nil")
                        completion(false, GetDailySummaryDTO(dailySummaryId: 0, satisfaction: 0, createdDate: "", savingJoys: [], attachedImages: [], diaryContent: ""))
                        return
                    }
                    
                    let statusCode = response.status
                    if statusCode == 200 {
                        // status 200으로 -> isSuccess: true
                        print("DEBUG(getIdCheck): success")
                        completion(true, data!)
                    } else {
                        // status 200 아님 -> isSuccess: false
                        print("DEBUG(getIdCheck): status \(statusCode))")
                        completion(false, data!)
                    }
                    
                case .failure(let error):
                    print("DEBUG(getIdCheck): error \(error))")
                    completion(false, GetDailySummaryDTO(dailySummaryId: 0, satisfaction: 0, createdDate: "", savingJoys: [], attachedImages: [], diaryContent: ""))
                }
            }
    }
    
    // 특정 날짜 소확행 플레이리스트 조회
    func getAchievementByDate(date: Date, isFinished: Bool, completion: @escaping (_ isSuccess: Bool, _ playList: GetAchievementByDateDTO) -> Void) {
        let month: String = date.month.count < 2 ? "0\(date.month)" : date.month
        let day: String = date.day.count < 2 ? "0\(date.day)" : date.day
        let dateString: String = "\(date.year)-\(month)-\(day)"
        let url = "\(baseUrl)/achievements?date=\(dateString)&isFinished=\(isFinished)"
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: BaseResponse<GetAchievementByDateDTO>.self) { response in
                switch response.result {
                case .success(let response):
                    guard let data = response.data else {
                        print("DEBUG(getIdCheck): data nil")
                        completion(false, GetAchievementByDateDTO(date: "", joyAchievementInfos: []))
                        return
                    }
                    
                    let statusCode = response.status
                    if statusCode == 200 {
                        // status 200으로 -> isSuccess: true
                        print("DEBUG(getIdCheck): success")
                        completion(true, data)
                    } else {
                        // status 200 아님 -> isSuccess: false
                        print("DEBUG(getIdCheck): status \(statusCode))")
                        completion(false, data)
                    }
                    
                case .failure(let error):
                    print("DEBUG(getIdCheck): error \(error))")
                    completion(false, GetAchievementByDateDTO(date: "", joyAchievementInfos: []))
                }
            }
    }
    
    // 오늘 하루 돌아보기 생성
    func postDailySummary(date: Date, satisfaction: Int, diaryContent: String, savingJoys: [SavingJoysRequestDTO], images: [UIImage], completion:  @escaping (_ isSuccess: Bool, _ dailySummary: PostDailySummary) -> Void) {
        let month: String = date.month.count < 2 ? "0\(date.month)" : date.month
        let day: String = date.day.count < 2 ? "0\(date.day)" : date.day
        let dateString: String = "\(date.year)-\(month)-\(day)"
        let url = "\(baseUrl)/daily-summary"
        
        let savingJoysDTO = savingJoys.map { joy in
            [
                "joyId": joy.joyId,
                "emotions": joy.emotion
            ] as [String : Any]
        }
        
        AF.upload(multipartFormData: { multipartFormData in
            if let dateData = dateString.data(using: .utf8) {
                multipartFormData.append(dateData, withName: "date")
            }
            if let satData = String(satisfaction).data(using: .utf8) {
                multipartFormData.append(satData, withName: "satisfaction")
            }
            if let diaryData = diaryContent.data(using: .utf8) {
                multipartFormData.append(diaryData, withName: "diaryContent")
            }
            
            // 2) savingJoys: JSON 데이터로 직렬화해서 하나의 파트로 보냄
            if let sjData = try? JSONSerialization.data(withJSONObject: savingJoysDTO, options: []) {
                multipartFormData.append(sjData, withName: "savingJoys", mimeType: "application/json")
            }
            
            for (index, image) in images.enumerated() {
                if let imageData = image.jpegData(compressionQuality: 0.8) {
                    let filename = "image_\(index)_\(UUID().uuidString).jpg"
                    
                    multipartFormData.append(imageData,
                                             withName: "images",
                                             fileName: filename,
                                             mimeType: "image/jpeg")
                }
            }
        }, to: url, method: .post, headers: nil)
        .validate()
        .responseDecodable(of: PostDailySummary.self) { response in
            switch response.result {
            case .success(let dailySummary):
                DispatchQueue.main.async { completion(true, dailySummary) }
            case .failure(let error):
                print("❌ upload failed:", error)
                DispatchQueue.main.async { completion(false, PostDailySummary(dailySummaryId: 0, satisfaction: 0, createdDate: "", savingJoys: [], attachedImages: [], diaryContent: "")) }
            }
        }
    }
}
