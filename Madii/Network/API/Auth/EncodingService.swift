//
//  EncodingService.swift
//  Madii
//
//  Created by Anjin on 1/7/25.
//

import CryptoKit
import Foundation

struct EncodingService {
    func encodingPassword(_ password: String) -> String? {
        let salt = Bundle.main.infoDictionary?["PASSWORD_SALT"] ?? ""
        let saltString = salt as! String
        guard let hashedPassword = hashString(password) else { return "" }
        let hashedWithSalt = hashString(hashedPassword + saltString)
        return hashedWithSalt
    }
    
    func hashString(_ string: String) -> String? {
        guard let data = string.data(using: .utf8) else {
            return nil
        }
        
        let hashed = SHA256.hash(data: data)
        let hashedString = hashed.compactMap { String(format: "%02x", $0) }.joined()
        
        return hashedString
    }
}
