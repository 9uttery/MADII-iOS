//
//  HomeCalendar.swift
//  Madii
//
//  Created by 정태우 on 8/7/25.
//

import MadiiDesignSystem
import SwiftUI

struct HomeCalendar: View {
    @Binding var isMonthly: Bool
    @State var type: TextFieldType = .basic
    @State var todayJoyTitle: String = ""
    
    var body: some View {
        VStack {
            HomeCalendarView(isMonthly: $isMonthly)
            
            Rectangle()
                .frame(maxWidth: .infinity)
                .frame(height: 1)
                .foregroundStyle(.madiiGray35)
                .padding(.horizontal, 16)
                .padding(.bottom, 32)
            
            Text("오늘, \(Date().toKoreanString())")
                .madiiFont(font: .madiiSubTitle, color: .madiiNormal)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
            
            MadiiDesignSystem.MadiiTextField(type: $type, text: $todayJoyTitle, isPlus: true, placeholder: "오늘의 행복을 담아보세요")
                .padding(.horizontal, 16)
        }
        .padding(.vertical, 20)
        .background(.madiiElevated)
        .cornerRadius(40)
        .overlay(
            RoundedRectangle(cornerRadius: 40)
                .stroke(
                    LinearGradient(
                        gradient: Gradient(stops: [
                            .init(color: Color.white.opacity(0.1), location: 0.0),
                            .init(color: Color(red: 0x3D/255, green: 0xC2/255, blue: 0xFF/255).opacity(0.1), location: 0.33),
                            .init(color: Color(red: 0xD4/255, green: 0x78/255, blue: 0xFF/255).opacity(0.1), location: 0.68),
                            .init(color: Color.white.opacity(0.1), location: 1.0)
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 1
                )
        )
    }
}

extension Date {
    func toKoreanString(format: String = "M월 d일") -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
