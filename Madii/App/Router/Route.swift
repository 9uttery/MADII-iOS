//
//  Route.swift
//  Madii
//
//  Created by Anjin on 8/10/25.
//

import Foundation

enum Route: Hashable, Identifiable {
    var id: Self { self }
    
    case splash
    case onboarding
    case login
    case tab
    
    // Tab
    case home
    case exploration
    case archiving
    
    // Home
    case dailyReview
    
    // Exploration
    
    // Archiving
    case myPage
}
