//
//  UsersAPI.swift
//  Madii
//
//  Created by 이안진 on 2/10/24.
//

import Alamofire
import Foundation
import KeychainSwift
import SwiftUI

class UsersAPI {
    let keychain = KeychainSwift()
    let baseUrl = "https://\(Bundle.main.infoDictionary?["BASE_URL"] ?? "nil baseUrl")"
    static let shared = UsersAPI()

    // 아이디 중복체크
    func getIdCheck(id: String, completion: @escaping (_ isSuccess: Bool, _ canUseID: Bool) -> Void) {
        let url = "\(baseUrl)/users/id-check?loginId=\(id)"
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: BaseResponse<Bool>.self) { response in
                switch response.result {
                case .success(let response):
                    guard let data = response.data else {
                        print("DEBUG(getIdCheck): data nil")
                        completion(false, false)
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
                    completion(false, false)
                }
            }
    }
    
    // 일반 로그인
    func loginWithId(id: String, password: String, completion: @escaping (_ isSuccess: Bool, _ response: LoginResponse) -> Void) {
        let url = "\(baseUrl)/users/login/normal"
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        let parameters: [String: Any] = [
            "loginId": id,
            "password": password
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: BaseResponse<LoginResponse>.self) { response in
                switch response.result {
                case .success(let response):
                    guard let data = response.data else {
                        print("DEBUG(login with id): data nil")
                        return
                    }
                    
                    let accessToken = data.accessToken
                    let refreshToken = data.refreshToken
                    
                    print("DEBUG(login with id) access token: \(accessToken)")
                    print("DEBUG(login with id) refresh token: \(refreshToken)")
                    
                    self.keychain.set(accessToken, forKey: "accessToken", withAccess: .accessibleWhenUnlocked)
                    self.keychain.set(refreshToken, forKey: "refreshToken", withAccess: .accessibleWhenUnlocked)
                    
                    // UserDefaults.standard.set(true, forKey: "isLoggedIn")
                    
                    completion(true, data)
                    
                case .failure(let error):
                    print("DEBUG(login with id) error: \(error)")
                    completion(false, LoginResponse(accessToken: "", refreshToken: "", agreedMarketing: false, hasProfile: false))
                }
            }
    }
}
