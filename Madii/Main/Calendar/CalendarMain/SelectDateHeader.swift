//
//  SelectDateHeader.swift
//  Madii
//
//  Created by 이안진 on 12/6/23.
//

import SwiftUI

struct SelectDateHeader: View {
    @Binding var selectedDate: Date
    @Binding var showDatePicker: Bool
    
    var body: some View {
        ZStack {
            HStack {
                // 한 달 전
                Button {
                    changeMonth(add: -1)
                    AnalyticsManager.shared.logEvent(name: "캘린더뷰_한달전클릭")
                } label: {
                    changeMonthButton(image: "arrow.left.circle.fill")
                }
                
                Spacer()
                
                // 월, 년 표시
                Button {
                    showDatePicker.toggle()
                    AnalyticsManager.shared.logEvent(name: "캘린더뷰_월년클릭")
                } label: {
                    VStack {
                        Text("\(selectedDate.month)월")
                            .madiiFont(font: .madiiTitle, color: .white)
                        Text("\(selectedDate.year)년")
                            .madiiFont(font: .madiiBody4, color: .gray500)
                    }
                }
                
                Spacer()
                
                // 한 달 후
                Button {
                    changeMonth(add: 1)
                    AnalyticsManager.shared.logEvent(name: "캘린더뷰_한달후클릭")
                } label: {
                    changeMonthButton(image: "arrow.right.circle.fill")
                }
            }
            .padding(.horizontal, 38)
        }
    }
    
    func changeMonth(add addAmount: Int) {
        let calendar = Calendar.current
        let changedDate = calendar.date(byAdding: .month, value: addAmount, to: selectedDate)
        selectedDate = changedDate ?? selectedDate
    }
    
    @ViewBuilder
    func changeMonthButton(image: String) -> some View {
        Image(systemName: image)
            .resizable()
            .frame(width: 28, height: 28)
            .foregroundStyle(Color.gray800)
    }
}
