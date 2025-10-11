//
//  ReviewView.swift
//  Madii
//
//  Created by 정태우 on 8/10/25.
//

import SwiftUI

struct ReviewView_P3: View {
    @Environment(Router.self) var router
    @State var tabNum: Int = 0
    @State var diaryContent: String = ""
    @State var date: Date = Date()
    @State var satisfaction: Int = 0
    @State var savingJoys: [Joy] = [Joy(title: "안녕kaklsdjfalkdjflaksdjfalksdfjalskdjfalskdfjalksdfjalksdfjalksdfdf"), Joy(title: "안녕하세요"), Joy(title: "안녕안녕하세용")]
    
    var body: some View {
        VStack(alignment: .leading) {
            MadiiNavigationBar_P3(title: date.toKoreanString())
            
            HStack(spacing: 8) {
                Rectangle()
                    .frame(maxWidth: .infinity)
                    .frame(height: 4)
                    .foregroundStyle(.madiiViolet)
                    .cornerRadius(8)
                
                Rectangle()
                    .frame(maxWidth: .infinity)
                    .frame(height: 4)
                    .foregroundStyle(tabNum > 0 ? .madiiViolet : .madiiAssistive)
                    .cornerRadius(8)
                
                Rectangle()
                    .frame(maxWidth: .infinity)
                    .frame(height: 4)
                    .foregroundStyle(tabNum > 1 ? .madiiViolet : .madiiAssistive)
                    .cornerRadius(8)
            }
            .padding(.vertical, 12)
            
            if tabNum == 0 {
                FeelingReviewView(tabNum: $tabNum, todayJoys: $savingJoys)
            } else if tabNum == 1 {
                SatisfactionReviewView(tabNum: $tabNum, satisfaction: $satisfaction)
            } else {
                DiaryReviewView(tabNum: $tabNum, date: $date, satisfaction: $satisfaction, savingJoys: $savingJoys)
            }
        }
        .navigationTitle("\(Date().toKoreanString())")
        .padding(.horizontal, 20)
        .onAppear {
            getAchievementByDate()
        }
    }
    
    func getAchievementByDate() {
        DailySummaryAPI.shared.getAchievementByDate(date: date, isFinished: true) { isSuccess, dailySummary in
            if isSuccess {
                print("debug getAchievementByDate: isSuccess true")
                savingJoys = dailySummary.joyAchievementInfos.map { dto in
                    Joy(
                        joyId: dto.joyId,
                        achievementId: dto.achievementId,
                        isAchieved: dto.isachieved,
                        icon: dto.joyIconNum,
                        title: dto.contents,
                        counts: 0,
                        satisfaction: .bad,
                        isSaved: false,
                        isMine: false,
                        rank: 0,
                        joyOrder: 0,
                        selectedEmotions: []
                    )
                }
            } else {
                print("debug getAchievementByDate: isSuccess false")
            }
        }
    }
}

#Preview {
    ReviewView_P3()
}
