//
//  AlbumsDTO.swift
//  Madii
//
//  Created by Anjin on 10/6/24.
//

import Foundation

/// 새로운 앨범 생성 Response
struct PostNewAlbumResponse: Codable {
    let albumId: Int
    let name: String
}
