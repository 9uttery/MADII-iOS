//
//  MadiiTab_P3.swift
//  Madii
//
//  Created by Anjin on 9/27/25.
//

import Foundation

enum MadiiTab_P3: CaseIterable {
    case home
    case exploration
    case archiving
    
    var title: String {
        switch self {
        case .home:
            return "홈"
        case .exploration:
            return "탐색"
        case .archiving:
            return "아카이브"
        }
    }
}
