//
//  HomeAPI.swift
//  Madii
//
//  Created by 정태우 on 2/15/24.
//

import Alamofire
import Foundation
import KeychainSwift

class HomeAPI {
    let keychain = KeychainSwift()
    let baseUrl = "https://\(Bundle.main.infoDictionary?["BASE_URL"] ?? "nil baseUrl")/v1"
    static let shared = HomeAPI()
    
    // (H-홈) 오늘의 소확행 조회
    func getJoyToday(completion: @escaping (_ isSuccess: Bool, _ todayJoy: GetJoyResponseJoy) -> Void) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.string(from: Date())
        let url = "\(baseUrl)/joy/today?date=\(date)"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(keychain.get("accessToken") ?? "")"
        ]
        
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: BaseResponse<GetJoyResponseJoy>.self) { response in
                switch response.result {
                case .success(let response):
                    guard let data = response.data else {
                        print("DEBUG(postJoyRecommend): data nil")
                        completion(false, GetJoyResponseJoy(joyId: 0, joyIconNum: 0, contents: "", isJoySaved: false))
                        return
                    }
                    
                    let statusCode = response.status
                    if statusCode == 200 {
                        // status 200으로 -> isSuccess: true
                        print("DEBUG(postJoyRecommend): success")
                        completion(true, data)
                    } else {
                        // status 200 아님 -> isSuccess: false
                        print("DEBUG(postJoyRecommend): status \(statusCode))")
                        completion(false, data)
                    }
                    
                case .failure(let error):
                    print("DEBUG(postJoyRecommend): error \(error))")
                    completion(false, GetJoyResponseJoy(joyId: 0, joyIconNum: 0, contents: "", isJoySaved: false))
                }
            }
    }
    
    // (H-홈) 오늘의 소확행 조회
    func postJoyRecommend(when: [Int], who: [Int], which: [Int], completion: @escaping (_ isSuccess: Bool, _ joyList: [GetJoyResponseJoy]) -> Void) {
        let url = "\(baseUrl)/joy/recommend"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(keychain.get("accessToken") ?? "")"
        ]
        let parameters: [String: Any] = [
            "when": when,
            "who": who,
            "which": which
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: BaseResponse<[GetJoyResponseJoy]>.self) { response in
                switch response.result {
                case .success(let response):
                    guard let data = response.data else {
                        print("DEBUG(postJoyRecommend): data nil")
                        completion(false, [])
                        return
                    }
                    
                    let statusCode = response.status
                    if statusCode == 200 {
                        // status 200으로 -> isSuccess: true
                        print("DEBUG(postJoyRecommend): success")
                        completion(true, data)
                    } else {
                        // status 200 아님 -> isSuccess: false
                        print("DEBUG(postJoyRecommend): status \(statusCode))")
                        completion(false, data)
                    }
                    
                case .failure(let error):
                    print("DEBUG(postJoyRecommend): error \(error))")
                    completion(false, [])
                }
            }
    }
    
    func getAllAlbums(albumId: Int?, size: Int, completion: @escaping (_ isSuccess: Bool, _ allAlbum: GetAllAlbumsResponse) -> Void) {
        var albumIdString = ""
        if let albumId = albumId {
            albumIdString = String(albumId)
        }
        let url = "\(baseUrl)/albums/all?albumId=\(albumIdString)&size=\(size)"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(keychain.get("accessToken") ?? "")"
        ]
        
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: BaseResponse<GetAllAlbumsResponse>.self) { response in
                switch response.result {
                case .success(let response):
                    guard let data = response.data else {
                        print("DEBUG(getAllAlbums): data nil")
                        completion(false, GetAllAlbumsResponse(content: [], pageable: GetAllAlbumsResponsePageable(pageNumber: 0, pageSize: 0, sort: [], offset: 0, unpaged: false, paged: false), size: 0, number: 0, sort: [], first: true, last: false, numberOfElements: 0, empty: true))
                        return
                    }
                    
                    let statusCode = response.status
                    if statusCode == 200 {
                        // status 200으로 -> isSuccess: true
                        print("DEBUG(getAllAlbums): success")
                        completion(true, data)
                    } else {
                        // status 200 아님 -> isSuccess: false
                        print("DEBUG(getAllAlbums): status \(statusCode))")
                        completion(false, data)
                    }
                    
                case .failure(let error):
                    print("DEBUG(getAllAlbums): error \(error))")
                    completion(false, GetAllAlbumsResponse(content: [], pageable: GetAllAlbumsResponsePageable(pageNumber: 0, pageSize: 0, sort: [], offset: 0, unpaged: false, paged: false), size: 0, number: 0, sort: [], first: true, last: false, numberOfElements: 0, empty: true))
                }
            }
    }
}
