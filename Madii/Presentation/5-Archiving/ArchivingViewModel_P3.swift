//
//  ArchivingViewModel_P3.swift
//  Madii
//
//  Created by Anjin on 9/27/25.
//

import Foundation

@Observable
class ArchivingViewModel_P3 {
    private let router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    enum Action {
        case showMyPage
    }
    
    func action(_ action: Action) {
        switch action {
        case .showMyPage:
            router.push(.myPage)
        }
    }
}
