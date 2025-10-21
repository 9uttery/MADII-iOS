//
//  HomeCalendar.swift
//  Madii
//
//  Created by 정태우 on 8/7/25.
//

import Kingfisher
import MadiiDesignSystem
import SwiftUI

struct HomeCalendar: View {
    @Binding var isMonthly: Bool
    @State var type: TextFieldType = .basic
    @State var joyTitle: String = ""
    @Binding var joys: [Joy]
    @Binding var selectedDate: Date
    @State var showRenameJoyBottomSheet: Bool = false
    @State var editJoyId: Int = 0
    @Binding var isOhadol: Bool
    @Binding var finishedJoys: [Joy]
    @Binding var canOhadol: Bool
    @State var satisfaction: Int = 0
    @State var diary: String = ""
    @State var images: [String] = []
    @Binding var isDeleted: Bool
    
    var prefixText: String {
        if selectedDate.isSameDay(as: Date()) {
            return "오늘, "
        } else if let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date()),
                  Calendar.current.isDate(selectedDate, inSameDayAs: tomorrow) {
            return "내일, "
        } else if let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date()),
                  Calendar.current.isDate(selectedDate, inSameDayAs: yesterday) {
            return "어제, "
        } else {
            return ""
        }
    }

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
                
                Text("\(prefixText)\(selectedDate.toKoreanString())")
                    .madiiFont(font: .madiiSubTitle, color: .madiiNormal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 16)
                
                if selectedDate.isSameDay(as: Date()) && !isOhadol {
                    MadiiDesignSystem.MadiiTextField(type: $type, text: $joyTitle, isPlus: true, placeholder: "오늘의 행복을 담아보세요") {
                        postJoy()
                        joyTitle = ""
                    }
                    .padding(.horizontal, 16)
                } else if !selectedDate.isSameDay(as: Date()) && selectedDate < Date() {
                    MadiiDesignSystem.MadiiTextField(type: $type, text: $joyTitle, isPlus: true, placeholder: "잊고 지나갔던 행복을 기록해보세요") {
                        postJoy()
                        joyTitle = ""
                    }
                    .padding(.horizontal, 16)
                } else if !selectedDate.isSameDay(as: Date()) && selectedDate > Date() {
                    MadiiDesignSystem.MadiiTextField(type: $type, text: $joyTitle, isPlus: true, placeholder: "마음 속 행복을 기록해보세요") {
                        postJoy()
                        joyTitle = ""
                    }
                    .padding(.horizontal, 16)
                }
                
                if isOhadol {
                    ForEach(joys) { joy in
                        HStack(spacing: 12) {
                            Circle()
                                .frame(width: 12, height: 12)
                                .foregroundStyle((joy.icon % 6 + 1).intToColor)
                            
                            Text(joy.title)
                                .madiiFont(font: .madiiBody2, color: .madiiNormal)
                                .lineSpacing(9.6)
                                .lineLimit(1)
                                .truncationMode(.tail)
                                .layoutPriority(-1)
                            
                            Spacer()
                            
                            HStack(spacing: 4) {
                                ForEach(joy.selectedEmotions) { emotion in
                                    Text(emotion.title)
                                        .madiiFont(font: .caption, color: emotion.color)
                                        .padding(.vertical, 4.5)
                                        .padding(.horizontal, 8)
                                        .background(emotion.color.opacity(0.08))
                                        .cornerRadius(8)
                                        .lineLimit(1)
                                        .layoutPriority(1)

                                }
                            }
                            .padding(.trailing, 22)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(height: 40)
                        .padding(.top, 16)
                        .padding(.leading, 26)
                        .background(.madiiElevated)
                    }
                } else {
                    List {
                        ForEach(joys) { joy in
                            JoyRowView(
                                joy: joy,
                                selectedDate: selectedDate,
                                onDelete: {
                                    deleteJoy(achievementId: joy.achievementId)
                                    isDeleted = true
                                },
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
                    .padding(.top, joys.isEmpty ? 0 : 16)
                }
            }
            .madiiBorderContainerStyle(paddingHorizontal: 0)
            .padding(.bottom, 16)
            
            if isOhadol {
                VStack(alignment: .leading, spacing: 24) {
                    Text("하루 만족도")
                        .madiiFont(font: .madiiSubTitle, color: .madiiNormal)
                    
                    HStack {
                        Image("satisfaction1")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .opacity(satisfaction == 1 || satisfaction == 2 ? 1 : 0.2)
                        
                        Spacer()
                        
                        Image("satisfaction2")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .opacity(satisfaction == 3 || satisfaction == 4 ? 1 : 0.2)
                        
                        Spacer()
                        
                        Image("satisfaction3")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .opacity(satisfaction == 5 ? 1 : 0.2)
                        
                        Spacer()
                        
                        Image("satisfaction4")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .opacity(satisfaction == 6 || satisfaction == 7 ? 1 : 0.2)
                        
                        Spacer()
                        
                        Image("satisfaction5")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .opacity(satisfaction == 8 || satisfaction == 9 ? 1 : 0.2)
                    }
                    .frame(maxWidth: .infinity)
                }
                .madiiBorderContainerStyle()
                .padding(.bottom, 16)
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("하루 일기")
                        .madiiFont(font: .madiiSubTitle, color: .madiiNormal)
                        .padding(.bottom, 4)
                    
                    Text(diary)
                        .madiiFont(font: .madiiBody2, color: .gray100.opacity(0.74))
                        .lineSpacing(9.6)
                        .multilineTextAlignment(.leading)
                    
                    HStack(spacing: 8) {
                        ForEach(images, id: \.self) { image in
                            KFImage(URL(string: image))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: (UIScreen.main.bounds.width - 116) / 3, height: (UIScreen.main.bounds.width - 116) / 3)
                                .clipped()
                                .cornerRadius(16)
                        }
                    }
                    .padding(.horizontal, 12)
                }
                .madiiBorderContainerStyle()
                .padding(.bottom, 16)
            }
            
            if isOhadol || !canOhadol {
                Text("오늘 하루 돌아보기")
                    .madiiFont(font: .madiiSubTitle, color: .madiiNormal)
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity)
                    .background(.madiiContrast)
                    .cornerRadius(20)
                    .opacity(0.4)
                    .padding(.bottom, 16)
            }
            
            Spacer()
                .frame(height: 100)
        }
        .scrollIndicators(.hidden)
        .sheet(isPresented: $showRenameJoyBottomSheet) {
            GeometryReader { geo in
                RenameJoyBottomSheet(showRenameJoyBottomSheet: $showRenameJoyBottomSheet, joyId: editJoyId)
                    .presentationDetents([.height(304 + geo.safeAreaInsets.bottom)])
                    .presentationDragIndicator(.hidden)
                    .presentationBackground(.clear)
            }
        }
        .onAppear {
            getJoy()
        }
        .onChange(of: selectedDate) {
            getJoy()
        }
    }
    
    private func postJoy() {
        JoyAPI.shared.postJoy(contents: joyTitle) { isSuccess, joyContents in
            if isSuccess {
                print("Debug postJoy: isSuccess true")
                AchievementsAPI.shared.postAchievemenets(joyId: joyContents.joyId, date: selectedDate) { isSuccess, joyList in
                    if isSuccess {
                        joys = joyList.joyAchievementInfos.map { dto in
                            Joy(
                                joyId: dto.joyId,
                                achievementId: dto.achievementId,
                                isAchieved: dto.isAchieved,
                                icon: dto.joyIconNum,
                                title: dto.contents
                            )
                        }
                    } else {
                        print("Debug postAchievements: isSuccess false")
                    }
                }
            } else {
                print("Debug postJoy: isSuccess false")
            }
        }
    }
    
    private func getJoy() {
        DailySummaryAPI.shared.getDailySummary(date: selectedDate) { isSuccess, dailySummary in
            if isSuccess {
                joys.removeAll()
                joys = dailySummary.savingJoys.map { dto in
                    Joy(
                        joyId: dto.joyId,
                        title: dto.contents,
                        selectedEmotions: dto.emotions.map { Emotion(title: $0) }
                    )
                }
                satisfaction = dailySummary.satisfaction
                diary = dailySummary.diaryContent
                images = dailySummary.attachedImages
                isOhadol = true
            } else {
                DailySummaryAPI.shared.getAchievementByDate(date: selectedDate, isFinished: true) { isSuccess, playList in
                    if isSuccess {
                        canOhadol = !playList.joyAchievementInfos.isEmpty
                        self.finishedJoys = playList.joyAchievementInfos.map { dto in
                            Joy(
                                joyId: dto.joyId,
                                achievementId: dto.achievementId,
                                isAchieved: dto.isAchieved,
                                icon: dto.joyIconNum,
                                title: dto.contents
                            )
                        }
                        print("안녕하세요\(finishedJoys)")
                    } else {
                        print("Debug getAchievementByDate: isSuccess false")
                    }
                }
                DailySummaryAPI.shared.getAchievementByDate(date: selectedDate) { isSuccess, playList in
                    if isSuccess {
                        joys.removeAll()
                        joys = playList.joyAchievementInfos.map { dto in
                            Joy(
                                joyId: dto.joyId,
                                achievementId: dto.achievementId,
                                isAchieved: dto.isAchieved,
                                icon: dto.joyIconNum,
                                title: dto.contents
                            )
                        }
                        print("안녕히가세요\(joys)")
                    } else {
                        joys = []
                        print("Debug getAchievementByDate: isSuccess false")
                    }
                }
                
                isOhadol = false
            }
        }
    }
    
    private func playJoy(achievementId: Int) {
        AchievementsAPI.shared.postJoySatisfaction(achievementId: achievementId, satisfacton: nil) { isSuccess in
            if isSuccess {
                print("Debug postJoySatisfaction: isSuccess true")
                getJoy()
                canOhadol = true
            } else {
                print("Debug postJoySatisfaction: isSuccess false")
            }
        }
    }
    
    private func cancelJoy(achievementId: Int) {
        print(achievementId)
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
        AchievementsAPI.shared.deleteJoy(achievementId: achievementId) { isSuccess, _ in
            if isSuccess {
                print("Debug cancelAchievement: isSuccess true")
                getJoy()
            } else {
                print("Debug cancelAchievement: isSuccess false")
            }
        }
    }
}
