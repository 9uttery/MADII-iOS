//
//  NotificationAPI.swift
//  Madii
//
//  Created by 이안진 on 2/29/24.
//

import Alamofire
import KeychainSwift
import SwiftUI

class NotificationAPI {
    let keychain = KeychainSwift()
    let baseUrl = "https://\(Bundle.main.infoDictionary?["BASE_URL"] ?? "nil baseUrl")/v1"
    static let shared = NotificationAPI()
    
    // fcm token 등록
    func postFCMToken(token: String, deviceId: String, completion: @escaping (_ isSuccess: Bool) -> Void) {
        let url = "\(baseUrl)/notification/token"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(keychain.get("accessToken") ?? "")"
        ]
        let parameters: [String: String] = [
            "token": token,
            "deviceId": deviceId
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: BaseResponse<Bool?>.self) { response in
                switch response.result {
                case .success(let response):
                    let statusCode = response.status
                    if statusCode == 200 {
                        // status 200으로 -> isSuccess: true
                        print("DEBUG(postFCMToken): success")
                        completion(true)
                    } else {
                        // status 200 아님 -> isSuccess: false
                        print("DEBUG(postFCMToken): status \(statusCode))")
                        completion(false)
                    }
                case .failure(let error):
                    print("DEBUG(postFCMToken): error \(error))")
                    completion(false)
                }
            }
    }
}
