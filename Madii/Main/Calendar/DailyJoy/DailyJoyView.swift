//
//  DailyJoyView.swift
//  Madii
//
//  Created by 이안진 on 12/7/23.
//

import SwiftUI

struct DailyJoyView: View {
    @State private var sliderValue: Double = 50.0 // 초기 값 설정
    
    var body: some View {
        VStack(spacing: 0) {
            Text("뜨끈한 메밀차 마시기")
                .madiiFont(font: .madiiTitle, color: .white)
                .padding(.top, 56)
            
            HStack(spacing: 0) {
                Image(systemName: "arrow.left.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundStyle(Color.gray700)
                
                Spacer()
                
                Circle()
                    .frame(width: 220, height: 220)
                    .foregroundStyle(Color.madiiOrange)
                
                Spacer()
                
                Image(systemName: "arrow.right.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundStyle(Color.white)
            }
            .padding(20)
            
            VStack(alignment: .leading, spacing: 16) {
                Text("얼마나 행복하셨나요?")
                    .madiiFont(font: .madiiBody3, color: .white)
                    .padding(.horizontal, 4)
                
                // Slider
                ZStack {
                    Rectangle()
                        .foregroundStyle(
                            LinearGradient(
                                stops: [
                                    Gradient.Stop(color: Color.madiiYellowGreen, location: 0.00),
                                    Gradient.Stop(color: .white, location: 1.00)
                                ],
                                startPoint: UnitPoint(x: 1, y: 0.5),
                                endPoint: UnitPoint(x: 0, y: 0.5)
                            )
                        )
                        .frame(height: 36)
                }
            }
            .padding(20)
            
            Spacer()
            
            MadiiButton(title: "저장", color: .yellowGreen)
                .padding(.horizontal, 16)
                .padding(.bottom, 20)
        }
        .navigationTitle("데일리 소확행")
    }
}

#Preview {
    DailyJoyView()
}
