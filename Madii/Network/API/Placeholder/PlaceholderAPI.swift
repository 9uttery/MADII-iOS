//
//  PlaceholderAPI.swift
//  Madii
//
//  Created by Anjin on 9/12/24.
//

import Foundation

struct PlaceholderAPI {
    static var path = APIPaths.placeholders.rawValue
    
    static func getMyJoyPlaceholder() -> APIEndpoint<GetPlaceholderResponse> {
        return APIEndpoint(method: .get, path: path)
    }
}
