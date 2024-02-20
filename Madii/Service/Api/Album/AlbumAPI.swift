//
//  AlbumAPI.swift
//  Madii
//
//  Created by 정태우 on 2/15/24.
//

import Alamofire
import Foundation
import KeychainSwift

class AlbumAPI {
    let keychain = KeychainSwift()
    let baseUrl = "https://\(Bundle.main.infoDictionary?["BASE_URL"] ?? "nil baseUrl")"
    static let shared = AlbumAPI()
    
    // 앨범 상세 조회
    func getAlbumsCreatedByMe(completion: @escaping (_ isSuccess: Bool, _ albumList: [GetAlbumsCreatedByMeResponse]) -> Void) {
        let url = "\(baseUrl)/albums/created"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(keychain.get("accessToken") ?? "")"
        ]
        
        let dummy = GetAlbumsCreatedByMeResponse(albumId: 0, name: "")
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: BaseResponse<[GetAlbumsCreatedByMeResponse]>.self) { response in
                switch response.result {
                case .success(let response):
                    guard let data = response.data else {
                        print("DEBUG(getAlbumsCreatedByMe): data nil")
                        completion(false, [dummy])
                        return
                    }
                    
                    let statusCode = response.status
                    if statusCode == 200 {
                        // status 200으로 -> isSuccess: true
                        print("DEBUG(getAlbumsCreatedByMe): success")
                        completion(true, data)
                    } else {
                        // status 200 아님 -> isSuccess: false
                        print("DEBUG(getAlbumsCreatedByMe): status \(statusCode))")
                        completion(false, data)
                    }
                    
                case .failure(let error):
                    print("DEBUG(getAlbumsCreatedByMe): error \(error))")
                    completion(false, [dummy])
                }
            }
    }
    
    // 최근 본 소확행 앨범 등록
    func postRecentByAlbumId(albumId: Int, completion: @escaping (_ isSuccess: Bool) -> Void) {
        let url = "\(baseUrl)/recent/\(albumId)"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(keychain.get("accessToken") ?? "")"
        ]
        
        AF.request(url, method: .post, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: BaseResponse<Bool?>.self) { response in
                switch response.result {
                case .success(let response):
                    
                    let statusCode = response.status
                    if statusCode == 200 {
                        // status 200으로 -> isSuccess: true
                        print("DEBUG(postRecentByAlbumId): success")
                        completion(true)
                    } else {
                        // status 200 아님 -> isSuccess: false
                        print("DEBUG(postRecentByAlbumId): status \(statusCode))")
                        completion(false)
                    }
                    
                case .failure(let error):
                    print("DEBUG(postRecentByAlbumId): error \(error))")
                    completion(false)
                }
            }
    }
    
    // 앨범 상세 조회
    func getAlbumByAlbumId(albumId: Int, completion: @escaping (_ isSuccess: Bool, _ albumInfo: GetAlbumByIdResponse) -> Void) {
        let url = "\(baseUrl)/albums/\(albumId)"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(keychain.get("accessToken") ?? "")"
        ]
        
        let dummy = GetAlbumByIdResponse(albumIconNum: 0, albumColorNum: 0, isAlbumSaved: false, name: "", nickname: "", description: "", joyInfoList: [])
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: BaseResponse<GetAlbumByIdResponse>.self) { response in
                switch response.result {
                case .success(let response):
                    guard let data = response.data else {
                        print("DEBUG(getAlbumByAlbumId): data nil")
                        completion(false, dummy)
                        return
                    }
                    
                    let statusCode = response.status
                    if statusCode == 200 {
                        // status 200으로 -> isSuccess: true
                        print("DEBUG(getAlbumByAlbumId): success")
                        completion(true, data)
                    } else {
                        // status 200 아님 -> isSuccess: false
                        print("DEBUG(getAlbumByAlbumId): status \(statusCode))")
                        completion(false, data)
                    }
                    
                case .failure(let error):
                    print("DEBUG(getAlbumByAlbumId): error \(error))")
                    completion(false, dummy)
                }
            }
    }
    
    // 특정 소확행 저장 여부와 함께 앨범 목록 조회
    func getAlbumsJoyByJoyId(joyId: Int, completion: @escaping (_ isSuccess: Bool, _ albumList: [GetAlbumsResponse]) -> Void) {
        let url = "\(baseUrl)/albums/joy/\(joyId)"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(keychain.get("accessToken") ?? "")"
        ]
        
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: BaseResponse<[GetAlbumsResponse]>.self) { response in
                switch response.result {
                case .success(let response):
                    guard let data = response.data else {
                        print("DEBUG(getAlbumsJoyByJoyId): data nil")
                        completion(false, [])
                        return
                    }
                    
                    let statusCode = response.status
                    if statusCode == 200 {
                        // status 200으로 -> isSuccess: true
                        print("DEBUG(getAlbumsJoyByJoyId): success")
                        completion(true, data)
                    } else {
                        // status 200 아님 -> isSuccess: false
                        print("DEBUG(getAlbumsJoyByJoyId): status \(statusCode))")
                        completion(false, data)
                    }
                    
                case .failure(let error):
                    print("DEBUG(getAlbumsJoyByJoyId): error \(error))")
                    completion(false, [])
                }
            }
    }
    
    // 앨범에 소확행 추가 (앨범 지정 팝업)
    func postAlbumsJoyByJoyId(joyId: Int, albumIds: [Int], completion: @escaping (_ isSuccess: Bool) -> Void) {
        let url = "\(baseUrl)/albums/joy/\(joyId)"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(keychain.get("accessToken") ?? "")"
        ]
        let parameters: [String: [Int]] = [
            "albumIds": albumIds
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: BaseResponse<Bool?>.self) { response in
                switch response.result {
                case .success(let response):
                    
                    let statusCode = response.status
                    if statusCode == 200 {
                        // status 200으로 -> isSuccess: true
                        print("DEBUG(postAlbumsJoyByJoyId): success")
                        completion(true)
                    } else {
                        // status 200 아님 -> isSuccess: false
                        print("DEBUG(postAlbumsJoyByJoyId): status \(statusCode))")
                        completion(false)
                    }
                    
                case .failure(let error):
                    print("DEBUG(postAlbumsJoyByJoyId): error \(error))")
                    completion(false)
                }
            }
    }
    
    // 앨범 이름, 설명 수정
    func putAlbumsByAlbumId(name: String, description: String, completion: @escaping (_ isSuccess: Bool) -> Void) {
        let url = "\(baseUrl)/albums"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(keychain.get("accessToken") ?? "")"
        ]
        let parameters: [String: String] = [
            "name": name,
            "description": description
        ]
        
        AF.request(url, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: BaseResponse<Bool?>.self) { response in
                switch response.result {
                case .success(let response):
                    
                    let statusCode = response.status
                    if statusCode == 200 {
                        // status 200으로 -> isSuccess: true
                        print("DEBUG(putAlbumsByAlbumId): success")
                        completion(true)
                    } else {
                        // status 200 아님 -> isSuccess: false
                        print("DEBUG(putAlbumsByAlbumId): status \(statusCode))")
                        completion(false)
                    }
                    
                case .failure(let error):
                    print("DEBUG(putAlbumsByAlbumId): error \(error))")
                    completion(false)
                }
            }
    }
    
    // 앨범 공개 여부 수정
    func putAlbumsStatusByAlbumId(albumId: Int, completion: @escaping (_ isSuccess: Bool) -> Void) {
        let url = "\(baseUrl)/albums/\(albumId)/status"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(keychain.get("accessToken") ?? "")"
        ]
        
        AF.request(url, method: .put, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: BaseResponse<Bool?>.self) { response in
                switch response.result {
                case .success(let response):
                    
                    let statusCode = response.status
                    if statusCode == 200 {
                        // status 200으로 -> isSuccess: true
                        print("DEBUG(putAlbumsStatusByAlbumId): success")
                        completion(true)
                    } else {
                        // status 200 아님 -> isSuccess: false
                        print("DEBUG(putAlbumsStatusByAlbumId): status \(statusCode))")
                        completion(false)
                    }
                    
                case .failure(let error):
                    print("DEBUG(putAlbumsStatusByAlbumId): error \(error))")
                    completion(false)
                }
            }
    }
    
    // 앨범 북마크 등록
    func postBookmarksByAlbumId(albumId: Int, completion: @escaping (_ isSuccess: Bool) -> Void) {
        let url = "\(baseUrl)/albums/\(albumId)/bookmarks"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(keychain.get("accessToken") ?? "")"
        ]
        
        AF.request(url, method: .post, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: BaseResponse<Bool?>.self) { response in
                switch response.result {
                case .success(let response):
                    
                    let statusCode = response.status
                    if statusCode == 200 {
                        // status 200으로 -> isSuccess: true
                        print("DEBUG(postBookmarksByAlbumId): success")
                        completion(true)
                    } else {
                        // status 200 아님 -> isSuccess: false
                        print("DEBUG(postBookmarksByAlbumId): status \(statusCode))")
                        completion(false)
                    }
                    
                case .failure(let error):
                    print("DEBUG(postBookmarksByAlbumId): error \(error))")
                    completion(false)
                }
            }
    }
    
    // 앨범 북마크 해제
    func deleteBookmarksByAlbumId(albumId: Int, completion: @escaping (_ isSuccess: Bool) -> Void) {
        let url = "\(baseUrl)/albums/\(albumId)/bookmarks"
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
    
    // 앨범 삭제
    func deleteAlbumsByAlbumId(albumId: Int, completion: @escaping (_ isSuccess: Bool) -> Void) {
        let url = "\(baseUrl)/albums/\(albumId)"
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
                        print("DEBUG(deleteAlbumsByAlbumId): success")
                        completion(true)
                    } else {
                        // status 200 아님 -> isSuccess: false
                        print("DEBUG(deleteAlbumsByAlbumId): status \(statusCode))")
                        completion(false)
                    }
                    
                case .failure(let error):
                    print("DEBUG(deleteAlbumsByAlbumId): error \(error))")
                    completion(false)
                }
            }
    }
}
