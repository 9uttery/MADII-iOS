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
    @State var editJoyTitle: String = ""
    @Binding var isSuccessEditJoy: Bool
    @Binding var isOhadol: Bool
    @Binding var finishedJoys: [Joy]
    @Binding var canOhadol: Bool
    @State var satisfaction: Int = 0
    @State var diary: String = ""
    @State var images: [String] = []
    @Binding var isDeleted: Bool
    @Binding var showTooLongToast: Bool
    @FocusState private var isJoyFieldFocused: Bool
    @Binding var keyboardHeight: CGFloat
    @State var showJoyTitleBottomSheet: Bool = false
    @State var clickedJoyTitle: String = ""

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
    
    var placeholder: String {
        if selectedDate.isSameDay(as: Date()) && !isOhadol {
            return "오늘의 행복을 기록해보세요"
        } else if selectedDate < Date() {
            return "잊고 지나갔던 행복을 기록해보세요"
        } else {
            return "마음 속 행복을 기록해보세요"
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
                    .madiiFont(.subTitle)
                    .foregroundStyle(.madiiNormal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 16)
                
                if !isOhadol {
                    MadiiDesignSystem.MadiiTextField(
                        type: $type,
                        text: $joyTitle,
                        isPlus: true,
                        placeholder: placeholder
                    ) {
                        if !joyTitle.isEmpty {
                            postJoy()
                        }
                        joyTitle = ""
                    }
                    .focused($isJoyFieldFocused)
                    .id("joyTextField")
                    .padding(.horizontal, 16)
                }
                
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
                                editJoyTitle = joy.title
                                showRenameJoyBottomSheet = true
                            },
                            onPlayToggle: {
                                if joy.isAchieved {
                                    cancelJoy(achievementId: joy.achievementId)
                                } else {
                                    playJoy(achievementId: joy.achievementId)
                                    AnalyticsManager.shared.logEvent(name: "소확행 실천")
                                }
                            }, clickedButton: $showJoyTitleBottomSheet,
                            clickedJoyTitle: $clickedJoyTitle
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
            .madiiBorderContainerStyle(paddingHorizontal: 0)
            .padding(.bottom, 16)
            
            if isOhadol {
                VStack(alignment: .leading, spacing: 24) {
                    Text("하루 만족도")
                        .madiiFont(.subTitle)
                        .foregroundStyle(.madiiNormal)
                    
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
                .madiiBorderContainerStyle(cornerRadius: 32)
                .padding(.bottom, 16)
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("하루 기록")
                        .madiiFont(.subTitle)
                        .foregroundStyle(.madiiNormal)
                        .padding(.bottom, 4)
                    
                    Text(diary)
                        .madiiFont(.body2)
                        .foregroundStyle(.gray100.opacity(0.74))
                        .frame(maxWidth: .infinity, alignment: .leading)
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
                    .padding(.bottom, 8)
                }
                .madiiBorderContainerStyle(cornerRadius: 32)
                .padding(.bottom, 16)
            }
            
            if !isOhadol && !canOhadol {
                Text(selectedDate < Date() && !selectedDate.isSameDay(as: Date()) ? "하루 돌아보기" : "오늘 하루 돌아보기")
                    .madiiFont(.subTitle)
                    .foregroundStyle(.madiiNormal)
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
        .opacity(showRenameJoyBottomSheet ? 0.8 : 1)
        .sheet(isPresented: $showRenameJoyBottomSheet) {
            RenameJoyBottomSheet(showRenameJoyBottomSheet: $showRenameJoyBottomSheet, newJoyTitle: $editJoyTitle, isSuccessEditJoy: $isSuccessEditJoy, joyId: $editJoyId)
                .presentationDetents([.height(304)])
                .presentationDragIndicator(.hidden)
                .presentationBackground(.clear)
        }
        .onAppear {
            getJoy()
        }
        .onChange(of: selectedDate) {
            getJoy()
        }
        .onChange(of: isSuccessEditJoy) {
            getJoy()
        }
        .dismissKeyboardOnTap()
        .safeAreaInset(edge: .bottom) {
            Color.clear.frame(height: 300)
        }
        .onAppear {
            NotificationCenter.default.addObserver(
                forName: UIResponder.keyboardWillShowNotification,
                object: nil,
                queue: .main
            ) { notification in
                if let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                    keyboardHeight = frame.height - 100
                }
            }

            NotificationCenter.default.addObserver(
                forName: UIResponder.keyboardWillHideNotification,
                object: nil,
                queue: .main
            ) { _ in
                keyboardHeight = 0
            }
        }
        .sheet(isPresented: $showJoyTitleBottomSheet) {
            JoyTitleBottomSheet(joyTitle: $clickedJoyTitle, showJoyTitleBottomSheet: $showJoyTitleBottomSheet)
                .presentationDetents([.height(290)])
                .presentationDragIndicator(.hidden)
                .presentationBackground(.clear)
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
                        AnalyticsManager.shared.logEvent(name: "오플리에 소확행 추가")
                        if !selectedDate.isSameDay(as: Date()) && selectedDate < Date() {
                            playJoy(achievementId: joys.first?.achievementId ?? 0)
                        }
                    } else {
                        print("Debug postAchievements: isSuccess false")
                    }
                }
            } else {
                print("Debug postJoy: isSuccess false")
                showTooLongToast = true
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
                        print(joys)
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
        print("\(achievementId) \(selectedDate)")
        AchievementsAPI.shared.postJoySatisfaction(date: selectedDate, achievementId: achievementId, satisfacton: nil) { isSuccess in
            if isSuccess {
                print("Debug postJoySatisfaction: isSuccess true")
                getJoy()
                withAnimation {
                    canOhadol = true
                }
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
