//
//  UsersAPI.swift
//  Madii
//
//  Created by 이안진 on 2/10/24.
//

import Alamofire
import CryptoKit
import Foundation
import KeychainSwift
import SwiftUI

struct AuthAPI {
    let signUp = SignUpAPI()
}

struct SignUpAPI {
    // 회원가입 - 이메일 인증번호 전송
    func sendVerificationCodeToEmail(email: String, forSignUp: Bool = true) -> APIEndpoint<GetSendVerificationCodeResponse> {
        let path = "/mail/\(forSignUp ? "sign-up" : "password-reset")?email=\(email)"
        return APIEndpoint(method: .get, path: path, headerType: .withoutAuth)
    }
    
class UsersAPI {
    let keychain = KeychainSwift()
    let baseUrl = "https://\(Bundle.main.infoDictionary?["BASE_URL"] ?? "nil baseUrl")/v1"
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
    
    // 회원가입 - 입력한 인증번호 인증
    func verifyCode(email: String, code: String, completion: @escaping (_ isSuccess: Bool) -> Void) {
        let url = "\(baseUrl)/mail/verify?email=\(email)&code=\(code)"
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: BaseResponse<String?>.self) { response in
                switch response.result {
                case .success(let response):
                    let statusCode = response.status
                    if statusCode == 200 {
                        // status 200으로 -> isSuccess: true
                        print("DEBUG(verifyCode): success")
                        completion(true)
                    } else {
                        // status 200 아님 -> isSuccess: false
                        print("DEBUG(verifyCode): status \(statusCode))")
                        completion(false)
                    }
                    
                case .failure(let error):
                    print("DEBUG(verifyCode): error \(error))")
                    completion(false)
                }
            }
    }
    
