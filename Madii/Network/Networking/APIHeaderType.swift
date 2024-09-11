//
//  APIHeaderType.swift
//  Madii
//
//  Created by Anjin on 9/12/24.
//

import Alamofire
import Foundation

enum APIHeaderType {
    case withoutAuth
    case withAuth
    
    var headers: HTTPHeaders {
        let keychain = KeychainSwift()
        
        switch self {
        case .withoutAuth:
            let result: HTTPHeaders = [
                "Content-Type": "application/json"
            ]
            
            return result
        case .withAuth:
            let result: HTTPHeaders = [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(keychain.get(NetworkConstants.accessToken) ?? "")"
            ]
            
            return result
        }
    }
}
