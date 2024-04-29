//
//  JoyAPI.swift
//  Madii
//
//  Created by 이안진 on 2/19/24.
//

import Alamofire
import KeychainSwift
import SwiftUI

class JoyAPI {
    let keychain = KeychainSwift()
    let baseUrl = "https://\(Bundle.main.infoDictionary?["BASE_URL"] ?? "nil baseUrl")/v1"
    static let shared = JoyAPI()
    
    // (R-레코드) 소확행 기록
    func postJoy(contents: String, completion: @escaping (_ isSuccess: Bool, _ joyContent: PostJoyResponse) -> Void) {
        let url = "\(baseUrl)/joy"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(keychain.get("accessToken") ?? "")"
        ]
        let parameters: [String: String] = [
            "contents": contents
        ]
        
        let dummy = PostJoyResponse(joyId: 0, joyIconNum: 0, contents: "")
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: BaseResponse<PostJoyResponse>.self) { response in
                switch response.result {
                case .success(let response):
                    guard let data = response.data else {
                        print("DEBUG(postJoy): data nil")
                        completion(false, dummy)
                        return
                    }
                    
                    let statusCode = response.status
                    if statusCode == 200 {
                        // status 200으로 -> isSuccess: true
                        print("DEBUG(postJoy): success")
                        completion(true, data)
                    } else {
                        // status 200 아님 -> isSuccess: false
                        print("DEBUG(postJoy): status \(statusCode))")
                        completion(false, data)
                    }
                case .failure(let error):
                    print("DEBUG(postJoy): error \(error))")
                    completion(false, dummy)
                }
            }
    }
    
    // 소확행 삭제
    func deleteJoy(joyId: Int, completion: @escaping (_ isSuccess: Bool) -> Void) {
        let url = "\(baseUrl)/joy/\(joyId)"
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
                        print("DEBUG(deleteBookmarksByAlbumId): success")
                        completion(true)
                    } else {
                        // status 200 아님 -> isSuccess: false
                        print("DEBUG(deleteBookmarksByAlbumId): status \(statusCode))")
                        completion(false)
                    }
                    
                case .failure(let error):
                    print("DEBUG(deleteBookmarksByAlbumId): error \(error))")
                    completion(false)
                }
            }
    }
}

struct PostJoyResponse: Codable {
    let joyId, joyIconNum: Int
    let contents: String
}
