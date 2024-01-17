//
//  DailyJoyView.swift
//  Madii
//
//  Created by 이안진 on 12/7/23.
//

import SwiftUI

struct DailyJoyView: View {
    let date: Date
    @State private var satisfaction: Float = 100
    
    @State private var dummy: [Joy] = Joy.dailyJoyDummy
    
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                ForEach(dummy) { joy in
                    joyRow(joy.title)
                }
                
                joyRow("나 진짜 긴 소확행 하나 할건데 아무도 말리지마!!!")
            }
            .padding(.top, 20)
            .padding(.horizontal, 24)
        }
        .scrollIndicators(.never)
        .navigationTitle("\(date.year != Date().year ? "\(date.year)년 " : "")\(date.twoDigitMonth)월 \(date.twoDigitDay)일 소확행")
    }
    
    @ViewBuilder
    private func joyRow(_ title: String) -> some View {
        HStack(spacing: 15) {
            Circle()
                .frame(width: 48, height: 48)
                .foregroundStyle(Color.black)
                .overlay(
                    Circle()
                        .inset(by: 1.0)
                        .stroke(.white.opacity(0.4), lineWidth: 0.2)
                )
            
            Text(title)
                .madiiFont(font: .madiiBody3, color: .white)
            
            Spacer()
            
            Circle()
                .frame(width: 28, height: 28)
                .foregroundStyle(Color.madiiYellowGreen)
        }
    }
}

#Preview {
     NavigationStack {
         MadiiTabView()
     }
     
//    DailyJoyView(date: Date())
}
