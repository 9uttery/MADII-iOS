//
//  DailyJoyView.swift
//  Madii
//
//  Created by 이안진 on 12/7/23.
//

import SwiftUI

struct DailyJoyView: View {
    let date: Date
    @State private var joys: [Joy] = []
    @State private var selectedJoy: Joy?
    
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                ForEach(joys) { joy in
                    Button {
                        selectedJoy = joy
                    } label: {
                        joyRow(joy)
                    }
                }
                .sheet(item: $selectedJoy, onDismiss: getJoys) { item in
                    JoySatisfactionBottomSheet(joy: item)
                        .presentationDetents([.height(300)])
                        .presentationDragIndicator(.hidden)
                }
            }
            .padding(.top, 20)
            .padding(.horizontal, 16)
        }
        .scrollIndicators(.never)
        .onAppear { getJoys() }
        .navigationTitle("\(date.year != Date().year ? "\(date.year)년 " : "")\(date.twoDigitMonth)월 \(date.twoDigitDay)일 소확행")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func getJoys() {
        AchievementsAPI.shared.getAchievedJoyForDay(date: date) { isSuccess, response in
            if isSuccess {
                joys = []
                for joy in response.dailyJoyAchievementInfos {
                    let newJoy: Joy = Joy(joyId: joy.joyId, achievementId: joy.achievementId,
                                          icon: joy.joyIconNum, title: joy.contents,
                                          satisfaction: JoySatisfaction.fromServer(joy.satisfaction))
                    joys.append(newJoy)
                }
            } else {
                print("DEBUG DailyJoyView 실패")
            }
        }
    }
    
    @ViewBuilder
    private func joyRow(_ joy: Joy) -> some View {
        HStack(spacing: 15) {
            ZStack {
                Circle()
                    .frame(width: 48, height: 48)
                    .foregroundStyle(Color.black)
                    .overlay(
                        Circle()
                            .inset(by: 1.0)
                            .stroke(.white.opacity(0.4), lineWidth: 0.2)
                    )
                
                Image("icon_\(joy.icon)")
                    .resizable()
                    .frame(width: 26, height: 26)
            }
            
            Text(joy.title)
                .madiiFont(font: .madiiBody3, color: .white)
                .multilineTextAlignment(.leading)
            
            Spacer()
            
            Image(joy.satisfaction.imageName)
                .resizable()
                .frame(width: 28, height: 28)
                .foregroundStyle(Color.madiiYellowGreen)
        }
    }
}

#Preview {
//    NavigationStack {
//        MadiiTabView()
//    }
     
    DailyJoyView(date: Date())
}
