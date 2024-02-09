//
//  RecordApi.swift
//  Madii
//
//  Created by 정태우 on 2/5/24.
//

import Alamofire
import Foundation
import KeychainSwift

class RecordAPI {
    let keychain = KeychainSwift()
    let baseUrl = "https://\(Bundle.main.infoDictionary?["BASE_URL"] ?? "nil baseUrl")"
    static let shared = RecordAPI()

    func getJoy(completion: @escaping (_ joyList: [GetJoyResponse]) -> Void) {
        let url = "\(baseUrl)/joy"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "\(keychain.get("accessToken") ?? "")"
        ]
        
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: BaseResponse<[GetJoyResponse]>.self) { response in
                switch response.result {
                case .success(let response):
                    guard let data = response.data else { return }
                    let resultCode = response.status
                    if resultCode == 200 { print("DEBUG(홈 사용자 정보 조회 success") }
                    print("DEBUG(알림화면 알림 리스트 조회 success인데 code가 \(resultCode))")
                    
                    completion(data)
                case .failure(let error):
                    print("DEBUG(알림화면 알림 리스트 조회 error: \(error))")
                    completion([])
                }
            }
    }
}
