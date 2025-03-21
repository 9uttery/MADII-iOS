//
//  JoySatisfactionBottomSheet.swift
//  Madii
//
//  Created by 이안진 on 1/17/24.
//

import SwiftUI

struct JoySatisfactionBottomSheet: View {
    @Environment(\.presentationMode) var presentationMode
    
    let joy: Joy
    var fromPlaylistBar: Bool = false
    private let satisfactions = JoySatisfaction.allCases
    private let satisfactionImages: [Int: String] = [1: "bad", 2: "soso", 3: "good", 4: "great", 5: "excellent"]
    @State private var selectedSatisfaction: JoySatisfaction? = .bad
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 8) {
                Text(joy.title)
                    .madiiFont(font: .madiiSubTitle, color: .white)
                Text("얼마나 행복하셨나요?")
                    .madiiFont(font: .madiiBody3, color: .white)
            }
            
            Spacer()
            
            VStack(spacing: 16) {
                ZStack {
                    Rectangle()
                        .foregroundStyle(Color.madiiPopUp)
                        .frame(height: 3)
                    
                    HStack(spacing: 0) {
                        ForEach(satisfactions, id: \.self) { satisfaction in
                            Button {
                                selectedSatisfaction = satisfaction
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    presentationMode.wrappedValue.dismiss()
                                    if fromPlaylistBar {
                                        postSatisfaction()
                                    } else {
                                        putSatisfaction()
                                    }
                                    AnalyticsManager.shared.logEvent(name: "소확행만족도조사바텀시트_\(satisfaction)클릭")
                                }
                            } label: {
                                satisfactionIcon(of: satisfaction)
                            }
                            
                            if satisfaction != satisfactions.last {
                                Spacer()
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                .frame(height: 120)
                .background(Color.madiiOption)
                .cornerRadius(12)
                
                if fromPlaylistBar {
                    HStack {
                        Spacer()
                        Text("만족도를 기록하지 않으면 실천이 완료되지 않아요")
                            .madiiFont(font: .madiiBody4, color: .gray500)
                        Spacer()
                    }
                }
            }
            .padding(.bottom, 32)
        }
        .padding(.top, 36)
        .padding(.horizontal, 16)
        .background(Color.madiiPopUp)
        .onAppear {
            selectedSatisfaction = joy.satisfaction
            if fromPlaylistBar { selectedSatisfaction = nil }
        }
        .analyticsScreen(name: "소확행만족도조사바텀시트")
    }
    
    private func putSatisfaction() {
        AchievementsAPI.shared.putJoySatisfaction(achievementId: joy.achievementId, satisfacton: selectedSatisfaction?.serverEnum ?? "GREAT") { isSuccess in
            if isSuccess {
                print("야호 성공이다")
            } else {
                print("이런 실패다")
            }
        }
    }
    
    private func postSatisfaction() {
        AchievementsAPI.shared.postJoySatisfaction(achievementId: joy.achievementId, satisfacton: selectedSatisfaction?.serverEnum ?? "GREAT") { isSuccess in
            if isSuccess {
                print("야호 실천 완료 성공이다")
            } else {
                print("이런 실천 완료 실패다")
            }
        }
    }
    
    @ViewBuilder
    private func satisfactionIcon(of satisfaction: JoySatisfaction) -> some View {
        if let selected = selectedSatisfaction {
            let isSelected: Bool = satisfaction == selected
            
            ZStack {
                Circle()
                    .frame(width: 36, height: 36)
                    .foregroundStyle(Color.madiiOption)
                    .overlay {
                        Circle()
                            .stroke(isSelected ? Color.madiiYellowGreen : Color.madiiPopUp, lineWidth: 2)
                    }
                
                if isSelected {
                    Image(satisfaction.imageName)
                        .resizable()
                        .frame(width: 24, height: 24)
                } else {
                    Circle()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(Color.madiiPopUp)
                }
            }
        } else {
            ZStack {
                Circle()
                    .frame(width: 36, height: 36)
                    .foregroundStyle(Color.madiiOption)
                    .overlay {
                        Circle()
                            .stroke(Color.madiiPopUp, lineWidth: 2)
                    }
                
                Image(satisfaction.imageName)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .opacity(0.2)
            }
        }
    }
}
