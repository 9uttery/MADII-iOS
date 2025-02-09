//
//  NetworkConfig.swift
//  Madii
//
//  Created by Anjin on 2/7/25.
//

import Foundation

public struct NetworkConfig {
    public static var baseURL: String {
        let bundle = Bundle(identifier: "com.9uttery.Madii.MadiiNetworking")
        let baseURL = bundle?.infoDictionary?["BASE_URL"] as? String ?? "nil baseURL"
        return baseURL
    }
}
