//
//  HomeViewModel_P3.swift
//  Madii
//
//  Created by Anjin on 9/27/25.
//

import Foundation

@Observable
class HomeViewModel_P3 {
    private let router: Router
    
    // 상태 관리
    var isTodayJoy: Bool = false
    var todayJoy: Joy = Joy(title: "")
    var isMonthly: Bool = false
    var playListJoys: [Joy] = []
    
    init(router: Router) {
        self.router = router
    }
    
    enum Action {
        case showDailyReview
        case loadTodayJoy
        case playJoy
        case showAlbumList
    }
    
    func action(_ action: Action) {
        switch action {
        case .showDailyReview:
            showDailyReviewView()
        case .loadTodayJoy:
            getTodayJoy()
        case .playJoy:
            playJoy()
        case .showAlbumList:
            showAlbumListView()
        }
    }
    
    private func showDailyReviewView() {
        router.push(.dailyReview(todayJoys: playListJoys, visibleJoys: Array(repeating: false, count: playListJoys.count)))
    }
    
    private func showAlbumListView() {
        router.push(.albumList)
    }
    
    private func getTodayJoy() {
        HomeAPI.shared.getJoyToday { isSuccess, todayJoy in
            if isSuccess {
                print("DEBUG getTodayJoy success \(todayJoy)")
                self.todayJoy = Joy(joyId: todayJoy.joyId,
                                    icon: todayJoy.joyIconNum,
                                    title: todayJoy.contents)
                self.isTodayJoy = true
            } else {
                print("DEBUG getTodayJoy fail")
            }
        }
    }
    
    private func playJoy() {
        AchievementsAPI.shared.playJoy(joyId: todayJoy.joyId ?? 0) { isSuccess, isDuplicate in
            if isSuccess {
                print("DEBUG playJoy success")
            } else if isDuplicate {
                print("DEBUG playJoy duplicate")
            } else {
                print("DEBUG playJoy fail")
            }
        }
    }
}
