//
//  HomeCalendar.swift
//  Madii
//
//  Created by 정태우 on 8/7/25.
//

import MadiiDesignSystem
import SwiftUI

struct HomeCalendar: View {
    @Binding var isMonthly: Bool
    @State var type: TextFieldType = .basic
    @State var joyTitle: String = ""
    @State var joys: [Joy] = [Joy(title: "안녕kaklsdjfalkdjflaksdjfalksdfjalskdjfalskdfjalksdfjalksdfjalksdfdf", selectedEmotions: [Emotion(title: "기쁨")]), Joy(title: "안녕하세요"), Joy(title: "안녕안녕하세용")]
    @State var selectedDate: Date = Date()
    @State var showRenameJoyBottomSheet: Bool = false
    @State var editJoyId: Int = 0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                HomeCalendarView(isMonthly: $isMonthly, selectedDay: $selectedDate)
                
                Rectangle()
                    .frame(maxWidth: .infinity)
                    .frame(height: 1)
                    .foregroundStyle(.madiiGray35)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 32)
                
                Text("\(selectedDate.isSameDay(as: Date()) ? "오늘" : "") \(selectedDate.toKoreanString())")
                    .madiiFont(font: .madiiSubTitle, color: .madiiNormal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 16)
                
                if selectedDate.isSameDay(as: Date()) {
                    MadiiDesignSystem.MadiiTextField(type: $type, text: $joyTitle, isPlus: true, placeholder: "오늘의 행복을 담아보세요") {
                        postJoy()
                    }
                    .padding(.horizontal, 16)
                }
                List {
                    ForEach(joys) { joy in
                        JoyRowView(
                            joy: joy,
                            selectedDate: selectedDate,
                            onDelete: { deleteJoy(achievementId: joy.achievementId) },
                            onEdit: {
                                editJoyId = joy.joyId!
                                showRenameJoyBottomSheet = true
                            },
                            onPlayToggle: {
                                if joy.isAchieved {
                                    cancelJoy(achievementId: joy.achievementId)
                                } else {
                                    playJoy(achievementId: joy.achievementId)
                                }
                            }
                        )
                    }
                }
                .listStyle(.plain)
                .frame(maxWidth: .infinity)
                .frame(height: 56 * CGFloat(joys.count))
                .environment(\.defaultMinListRowHeight, 40)
                .background(Color.madiiElevated)
                .padding(.top, 16)
            }
            .padding(.vertical, 20)
            .background(.madiiElevated)
            .cornerRadius(40)
            .overlay(
                RoundedRectangle(cornerRadius: 40)
                    .stroke(
                        LinearGradient(
                            gradient: Gradient(stops: [
                                .init(color: Color.white.opacity(0.1), location: 0.0),
                                .init(color: Color(red: 0x3D/255, green: 0xC2/255, blue: 0xFF/255).opacity(0.1), location: 0.33),
                                .init(color: Color(red: 0xD4/255, green: 0x78/255, blue: 0xFF/255).opacity(0.1), location: 0.68),
                                .init(color: Color.white.opacity(0.1), location: 1.0)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1
                    )
            )
            
            Spacer()
                .frame(height: 100)
        }
        .sheet(isPresented: $showRenameJoyBottomSheet) {
            RenameJoyBottomSheet(joyId: editJoyId)
        }
    }
    
    private func postJoy() {
        JoyAPI.shared.postJoy(contents: joyTitle) { isSuccess, joyContents in
            if isSuccess {
                print("Debug postJoy: isSuccess true")
                print("postJoy: \(joyContents)")
                joyTitle = ""
            } else {
                print("Debug postJoy: isSuccess true")
            }
        }
    }
    
    private func getJoy() {
        DailySummaryAPI.shared.getDailySummary(date: selectedDate) { isSuccess, dailySummary in
            if isSuccess {
                joys = dailySummary.savingJoys.map { dto in
                    Joy(
                        joyId: dto.joyId,
                        title: "", 
                        selectedEmotions: dto.emotions.map { Emotion(title: $0) }
                    )
                }
            } else {
                DailySummaryAPI.shared.getAchievementByDate(date: selectedDate, isFinished: false) { isSuccess, playList in
                    if isSuccess {
                        joys = playList.joyAchievementInfos.map { dto in
                            Joy(
                                joyId: dto.joyId,
                                achievementId: dto.achievementId,
                                isAchieved: dto.isachieved,
                                icon: dto.joyIconNum,
                                title: dto.contents
                            )
                        }
                    } else {
                        print("Debug getAchievementByDate: isSuccess false")
                    }
                }
            }
        }
    }
    
    private func playJoy(achievementId: Int) {
        AchievementsAPI.shared.postJoySatisfaction(achievementId: achievementId, satisfacton: nil) { isSuccess in
            if isSuccess {
                print("Debug postJoySatisfaction: isSuccess true")
                getJoy()
            } else {
                print("Debug postJoySatisfaction: isSuccess false")
            }
        }
    }
    
    private func cancelJoy(achievementId: Int) {
        AchievementsAPI.shared.cancelAchievement(achievementId: achievementId) { isSuccess in
            if isSuccess {
                print("Debug cancelAchievement: isSuccess true")
                getJoy()
            } else {
                print("Debug cancelAchievement: isSuccess false")
            }
        }
    }
    
    private func deleteJoy(achievementId: Int) {
        AchievementsAPI.shared.deleteJoy(achievementId: achievementId) { isSuccess, joyList in
            if isSuccess {
                print("Debug cancelAchievement: isSuccess true")
                joys = joyList.map { dto in
                    Joy(
                        joyId: dto.joyId,
                        achievementId: dto.achievementId,
                        isAchieved: dto.isAchieved,
                        icon: dto.joyIconNum,
                        title: dto.contents
                    )
                }
            } else {
                print("Debug cancelAchievement: isSuccess false")
            }
        }
    }
}

extension Date {
    func toKoreanString(format: String = "M월 d일") -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
