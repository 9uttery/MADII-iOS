//
//  CalendarView.swift
//  Madii
//
//  Created by 이안진 on 11/29/23.
//

import SwiftUI

struct CalendarView: View {
    @State private var selectedDate = Date()
    let weekdays = ["일", "월", "화", "수", "목", "금", "토"]
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    // "캘린더" 타이틀과 마이페이지 버튼
                    title.padding(.bottom, 20)
                    
                    // 월 선택 header
                    SelectDateHeaderView(selectedDate: $selectedDate)
                    
                    // 요일 header
                    weekdaysHeader.padding(.bottom, 12)
                    
                    // 일 (캘린더 일자)
                    CalendarDays(selectedDate: $selectedDate)
                    
                    Spacer()
                }
                // 하단 여백 40
                .padding(.bottom, 40)
            }
            .scrollIndicators(.hidden)
        }
        .navigationTitle("")
    }
    
    var title: some View {
        HStack(spacing: 0) {
            Text("캘린더")
                .madiiFont(font: .madiiTitle, color: .white)
                .padding(.vertical, 12)
            
            Spacer()
            
            NavigationLink {
                Text("프로필")
            } label: {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .frame(width: 22, height: 22)
                    .foregroundStyle(Color.gray500)
            }
        }
        .padding(.horizontal, 22)
        .padding(.bottom, 12)
    }
    
    var weekdaysHeader: some View {
        HStack(spacing: 0) {
            ForEach(weekdays, id: \.self) { weekday in
                Text(weekday)
                    .madiiFont(font: .madiiBody3, color: .gray700)
                    .frame(width: 42, height: 42)
                
                if weekday != weekdays.last {
                    Spacer()
                }
            }
        }
        .padding(.horizontal, 26)
    }
}

#Preview {
    CalendarView()
}
