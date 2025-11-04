//
//  AlbumsAPI.swift
//  Madii
//
//  Created by Anjin on 10/6/24.
//

import Foundation

struct AlbumsAPI {
    static var path = APIPaths.albums.rawValue
    
    /// 새로운 앨범 생성
    static func postNewAlbum(name: String, description: String) -> APIEndpoint<[PostNewAlbumResponse]> {
        let body: [String: Any] = [
            "name": name,
            "description": description
        ]
        
        return APIEndpoint(method: .post, path: path, body: body)
    }
}