    // 일반 회원가입
    func signUpWithId(id: String, password: String, agree: Bool, completion: @escaping (_ isSuccess: Bool, _ response: LoginResponse) -> Void) {
        let url = "\(baseUrl)/users/sign-up"
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        
        guard let hashedPassword = hashPassword(password: password) else { return }
        let parameters: [String: Any] = [
            "loginId": id,
            "password": hashedPassword,
            "agreesMarketing": agree
        ]
        
        let dummy = LoginResponse(accessToken: "", refreshToken: "", agreedMarketing: false, hasProfile: false)
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: BaseResponse<LoginResponse>.self) { response in
                switch response.result {
                case .success(let response):
                    print("DEBUG(sign-up) success \(response.message)")
                    self.loginWithId(id: id, password: password) { isSuccess, _, response in
                        if isSuccess {
                            print("DEBUG(sign-up) login success")
                            completion(true, response)
                        } else {
                            print("DEBUG(sign-up) login fail")
                            completion(false, response)
                        }
                    }
                case .failure(let error):
                    print("DEBUG(sign-up) error: \(error)")
                    completion(false, dummy)
                }
            }
    }

    func hashPassword(password: String) -> String? {
        guard let data = password.data(using: .utf8) else {
            return nil
        }
        
        let hashed = SHA256.hash(data: data)
        let hashedString = hashed.compactMap { String(format: "%02x", $0) }.joined()
        
        return hashedString
    }
    
    // 일반 로그인
    func loginWithId(id: String, password: String, completion: @escaping (_ isSuccess: Bool, _ loginError: LoginError?, _ response: LoginResponse) -> Void) {
        let url = "\(baseUrl)/users/login/normal"
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        
        guard let hashedPassword = hashPassword(password: password) else { return }
        let parameters: [String: Any] = [
            "loginId": id,
            "password": hashedPassword
        ]
        
        let dummy = LoginResponse(accessToken: "", refreshToken: "", agreedMarketing: false, hasProfile: false)
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: BaseResponse<LoginResponse>.self) { response in
                switch response.result {
                case .success(let response):
                    if response.code == "U001" {
                        completion(false, .nonexistence, dummy)
                    } else if response.code == "U002" {
                        completion(false, .wrongPassword, dummy)
                    }
                        
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
                    
                    self.saveFCMToken()
                    
                    completion(true, nil, data)
                    
                case .failure(let error):
                    print("DEBUG(login with id) error: \(error)")
                    completion(false, nil, dummy)
                }
            }
    }
    
    // 카카오 로그인
    func loginWithKakao(idToken: String, completion: @escaping (_ isSuccess: Bool, _ response: LoginResponse) -> Void) {
        let url = "\(baseUrl)/users/login/kakao"
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        let parameters: [String: Any] = [
            "idToken": idToken
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: BaseResponse<LoginResponse>.self) { response in
                switch response.result {
                case .success(let response):
                    guard let data = response.data else {
                        print("DEBUG(login with kakao): data nil")
                        return
                    }
                    
                    let accessToken = data.accessToken
                    let refreshToken = data.refreshToken
                    
                    print("DEBUG(login with kakao) access token: \(accessToken)")
                    print("DEBUG(login with kakao) refresh token: \(refreshToken)")
                    
                    self.keychain.set(accessToken, forKey: "accessToken", withAccess: .accessibleWhenUnlocked)
                    self.keychain.set(refreshToken, forKey: "refreshToken", withAccess: .accessibleWhenUnlocked)
                    
                    self.saveFCMToken()
                    
                    completion(true, data)
                    
                case .failure(let error):
                    print("DEBUG(login with kakao) error: \(error)")
                    completion(false, LoginResponse(accessToken: "", refreshToken: "", agreedMarketing: false, hasProfile: false))
                }
            }
    }
    
    // 애플 로그인
    func loginWithApple(idToken: String, completion: @escaping (_ isSuccess: Bool, _ response: LoginResponse) -> Void) {
        let url = "\(baseUrl)/users/login/apple"
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        let parameters: [String: Any] = [
            "idToken": idToken
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: BaseResponse<LoginResponse>.self) { response in
                switch response.result {
                case .success(let response):
                    guard let data = response.data else {
                        print("DEBUG(login with apple): data nil")
                        return
                    }
                    
                    let accessToken = data.accessToken
                    let refreshToken = data.refreshToken
                    
                    print("DEBUG(login with apple) access token: \(accessToken)")
                    print("DEBUG(login with apple) refresh token: \(refreshToken)")
                    
                    self.keychain.set(accessToken, forKey: "accessToken", withAccess: .accessibleWhenUnlocked)
                    self.keychain.set(refreshToken, forKey: "refreshToken", withAccess: .accessibleWhenUnlocked)
                    
                    self.saveFCMToken()
                    
                    completion(true, data)
                    
                case .failure(let error):
                    print("DEBUG(login with apple) error: \(error)")
                    completion(false, LoginResponse(accessToken: "", refreshToken: "", agreedMarketing: false, hasProfile: false))
                }
            }
    }
    
    // 토큰 재발급
    func reissueToken(completion: @escaping (_ isSuccess: Bool, _ response: LoginResponse) -> Void) {
        let url = "\(baseUrl)/users/refresh"
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        let parameters: [String: Any] = [
            "refreshToken": "\(keychain.get("refreshToken") ?? "")"
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: BaseResponse<LoginResponse>.self) { response in
                switch response.result {
                case .success(let response):
                    guard let data = response.data else {
                        print("DEBUG(reissue token): data nil")
                        return
                    }
                    
                    let accessToken = data.accessToken
                    let refreshToken = data.refreshToken
                    
                    print("DEBUG(reissue token) access token: \(accessToken)")
                    print("DEBUG(reissue token) refresh token: \(refreshToken)")
                    
                    self.keychain.set(accessToken, forKey: "accessToken", withAccess: .accessibleWhenUnlocked)
                    self.keychain.set(refreshToken, forKey: "refreshToken", withAccess: .accessibleWhenUnlocked)
                    
                    self.saveFCMToken()
                    
                    completion(true, data)
                    
                case .failure(let error):
                    print("DEBUG(reissue token) error: \(error)")
                    completion(false, LoginResponse(accessToken: "", refreshToken: "", agreedMarketing: false, hasProfile: false))
                }
            }
    }
    
    // 마케팅 동의 여부 수정
    func editMarketingAgree(agree: Bool, completion: @escaping (_ isSuccess: Bool) -> Void) {
        let url = "\(baseUrl)/users/marketing-agreement"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(keychain.get("accessToken") ?? "")",
            "Content-Type": "application/json"
        ]
        let parameters: [String: Any] = [
            "agreesMarketing": agree
        ]
        
        AF.request(url, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: BaseResponse<String?>.self) { response in
                switch response.result {
                case .success(let response):
                    let statusCode = response.status
                    if statusCode == 200 {
                        // status 200으로 -> isSuccess: true
                        print("DEBUG(edit marketing agree): success")
                        completion(true)
                    } else {
                        // status 200 아님 -> isSuccess: false
                        print("DEBUG(edit marketing agree): status \(statusCode))")
                        completion(false)
                    }
                    
                case .failure(let error):
                    print("DEBUG(edit marketing agree) error: \(error)")
                    completion(false)
                }
            }
    }
    
    private func saveFCMToken() {
        let token = UserDefaults.standard.value(forKey: "fcmToken") as? String
        
        let uuid = getUUID()
        print("uuid: \(uuid)")
        
        NotificationAPI.shared.postFCMToken(token: token ?? "", deviceId: uuid) { isSuccess in
            if isSuccess {
                print("fcm 토큰 저장 성공")
            } else {
                print("fcm 토큰 저장 실패")
            }
        }
    }
    
    private func getUUID() -> String {
        if let uuid = keychain.get("uuid") {
            // 키체인에 저장된 값이 있으면
            return uuid
        } else {
            // 키체인에 저장된 값이 없으면
            let newUUID = UIDevice.current.identifierForVendor?.uuidString ?? ""
            self.keychain.set(newUUID, forKey: "uuid")
            return newUUID
        }
    }
    
    // 비밀번호 재설정
    func resetPassword(email: String, password: String, completion: @escaping (_ isSuccess: Bool) -> Void) {
        let url = "\(baseUrl)/users/password-reset"
        let headers: HTTPHeaders = [
//            "Authorization": "Bearer \(keychain.get("accessToken") ?? "")",
            "Content-Type": "application/json"
        ]
        
        guard let hashedPassword = hashPassword(password: password) else { return }
        let parameters: [String: Any] = [
            "email": email,
            "password": hashedPassword
        ]
        
        AF.request(url, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: BaseResponse<String?>.self) { response in
                switch response.result {
                case .success(let response):
                    let statusCode = response.status
                    
                    switch statusCode {
                    case 200:
                        // status 200으로 -> isSuccess: true
                        print("DEBUG(resetPassword): success")
                        completion(true)
                    case 405:
                        // status 200 아님 -> isSuccess: false
                        print("DEBUG(resetPassword): status \(statusCode)) 사용자의 일반 로그인 정보가 없음")
                        completion(false)
                    default:
                        // status 200 아님 -> isSuccess: false
                        print("DEBUG(resetPassword): status \(statusCode))")
                        completion(false)
                    }
                    
                case .failure(let error):
                    print("DEBUG(resetPassword) error: \(error)")
                    completion(false)
                }
            }
    }
}
