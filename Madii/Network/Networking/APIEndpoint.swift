//
//  APIEndpoint.swift
//  Madii
//
//  Created by Anjin on 9/12/24.
//

import Alamofire
import Foundation

struct APIEndpoint<Response: Codable> {
    typealias ResponseDTO = Response
    
    var method: HTTPMethod
    var urlVersion: Int = 1
    var path: String
    var headerType: APIHeaderType = .withAuth
    
    func request(completion: @escaping (Result<Response, NetworkError>) -> Void) {
        let url = "https://\(NetworkConstants.baseUrl)/v\(urlVersion)\(path)"
        let headers: HTTPHeaders = headerType.headers
        
        AF.request(url, method: method, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: BaseResponse<ResponseDTO>.self) { response in
                guard let status = response.response?.statusCode else {
                    printLog("APIEndpoints에서 statusCode가 nil")
                    return completion(.failure(NetworkError.invalid))
                }
                
                validateStatusCode(status) { validate in
                    switch validate {
                    case .success:
                        switch response.result {
                        case .success(let response):
                            guard let data = response.data else {
                                printLog("Decoding한 data가 nil")
                                return completion(.failure(NetworkError.invalid))
                            }
                            
                            // 에러코드 핸들링
                            // let code = response.code
                            
                            // 성공
                            NetworkLogger.succeessLog(method: method, path: "/v\(urlVersion)\(path)")
                            completion(.success(data))
                            
                        case .failure(let error):
                            printLog("response error: \(error)")
                            return completion(.failure(NetworkError.invalid))
                        }
                    case .failure(let error):
                        printLog("statusCode가 \(status)")
                        return completion(.failure(error))
                    }
                }
            }
    }
    
    private func validateStatusCode(_ status: Int, completion: @escaping (Result<Int, NetworkError>) -> Void) {
        if status == 200 {
            return completion(.success(200))
        } else {
            // statusCode 핸들링
            printLog("statusCode가 \(status)")
            return completion(.failure(NetworkError.invalid))
        }
    }
    
    private func printLog(_ issue: String) {
        NetworkLogger.debugLog(method: method, path: "/v\(urlVersion)\(path)", issue: issue)
    }
}
