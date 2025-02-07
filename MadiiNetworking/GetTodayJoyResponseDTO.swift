//
//  GetTodayJoyResponseDTO.swift
//  Madii
//
//  Created by Anjin on 2/7/25.
//

import Foundation

public struct GetTodayJoyResponseDTO: Codable, Identifiable {
    public var id: Int { joyId }
    let joyId: Int
    let joyIconNum: Int
    let contents: String
}
