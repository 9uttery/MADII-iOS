//
//  CalendarView.swift
//  Madii
//
//  Created by 이안진 on 11/29/23.
//

import SwiftUI

struct CalendarView: View {
    @AppStorage("isLoggedIn") var isLoggedIn = false
    @State private var selectedDate = Date()
    let weekdays = ["일", "월", "화", "수", "목", "금", "토"]
    @State private var showDatePicker: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            title // "캘린더" 타이틀과 마이페이지 버튼
            
            ScrollView {
                ZStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 0) {
                        // 월 선택 header
                        SelectDateHeader(selectedDate: $selectedDate,
                                             showDatePicker: $showDatePicker)
                        .padding(.top, 20)
                        
                        // 요일 header
                        weekdaysHeader
                            .padding(.horizontal, 9)
                            .padding(.bottom, 12)
                        
                        // 일 (캘린더 일자)
                        CalendarDays(selectedDate: $selectedDate)
                            .padding(.horizontal, 10)
                        
                        Spacer()
                    }
                    // 하단 여백 40
                    .padding(.bottom, 40)
                    
                    if showDatePicker {
                        DatePicker("Select a date", selection: $selectedDate, displayedComponents: .date)
                            .datePickerStyle(.wheel)
                            .labelsHidden()
                            .background(Color(red: 0.13, green: 0.13, blue: 0.13))
                            .cornerRadius(12)
                            .offset(y: 130)
                    }
                }
                .padding(.horizontal, 16)
            }
            .scrollIndicators(.hidden)
        }
        .navigationTitle("")
        .analyticsScreen(name: "캘린더뷰")
    }
    
    var title: some View {
        HStack(spacing: 0) {
            Text("캘린더")
                .madiiFont(font: .madiiTitle, color: .white)
            
            Spacer()
            
            NavigationLink {
                if isLoggedIn {
                    ProfileView()
                } else {
                    GuestProfileView()
                }
            } label: {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(Color.gray500)
            }
            .simultaneousGesture(TapGesture().onEnded {
                AnalyticsManager.shared.logEvent(name: "캘린더뷰_프로필클릭")
            })
        }
        .padding(.horizontal, 22)
        .padding(.vertical, 12)
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
    }
}

#Preview {
    NavigationStack {
        MadiiTabView()
    }
}
