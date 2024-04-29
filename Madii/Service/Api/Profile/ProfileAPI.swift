//
//  ProfileAPI.swift
//  Madii
//
//  Created by 정태우 on 2/15/24.
//

import Alamofire
import KeychainSwift
import SwiftUI

class ProfileAPI {
    let keychain = KeychainSwift()
    let baseUrl = "https://\(Bundle.main.infoDictionary?["BASE_URL"] ?? "nil baseUrl")/v1"
    static let shared = ProfileAPI()
    
    // 프로필 정보 조회
    func getUsersProfile(completion: @escaping (_ isSuccess: Bool, _ userProfile: GetUsersProfileResponse) -> Void) {
        let url = "\(baseUrl)/users/profile"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(keychain.get("accessToken") ?? "")"
        ]
        
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: BaseResponse<GetUsersProfileResponse>.self) { response in
                switch response.result {
                case .success(let response):
                    guard let data = response.data else {
                        print("DEBUG(getUsersProfile): data nil")
                        completion(false, GetUsersProfileResponse(id: 0, nickname: "", image: ""))
                        return
                    }
                    
                    let statusCode = response.status
                    if statusCode == 200 {
                        // status 200으로 -> isSuccess: true
                        print("DEBUG(getUsersProfile): success")
                        completion(true, data)
                    } else {
                        // status 200 아님 -> isSuccess: false
                        print("DEBUG(getUsersProfile): status \(statusCode))")
                        completion(false, data)
                    }
                    
                case .failure(let error):
                    print("DEBUG(getUsersProfile): error \(error))")
                    completion(false, GetUsersProfileResponse(id: 0, nickname: "", image: ""))
                }
            }
    }
    
    // 프로필 등록, 수정 url로
    func postUsersProfileWithImageUrl(nickname: String, imageUrl: String, completion: @escaping (_ isSuccess: Bool) -> Void) {
        let url = "\(baseUrl)/users/profile"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(keychain.get("accessToken") ?? "")"
        ]
        let parameters: [String: Any] = [
            "nickname": nickname,
            "image": imageUrl
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: BaseResponse<String?>.self) { response in
                switch response.result {
                case .success(let response):
                    let statusCode = response.status
                    if statusCode == 200 {
                        // status 200으로 -> isSuccess: true
                        print("DEBUG(postUsersProfile): success")
                        completion(true)
                    } else {
                        // status 200 아님 -> isSuccess: false
                        print("DEBUG(postUsersProfile): status \(statusCode))")
                        completion(false)
                    }
                    
                case .failure(let error):
                    print("DEBUG(postUsersProfile): error \(error))")
                    completion(false)
                }
            }
    }
    
    // 프로필 등록, 수정
    func postUsersProfile(nickname: String, image: UIImage, completion: @escaping (_ isSuccess: Bool) -> Void) {
        let url = "\(baseUrl)/users/profile"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(keychain.get("accessToken") ?? "")"
        ]
        
        var imageUrl: String = ""
        if image == UIImage(named: "defaultProfile") {
            imageUrl = "https://\(Bundle.main.infoDictionary?["DEFAULT_PROFILE_IMAGE_URL"] ?? "nil default profile image url")"
            
            let parameters: [String: Any] = [
                "nickname": nickname,
                "image": imageUrl
            ]
            
            AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
                .responseDecodable(of: BaseResponse<String?>.self) { response in
                    switch response.result {
                    case .success(let response):
                        let statusCode = response.status
                        if statusCode == 200 {
                            // status 200으로 -> isSuccess: true
                            print("DEBUG(postUsersProfile): success")
                            completion(true)
                        } else {
                            // status 200 아님 -> isSuccess: false
                            print("DEBUG(postUsersProfile): status \(statusCode))")
                            completion(false)
                        }
                        
                    case .failure(let error):
                        print("DEBUG(postUsersProfile): error \(error))")
                        completion(false)
                    }
                }
        } else {
            FileAPI.shared.uploadImageFile(image: image) { isSuccess, imageUrlString in
                if isSuccess {
                    print("DEBUG(postUsersProfile): file upload success \(imageUrlString)")
                    imageUrl = imageUrlString
                    
                    let parameters: [String: Any] = [
                        "nickname": nickname,
                        "image": imageUrl
                    ]
                    
                    print("wow url은 \(imageUrl)")
                    AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
                        .responseDecodable(of: BaseResponse<String?>.self) { response in
                            switch response.result {
                            case .success(let response):
                                let statusCode = response.status
                                if statusCode == 200 {
                                    // status 200으로 -> isSuccess: true
                                    print("DEBUG(postUsersProfile): success")
                                    completion(true)
                                } else {
                                    // status 200 아님 -> isSuccess: false
                                    print("DEBUG(postUsersProfile): status \(statusCode))")
                                    completion(false)
                                }
                                
                            case .failure(let error):
                                print("DEBUG(postUsersProfile): error \(error))")
                                completion(false)
                            }
                        }
                } else {
                    print("DEBUG(postUsersProfile): file upload success")
                }
            }
        }
    }
    
    // 공지사항 조회
    func getNotice(completion: @escaping (_ isSuccess: Bool, _ notices: [GetNoticeItemResponse]) -> Void) {
        let url = "\(baseUrl)/notices"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(keychain.get("accessToken") ?? "")"
        ]
        
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: BaseResponse<GetNoticeResponse>.self) { response in
                switch response.result {
                case .success(let response):
                    guard let data = response.data else {
                        print("DEBUG(getNotice): data nil")
                        completion(false, [])
                        return
                    }
                    
                    let statusCode = response.status
                    if statusCode == 200 {
                        // status 200으로 -> isSuccess: true
                        print("DEBUG(getNotice): success")
                        completion(true, data.notices)
                    } else {
                        // status 200 아님 -> isSuccess: false
                        print("DEBUG(getNotice): status \(statusCode))")
                        completion(false, data.notices)
                    }
                    
                case .failure(let error):
                    print("DEBUG(getNotice): error \(error))")
                    completion(false, [])
                }
            }
    }
    
    // 탈퇴 전 통계 정보 조회
    func getUsersStat(completion: @escaping (_ isSuccess: Bool, _ userStat: GetUsersStatResponse) -> Void) {
        let url = "\(baseUrl)/users/stat"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(keychain.get("accessToken") ?? "")"
        ]
        
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: BaseResponse<GetUsersStatResponse>.self) { response in
                switch response.result {
                case .success(let response):
                    guard let data = response.data else {
                        print("DEBUG(getUsersStat): data nil")
                        completion(false, GetUsersStatResponse(nickname: "", activeDays: 0, achievedJoyCount: 0, achievementCount: 0))
                        return
                    }
                    
                    let statusCode = response.status
                    if statusCode == 200 {
                        // status 200으로 -> isSuccess: true
                        print("DEBUG(getUsersStat): success")
                        completion(true, data)
                    } else {
                        // status 200 아님 -> isSuccess: false
                        print("DEBUG(getUsersStat): status \(statusCode))")
                        completion(false, data)
                    }
                    
                case .failure(let error):
                    print("DEBUG(getUsersStat): error \(error))")
                    completion(false, GetUsersStatResponse(nickname: "", activeDays: 0, achievedJoyCount: 0, achievementCount: 0))
                }
            }
    }
    
    // 회원 탈퇴하기
    func deleteUsersProfile(completion: @escaping (_ isSuccess: Bool) -> Void) {
        let url = "\(baseUrl)/users/profile"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(keychain.get("accessToken") ?? "")"
        ]
        
        AF.request(url, method: .delete, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: BaseResponse<Bool?>.self) { response in
                switch response.result {
                case .success(let response):
                    let statusCode = response.status
                    if statusCode == 200 {
                        // status 200으로 -> isSuccess: true
                        print("DEBUG(getUsersStat): success")
                        completion(true)
                    } else {
                        // status 200 아님 -> isSuccess: false
                        print("DEBUG(getUsersStat): status \(statusCode))")
                        completion(false)
                    }
                    
                case .failure(let error):
                    print("DEBUG(getUsersStat): error \(error))")
                    completion(false)
                }
            }
    }
    
    // 유저 로그아웃 하기
    func logout(completion: @escaping (_ isSuccess: Bool) -> Void) {
        let url = "\(baseUrl)/users/logout"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(keychain.get("accessToken") ?? "")"
        ]
        
        let parameters: [String: Any] = [
            "refreshToken": "\(keychain.get("refreshToken") ?? "")"
        ]
        
        AF.request(url, method: .delete, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: BaseResponse<Bool?>.self) { response in
                switch response.result {
                case .success(let response):
                    let statusCode = response.status
                    if statusCode == 200 {
                        // status 200으로 -> isSuccess: true
                        print("DEBUG(logout): success")
                        completion(true)
                    } else {
                        // status 200 아님 -> isSuccess: false
                        print("DEBUG(logout): status \(statusCode))")
                        completion(false)
                    }
                    
                case .failure(let error):
                    print("DEBUG(logout): error \(error))")
                    completion(false)
                }
            }
    }
    
    func getNotification(completion: @escaping (_ isSuccess: Bool, _ notices: [GetNotificationResponse]) -> Void) {
        let url = "\(baseUrl)/notification"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(keychain.get("accessToken") ?? "")"
        ]
        
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: BaseResponse<GetNotificationListResponse>.self) { response in
                switch response.result {
                case .success(let response):
                    guard let data = response.data else {
                        print("DEBUG(getNotificaiton): data nil")
                        completion(false, [])
                        return
                    }
                    
                    let statusCode = response.status
                    if statusCode == 200 {
                        // status 200으로 -> isSuccess: true
                        print("DEBUG(getNotificaiton): success")
                        completion(true, data.notificationInfos)
                    } else {
                        // status 200 아님 -> isSuccess: false
                        print("DEBUG(getNotificaiton): status \(statusCode))")
                        completion(false, data.notificationInfos)
                    }
                    
                case .failure(let error):
                    print("DEBUG(getNotificaiton): error \(error))")
                    completion(false, [])
                }
            }
    }
}
