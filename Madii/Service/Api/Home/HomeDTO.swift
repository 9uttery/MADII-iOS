//
//  HomeDTO.swift
//  Madii
//
//  Created by 정태우 on 2/15/24.
//

import Foundation

struct GetAllAlbumsResponse: Codable {
    let content: [GetAlbumsResponse]
    let pageable: GetAllAlbumsResponsePageable
    let size: Int
    let number: Int
    let sort: [Int]
    let first: Bool
    let last: Bool
    let numberOfElements: Int
    let empty: Bool
}

struct GetAllAlbumsResponsePageable: Codable {
    let pageNumber: Int
    let pageSize: Int
    let sort: [Int]
    let offset: Int
    let unpaged: Bool
    let paged: Bool
}
