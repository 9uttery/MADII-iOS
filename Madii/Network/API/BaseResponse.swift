//
//  BaseResponse.swift
//  Madii
//
//  Created by 정태우 on 2/5/24.
//

import Foundation

class BaseResponse<T: Codable>: Codable {
    let status: Int
    let code: String
    let message: String
    let data: T?
    let timestamp: String
}
