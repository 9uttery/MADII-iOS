//
//  DailyJoyView.swift
//  Madii
//
//  Created by 이안진 on 12/7/23.
//

import SwiftUI

struct DailyJoyView: View {
    let date: Date
    
    @State private var joys: [Joy] = Joy.dailyJoyDummy
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
                .sheet(item: $selectedJoy) { _ in
                    // Content of the sheet for the selected item
                    Text("넷플릭스 보면서 귤 까먹기 냠냠냠 맛있다 소확행이 길면 이렇게 처리 (최대 35자)")
                        .presentationDetents([.height(360)])
                        .presentationDragIndicator(.hidden)
                }
            }
            .padding(.top, 20)
            .padding(.horizontal, 16)
        }
        .scrollIndicators(.never)
        .navigationTitle("\(date.year != Date().year ? "\(date.year)년 " : "")\(date.twoDigitMonth)월 \(date.twoDigitDay)일 소확행")
    }
    
    @ViewBuilder
    private func joyRow(_ joy: Joy) -> some View {
        HStack(spacing: 15) {
            Circle()
                .frame(width: 48, height: 48)
                .foregroundStyle(Color.black)
                .overlay(
                    Circle()
                        .inset(by: 1.0)
                        .stroke(.white.opacity(0.4), lineWidth: 0.2)
                )
            
            Text(joy.title)
                .madiiFont(font: .madiiBody3, color: .white)
            
            Spacer()
            
            Circle()
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
