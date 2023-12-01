//
//  RecentAchievedJoyView.swift
//  Madii
//
//  Created by 이안진 on 12/1/23.
//

import SwiftUI

struct RecentAchievedJoy: Identifiable {
    let id = UUID()
    let date: String
    let joys: [Joy]
    
    static let dummy1: RecentAchievedJoy = RecentAchievedJoy(date: "2023.12.25", joys: [Joy(title: "넷플릭스 보면서 귤 까먹기"), Joy(title: "넷플릭스 보면서 귤 까먹기"), Joy(title: "넷플릭스 보면서 귤 까먹기")])
    
    static let dummy2: RecentAchievedJoy = RecentAchievedJoy(date: "2023.12.24", joys: [Joy(title: "넷플릭스 보면서 귤 까먹기"), Joy(title: "넷플릭스 보면서 귤 까먹기")])
    
    static let dummy3: RecentAchievedJoy = RecentAchievedJoy(date: "2023.12.23", joys: [Joy(title: "넷플릭스 보면서 귤 까먹기")])
}

struct Joy: Identifiable {
    let id = UUID()
    let title: String
}

struct RecentAchievedJoyView: View {
    let allJoys: [RecentAchievedJoy] = [RecentAchievedJoy.dummy1, RecentAchievedJoy.dummy2, RecentAchievedJoy.dummy3]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                // (박스) 모든 날짜
                ForEach(allJoys) { eachDayJoy in
                    VStack(spacing: 16) {
                        // 각 날짜의 모든 소확행
                        ForEach(eachDayJoy.joys) { joy in
                            HStack(spacing: 15) {
                                // 소확행 커버 이미지
                                Circle()
                                    .fill(Color.madiiOrange)
                                    .frame(width: 40, height: 40)
                                
                                Text(joy.title)
                                    .madiiFont(font: .madiiBody3, color: .white)
                                
                                Spacer()
                            }
                        }
                    }
                    .roundBackground(eachDayJoy.date, bottomPadding: 32)
                }
                
                Button {
                    
                } label: {
                    Text("이전 내역 더보기")
                        .madiiFont(font: .madiiBody3, color: .white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 8)
                        .background(Color.madiiOption)
                        .cornerRadius(90)
                }
                .padding(.top, 12)
            }
            .padding(.top, 28)
            .padding(.horizontal, 16)
            .padding(.bottom, 40)
        }
        .scrollIndicators(.hidden)
        .navigationTitle("최근 실천한 소확행")
        .toolbarBackground(Color.madiiBox, for: .navigationBar)
//              .toolbarBackground(.visible, for: .navigationBar)
    }
}

#Preview {
    RecentAchievedJoyView()
}
