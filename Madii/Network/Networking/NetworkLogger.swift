//
//  NetworkLogger.swift
//  Madii
//
//  Created by Anjin on 9/12/24.
//

import Alamofire
import Foundation

struct NetworkLogger {
    static func succeessLog(method: HTTPMethod, path: String, state: String = "성공") {
        print("\n🍀🌼 NETWORK Success START 🌼🍀")
        print("🌼🌼 method: \(method.rawValue)")
        print("🌼🌼 path: \(path)")
        print("🌼🌼 상태: \(state)")
        print("🍀🌼 NETWORK Success END 🌼🍀\n")
    }
    
    static func debugLog(method: HTTPMethod, path: String, issue: String) {
        print("\n🚨🚧 NETWORK DEBUG START 🚧🚨")
        print("🚧🚧 method: \(method.rawValue)")
        print("🚧🚧 path: \(path)")
        print("🚧🚧 문제상황: \(issue)")
        print("🚨🚧 NETWORK DEBUG END 🚧🚨\n")
    }
}
