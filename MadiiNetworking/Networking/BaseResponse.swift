//
//  BaseResponse.swift
//  Madii
//
//  Created by Anjin on 2/7/25.
//

import Foundation

class BaseResponse<T: Codable>: Codable {
    let status: Int
    let code: String
    let message: String
    let data: T?
    let timestamp: String
}
