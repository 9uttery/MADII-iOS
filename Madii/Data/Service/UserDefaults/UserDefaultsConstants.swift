//
//  UserDefaultsConstants.swift
//  Madii
//
//  Created by Anjin on 8/10/25.
//

import Foundation

struct UserDefaultsConstants {
    enum Keys: String, CaseIterable {
        case hasEverOnboarded = "hasEverOnboarded"
        
        var defaultValue: Any {
            switch self {
            case .hasEverOnboarded:
                return true
            }
        }
    }
}
