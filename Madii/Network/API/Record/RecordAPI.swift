//
//  RecordAPI.swift
//  Madii
//
//  Created by 정태우 on 2/5/24.
//

import Alamofire
import Foundation
import KeychainSwift

class RecordAPI {
    let keychain = KeychainSwift()
    let baseUrl = "https://\(Bundle.main.infoDictionary?["BASE_URL"] ?? "nil baseUrl")/v1"
    static let shared = RecordAPI()
    
    // (R-레코드) 소확행 기록 placeholder -> 이전 완료 🔥
    func getPlaceholder(completion: @escaping (_ isSuccess: Bool, _ placeholder: String) -> Void) {
        let url = "\(baseUrl)/placeholders"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(keychain.get("accessToken") ?? "")"
        ]
        
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: BaseResponse<GetPlaceholderResponse>.self) { response in
                
                switch response.result {
                case .success(let response):
                    guard let data = response.data else {
                        print("DEBUG(getPlaceholder): data nil")
                        completion(false, "")
                        return
                    }
                    
                    let statusCode = response.status
                    if statusCode == 200 {
                        // status 200으로 -> isSuccess: true
                        print("DEBUG(getPlaceholder): success")
                        completion(true, data.contents)
                    } else {
                        // status 200 아님 -> isSuccess: false
                        print("DEBUG(getPlaceholder): status \(statusCode))")
                        completion(false, data.contents)
                    }
                    
                case .failure(let error):
                    print("DEBUG(getPlaceholder): error \(error))")
                    completion(false, "")
                }
            }
    }
    
    // (R-레코드) 최근 본 소확행 앨범 조회
    func getRecent(completion: @escaping (_ isSuccess: Bool, _ albumList: [GetRecentAlbumResponse]) -> Void) {
        let url = "\(baseUrl)/albums/recent"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(keychain.get("accessToken") ?? "")"
        ]
        
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: BaseResponse<[GetRecentAlbumResponse]>.self) { response in
                switch response.result {
                case .success(let response):
                    guard let data = response.data else {
                        print("DEBUG(getRecent): data nil")
                        completion(false, [])
                        return
                    }
                    
                    let statusCode = response.status
                    if statusCode == 200 {
                        // status 200으로 -> isSuccess: true
                        print("DEBUG(getRecent): success")
                        completion(true, data)
                    } else {
                        // status 200 아님 -> isSuccess: false
                        print("DEBUG(getRecent): status \(statusCode))")
                        completion(false, data)
                    }
                    
                case .failure(let error):
                    print("DEBUG(getRecent): error \(error))")
                    completion(false, [])
                }
            }
    }
    
    // (R-레코드) 내가 기록한 소확행 조회
    func getJoy(completion: @escaping (_ isSuccess: Bool, _ joyList: [GetMyJoyResponse]) -> Void) {
        let url = "\(baseUrl)/joy"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(keychain.get("accessToken") ?? "")"
        ]
        
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: BaseResponse<[GetMyJoyResponse]>.self) { response in
                switch response.result {
                case .success(let response):
                    guard let data = response.data else {
                        print("DEBUG(getJoy): data nil")
                        completion(false, [])
                        return
                    }
                    
                    let statusCode = response.status
                    if statusCode == 200 {
                        // status 200으로 -> isSuccess: true
                        print("DEBUG(getJoy): success")
                        completion(true, data)
                    } else {
                        // status 200 아님 -> isSuccess: false
                        print("DEBUG(getJoy): status \(statusCode))")
                        completion(false, data)
                    }
                    
                case .failure(let error):
                    print("DEBUG(getJoy): error \(error))")
                    completion(false, [])
                }
            }
    }
    
    // (R-레코드) 많이 실천한 소확행 조회
    func getMostAchievedJoy(completion: @escaping (_ isSuccess: Bool, _ joyList: GetMostAchievedJoyResponse) -> Void) {
        let url = "\(baseUrl)/joy/most"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(keychain.get("accessToken") ?? "")"
        ]
        
        let dummy = GetMostAchievedJoyResponse(mostAchievedJoyInfos: [])
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: BaseResponse<GetMostAchievedJoyResponse>.self) { response in
                switch response.result {
                case .success(let response):
                    guard let data = response.data else {
                        print("DEBUG(getJoy): data nil")
                        completion(false, dummy)
                        return
                    }
                    
                    let statusCode = response.status
                    if statusCode == 200 {
                        // status 200으로 -> isSuccess: true
                        print("DEBUG(getJoy): success")
                        completion(true, data)
                    } else {
                        // status 200 아님 -> isSuccess: false
                        print("DEBUG(getJoy): status \(statusCode))")
                        completion(false, data)
                    }
                    
                case .failure(let error):
                    print("DEBUG(getJoy): error \(error))")
                    completion(false, dummy)
                }
            }
    }
    
    // (R-레코드) 내가 만든 & 저장한 앨범 목록 조회
    func getAlbums(completion: @escaping (_ isSuccess: Bool, _ albumList: [GetAlbumsResponse]) -> Void) {
        let url = "\(baseUrl)/albums"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(keychain.get("accessToken") ?? "")"
        ]
        
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: BaseResponse<[GetAlbumsResponse]>.self) { response in
                switch response.result {
                case .success(let response):
                    guard let data = response.data else {
                        print("DEBUG(getAlbums): data nil")
                        completion(false, [])
                        return
                    }
                    
                    let statusCode = response.status
                    if statusCode == 200 {
                        // status 200으로 -> isSuccess: true
                        print("DEBUG(getAlbums): success")
                        completion(true, data)
                    } else {
                        // status 200 아님 -> isSuccess: false
                        print("DEBUG(getAlbums): status \(statusCode))")
                        completion(false, data)
                    }
                    
                case .failure(let error):
                    print("DEBUG(getAlbums): error \(error))")
                    completion(false, [])
                }
            }
    }
    
    // (R-레코드) 다른 소확행 앨범 모음 조회
    func getRandomAlbumsById(albumId: Int, completion: @escaping (_ isSuccess: Bool, _ albumList: [GetRandomAlbumsResponse]) -> Void) {
        let url = "\(baseUrl)/albums/\(albumId)/random"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(keychain.get("accessToken") ?? "")"
        ]
        
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: BaseResponse<[GetRandomAlbumsResponse]>.self) { response in
                switch response.result {
                case .success(let response):
                    guard let data = response.data else {
                        print("DEBUG(getRandomAlbumsById): data nil")
                        completion(false, [])
                        return
                    }
                    
                    let statusCode = response.status
                    if statusCode == 200 {
                        // status 200으로 -> isSuccess: true
                        print("DEBUG(getRandomAlbumsById): success")
                        completion(true, data)
                    } else {
                        // status 200 아님 -> isSuccess: false
                        print("DEBUG(getRandomAlbumsById): status \(statusCode))")
                        completion(false, data)
                    }
                    
                case .failure(let error):
                    print("DEBUG(getRandomAlbumsById): error \(error))")
                    completion(false, [])
                }
            }
    }
    
    // 새로운 앨범 생성
    func postAlbum(name: String, description: String, completion: @escaping (_ isSuccess: Bool, _ albumList: [PostAlbumResponse]) -> Void) {
        let url = "\(baseUrl)/albums"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(keychain.get("accessToken") ?? "")"
        ]
        let parameters: [String: String] = [
            "name": name,
            "description": description
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: BaseResponse<[PostAlbumResponse]>.self) { response in
                switch response.result {
                case .success(let response):
                    guard let data = response.data else {
                        print("DEBUG(PostAlbum): data nil")
                        completion(false, [])
                        return
                    }
                    
                    let statusCode = response.status
                    if statusCode == 200 {
                        // status 200으로 -> isSuccess: true
                        print("DEBUG(PostAlbum): success")
                        completion(true, data)
                    } else {
                        // status 200 아님 -> isSuccess: false
                        print("DEBUG(PostAlbum): status \(statusCode))")
                        completion(false, data)
                    }
                    
                case .failure(let error):
                    print("DEBUG(PostAlbum): error \(error))")
                    completion(false, [])
                }
            }
    }
    
    // 소확행 수정
    func editJoy(joyId: Int, contents: String, beforeAlbumIds: [Int], afterAlbumIds: [Int], completion: @escaping (_ isSuccess: Bool, _ response: EditJoyResponse) -> Void) {
        let url = "\(baseUrl)/joy/\(joyId)"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(keychain.get("accessToken") ?? "")"
        ]
        let parameters: [String: Any] = [
            "contents": contents,
            "beforeAlbumIds": beforeAlbumIds,
            "afterAlbumIds": afterAlbumIds
        ]
        
        print("수정수정 \(url), \(headers), \(parameters)")
        
        let dummy = EditJoyResponse(joyIconNum: 0, contents: "")
        AF.request(url, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: BaseResponse<EditJoyResponse>.self) { response in
                switch response.result {
                case .success(let response):
                    guard let data = response.data else {
                        print("DEBUG(editJoy): data nil")
                        completion(false, dummy)
                        return
                    }
                    
                    let statusCode = response.status
                    if statusCode == 200 {
                        // status 200으로 -> isSuccess: true
                        print("DEBUG(editJoy): success")
                        completion(true, data)
                    } else {
                        // status 200 아님 -> isSuccess: false
                        print("DEBUG(editJoy): status \(statusCode))")
                        completion(false, data)
                    }
                    
                case .failure(let error):
                    print("DEBUG(editJoy): error \(error))")
                    completion(false, dummy)
                }
            }
    }
}
