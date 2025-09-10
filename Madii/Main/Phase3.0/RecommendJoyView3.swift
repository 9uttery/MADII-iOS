//
//  RecommendJoyView3.swift
//  Madii
//
//  Created by 정태우 on 8/29/25.
//

import SwiftUI
import MadiiDesignSystem

struct RecommendJoyView3: View {
    var body: some View {
        VStack(spacing: 0) {
            Text("키워드를 선택해 나만을 위한 소확행을 찾아보세요")
                .madiiFont(font: .madiiBody3, color: .madiiNeutral)
                .padding(.vertical, 20)
            
            HStack(spacing: 12) {
                RecommendButton(title: "화창한 날씨")
                
                RecommendButton(title: "혼자서")
                
                RecommendButton(title: "다함께")
            }
            .padding(.bottom, 12)
            
            HStack(spacing: 12) {
                RecommendButton(title: "특별한 도전을 할 수 있는")
                
                RecommendButton(title: "둘이서")
            }
            .padding(.bottom, 12)
            
            HStack(spacing: 12) {
                RecommendButton(title: "눈 오는 날씨")
                
                RecommendButton(title: "지금 바로 할 수 있는")
            }
            .padding(.bottom, 12)
            
            HStack(spacing: 12) {
                RecommendButton(title: "비 오는 날씨")
                
                RecommendButton(title: "일상 속에서 할 수 있는")
            }
            .padding(.bottom, 60)
            
            HStack(spacing: 12) {
                Circle()
                    .frame(width: 12, height: 12)
                    .foregroundStyle(.madiiDisabled)
                
                RoundedRectangle(cornerRadius: 8)
                    .frame(maxWidth: .infinity)
                    .frame(height: 26)
                    .foregroundStyle(.madiiDisabled)
            }
            .padding(.vertical, 19)
            .padding(.leading, 26)
            .padding(.trailing, 67)
            .background(.madiiElevated)
            .cornerRadius(20)
            .gradientBorder(hexColors: ["FFFFFF", "3DC2FF", "FFFFFF"], lineWidth: 1, cornerRadius: 20, startPoint: .topLeading, endPoint: .bottomTrailing)
            .padding(.horizontal, 20)
            
            HStack(spacing: 12) {
                Circle()
                    .frame(width: 12, height: 12)
                    .foregroundStyle(.madiiDisabled)
                
                RoundedRectangle(cornerRadius: 8)
                    .frame(maxWidth: .infinity)
                    .frame(height: 26)
                    .foregroundStyle(.madiiDisabled)
            }
            .padding(.vertical, 19)
            .padding(.leading, 26)
            .padding(.trailing, 67)
            .background(.madiiElevated)
            .cornerRadius(20)
            .gradientBorder(hexColors: ["FFFFFF", "3DC2FF", "FFFFFF"], lineWidth: 1, cornerRadius: 20, startPoint: .topLeading, endPoint: .bottomTrailing)
            .opacity(0.6)
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            
            HStack(spacing: 12) {
                Circle()
                    .frame(width: 12, height: 12)
                    .foregroundStyle(.madiiDisabled)
                
                RoundedRectangle(cornerRadius: 8)
                    .frame(maxWidth: .infinity)
                    .frame(height: 26)
                    .foregroundStyle(.madiiDisabled)
            }
            .padding(.vertical, 19)
            .padding(.leading, 26)
            .padding(.trailing, 67)
            .background(.madiiElevated)
            .cornerRadius(20)
            .gradientBorder(hexColors: ["FFFFFF", "3DC2FF", "FFFFFF"], lineWidth: 1, cornerRadius: 20, startPoint: .topLeading, endPoint: .bottomTrailing)
            .opacity(0.4)
            .padding(.horizontal, 20)
            
            Spacer()
            
            MadiiDesignSystem.MadiiButton(title: "완료", color: .violet)
                .padding(.horizontal, 20)
        }
        .navigationTitle("취향저격 소확행")
        .background(
            LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: Color(red: 14/255, green: 21/255, blue: 44/255), location: 0.0),
                    .init(color: Color(red: 54/255, green: 33/255, blue: 96/255), location: 1.0)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }
}

#Preview {
    RecommendJoyView3()
}
