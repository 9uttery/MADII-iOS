//
//  HomeViewModel_P3.swift
//  Madii
//
//  Created by Anjin on 9/27/25.
//

import Foundation
import SwiftUI

@Observable
class HomeViewModel_P3 {
    private let router: Router
    
    // 상태 관리
    var isTodayJoy: Bool = false
    var todayJoy: Joy = Joy(title: "")
    var isMonthly: Bool = false
    var playListJoys: [Joy] = []
    var finishedJoys: [Joy] = []
    var isPlayJoy: Bool = false
    var isDuplicated: Bool = false

    init(router: Router) {
        self.router = router
    }
    
    enum Action {
        case loadTodayJoy
        case playJoy
        case showAlbumList
    }
    
    func action(_ action: Action) {
        switch action {
        case .loadTodayJoy:
            getTodayJoy()
        case .playJoy:
            playJoy()
        case .showAlbumList:
            showAlbumListView()
        }
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
                UserDefaults.standard.set(todayJoy.joyId, forKey: "todayJoyId")
                HapticManager.instance.notification(type: .success)
            } else {
                print("DEBUG getTodayJoy fail")
            }
        }
    }
    
    private func playJoy() {
        AchievementsAPI.shared.playJoy(joyId: todayJoy.joyId ?? 0) { isSuccess, isDuplicate in
            if isSuccess {
                print("DEBUG playJoy success")
                if isDuplicate {
                    print("DEBUG playJoy duplicate")
                    self.isDuplicated = true
                } else {
                    self.getJoy()
                    self.isPlayJoy = true
                }
            } else {
                print("debug playJoy: isSuccess false")
            }
        }
    }
    private func getJoy() {
        DailySummaryAPI.shared.getDailySummary(date: Date()) { isSuccess, dailySummary in
            if isSuccess {
                self.playListJoys = dailySummary.savingJoys.map { dto in
                    Joy(
                        joyId: dto.joyId,
                        title: "",
                        selectedEmotions: dto.emotions.map { Emotion(title: $0) }
                    )
                }
                print("ohadol")
            } else {
                DailySummaryAPI.shared.getAchievementByDate(date: Date(), isFinished: false) { isSuccess, playList in
                    if isSuccess {
                        self.playListJoys = playList.joyAchievementInfos.map { dto in
                            Joy(
                                joyId: dto.joyId,
                                achievementId: dto.achievementId,
                                isAchieved: dto.isAchieved,
                                icon: dto.joyIconNum,
                                title: dto.contents
                            )
                        }
                        print("안녕하세요\(self.playListJoys)안녕하십니까")
                    } else {
                        self.playListJoys = []
                        print("Debug getAchievementByDate: isSuccess false")
                    }
                }
            }
        }
    }
}
