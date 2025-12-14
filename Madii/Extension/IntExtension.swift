//
//  IntExtension.swift
//  Madii
//
//  Created by 정태우 on 10/13/25.
//

import Foundation
import SwiftUI


extension Int {
    var intToColor: Color {
        switch self % 7 {
        case 0:
            return .madiiRedOrange
        case 1:
            return .madiiLime
        case 2:
            return .madiiCyan
        case 3:
            return .madiiLiteBlue
        case 4:
            return .madiiViolet
        case 5:
            return .madiiPurple
        case 6:
            return .madiiPink
        default:
            return .madiiCyan
        }
    }
    
    var intToSatisfaction: Int {
        switch self {
        case 1, 2:
            return 1
        case 3, 4:
            return 2
        case 5:
            return 3
        case 6, 7:
            return 4
        case 8, 9:
            return 5
        default:
            return 3
        }
    }
}
