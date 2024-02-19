//
//  JoySatisfactionBottomSheet.swift
//  Madii
//
//  Created by 이안진 on 1/17/24.
//

import SwiftUI

struct JoySatisfactionBottomSheet: View {
    let joy: Joy
    private let satisfactions = JoySatisfaction.allCases
    private let satisfactionImages: [Int: String] = [1: "bad", 2: "soso", 3: "good", 4: "great", 5: "excellent"]
    @State private var selectedSatisfaction: JoySatisfaction = .bad
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 8) {
                Text(joy.title)
                    .madiiFont(font: .madiiSubTitle, color: .white)
                Text("얼마나 행복하셨나요?")
                    .madiiFont(font: .madiiBody3, color: .white)
            }
            
            Spacer()
            
            ZStack {
                Rectangle()
                    .foregroundStyle(Color.madiiPopUp)
                    .frame(height: 3)
                
                HStack(spacing: 0) {
                    ForEach(satisfactions, id: \.self) { satisfaction in
                        Button {
                            selectedSatisfaction = satisfaction
                            putSatisfaction()
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
            .padding(.bottom, 32)
        }
        .padding(.top, 36)
        .padding(.horizontal, 16)
        .background(Color.madiiPopUp)
        .onAppear { selectedSatisfaction = joy.satisfaction }
    }
    
    private func putSatisfaction() {
        AchievementsAPI.shared.putJoySatisfaction(achievementId: joy.achievementId, satisfacton: selectedSatisfaction.serverEnum) { isSuccess in
            if isSuccess {
                print("야호 성공이다")
            } else {
                print("이런 실패다")
            }
        }
    }
    
    @ViewBuilder
    private func satisfactionIcon(of satisfaction: JoySatisfaction) -> some View {
        let isSelected: Bool = satisfaction == selectedSatisfaction
        
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
    }
}
