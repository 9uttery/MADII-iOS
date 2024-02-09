//
//  UsersAPI.swift
//  Madii
//
//  Created by 이안진 on 2/10/24.
//

import Alamofire
import Foundation
import KeychainSwift

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
}
