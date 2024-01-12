//
//  DailyJoyView.swift
//  Madii
//
//  Created by 이안진 on 12/7/23.
//

import SwiftUI

struct DailyJoyView: View {
    @State private var satisfaction: Float = 100
    
    @State private var dummy: [Joy] = Joy.dailyJoyDummy
    @State private var index: Int = 0
    
    var body: some View {
        VStack(spacing: 0) {
            Text(dummy[index].title)
                .madiiFont(font: .madiiTitle, color: .white)
                .padding(.top, 56)
            
            HStack(spacing: 0) {
                Button {
                    if index > 0 {
                        index -= 1
                    }
                } label: {
                    Image(systemName: "arrow.left.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(index == 0 ? Color.gray700 : Color.white)
                }
                .disabled(index == 0)
                
                Spacer()
                
                Circle()
                    .frame(width: 220, height: 220)
                    .foregroundStyle(Color.madiiOrange)
                
                Spacer()
                
                Button {
                    if index < dummy.count - 1 {
                        index += 1
                    }
                } label: {
                    Image(systemName: "arrow.right.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(index == dummy.count - 1 ? Color.gray700 : Color.white)
                }
                .disabled(index == dummy.count - 1)
            }
            .padding(20)
            
            // 만족도 조사
            VStack(alignment: .leading, spacing: 16) {
                Text("얼마나 행복하셨나요?")
                    .madiiFont(font: .madiiBody3, color: .white)
                    .padding(.horizontal, 4)
                
                // Slider
                MadiiSlider(percentage: $dummy[index].satisfaction,
                            onEnded: saveSatisfaction)
            }
            .padding(20)
            
            Spacer()
            
            // 저장 버튼
            MadiiButton(title: "저장", color: .yellowGreen)
                .padding(.horizontal, 16)
                .padding(.bottom, 20)
        }
        .navigationTitle("데일리 소확행")
    }
    
    private func saveSatisfaction() {
        print(dummy[index].satisfaction)
    }
}

#Preview {
    DailyJoyView()
}
