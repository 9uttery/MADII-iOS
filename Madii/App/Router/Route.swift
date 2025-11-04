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
    case dailyReview(todayJoys: [Joy], visibleJoys: [Bool], date: Date)
    case albumList
    case albumDetail(albumId: Int, popNum: Int)
    case review(savingJoys: [Joy], date: Date)
    case completeOhadol
    
    // Exploration
    case recommend
    case completeRecommend(joy: GetJoyResponseJoy)
    case allAlbumList
    
    // Archiving
    case myPage
}
