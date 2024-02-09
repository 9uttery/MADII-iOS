//
//  RecordDto.swift
//  Madii
//
//  Created by 정태우 on 2/5/24.
//

import Foundation

struct GetJoyResponse: Codable {
    var createdAt: String
    var size: Int
    var joyList: [GetJoyResponseJoy]
}

struct GetJoyResponseJoy: Codable {
    var joyId: Int
    var joyIconNum: Int
    var contents: String
}
