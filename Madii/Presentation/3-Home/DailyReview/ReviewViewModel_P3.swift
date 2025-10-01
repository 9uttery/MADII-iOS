//
//  ReviewViewModel_P3.swift
//  Madii
//
//  Created by 정태우 on 9/30/25.
//

import Foundation
import SwiftUI

@Observable
class ReviewViewModel_P3 {
    private let router: Router
    
    // 상태
    var date: Date = Date()
    var savingJoys: [Joy] = []
    var tabNum: Int = 0
    var diaryContent: String = ""
    var selectedImage: [UIImage] = []
    var satisfaction: Int = 0
    
    init(router: Router, joys: [Joy]) {
        self.router = router
        self.savingJoys = joys
    }
    
    enum Action {
        case popView
    }
    
    func action(_ action: Action) {
        switch action {
        case .popView:
            popView()
        }
    }

    
    private func popView() {
        router.pop()
    }
}
