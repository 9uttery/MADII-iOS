//
//  ProfileAPI.swift
//  Madii
//
//  Created by 정태우 on 2/15/24.
//

import Alamofire
import Foundation
import KeychainSwift

class ProfileAPI {
    let keychain = KeychainSwift()
    let baseUrl = "https://\(Bundle.main.infoDictionary?["BASE_URL"] ?? "nil baseUrl")"
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
    
    // 프로필 등록, 수정
    func postUsersProfile(nickname: String, image: String, completion: @escaping (_ isSuccess: Bool) -> Void) {
        let url = "\(baseUrl)/users/profile"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(keychain.get("accessToken") ?? "")"
        ]
        let parameters: [String: Any] = [
            "nickname": nickname,
            "image": image
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: BaseResponse<Bool?>.self) { response in
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
}
