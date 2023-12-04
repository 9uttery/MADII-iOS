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
    
    static let dummys: [RecentAchievedJoy] = [RecentAchievedJoy(date: "2023.12.25", joys: [Joy(title: "넷플릭스 보면서 귤 까먹기"), Joy(title: "넷플릭스 보면서 귤 까먹기"), Joy(title: "넷플릭스 보면서 귤 까먹기")]), RecentAchievedJoy(date: "2023.12.24", joys: [Joy(title: "넷플릭스 보면서 귤 까먹기"), Joy(title: "넷플릭스 보면서 귤 까먹기")]), RecentAchievedJoy(date: "2023.12.23", joys: [Joy(title: "넷플릭스 보면서 귤 까먹기")])]
}

struct Joy: Identifiable {
    let id = UUID()
    let title: String
    var counts: Int = 0
    
    static let manyAchievedDummy: [Joy] = [Joy(title: "샤브샤브 먹기", counts: 21),
                                           Joy(title: "방어 먹기", counts: 17),
                                           Joy(title: "열라면 먹기", counts: 12),
                                           Joy(title: "연어 먹기", counts: 5),
                                           Joy(title: "돈까스 먹기", counts: 3)]
}

struct RecentAchievedJoyView: View {
    @State private var allJoys: [RecentAchievedJoy] = RecentAchievedJoy.dummys
    
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                // (박스) 모든 날짜
                ForEach(allJoys) { eachDayJoy in
                    VStack(spacing: 16) {
                        // 각 날짜의 모든 소확행
                        ForEach(eachDayJoy.joys) { joy in
                            JoyRow(title: joy.title)
                        }
                    }
                    .roundBackground(eachDayJoy.date, bottomPadding: 32)
                }
                
                // 이전 내역 더보기 버튼
                Button {
                    withAnimation {
                        allJoys.append(contentsOf: RecentAchievedJoy.dummys)
                    }
                } label: {
                    Text("이전 내역 더보기")
                        .madiiFont(font: .madiiBody5, color: .white)
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
              .toolbarBackground(.visible, for: .navigationBar)
    }
}

#Preview {
    RecentAchievedJoyView()
}
