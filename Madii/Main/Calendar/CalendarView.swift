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
                    title
                    weekdaysHeader
                        .padding(.bottom, 12)
                    
                    LazyVGrid(columns: Array(repeating: GridItem(), count: 7), spacing: 10) {
                        ForEach(0 ..< countWeekday(), id: \.self) { _ in
                            Rectangle()
                                .foregroundStyle(Color.blue)
                                .frame(width: 42, height: 98)
                        }
                        
                        ForEach(monthDates(), id: \.self) { date in
                            VStack(spacing: 0) {
                                // 일자
                                Text(date.day)
                                    .frame(width: 42, height: 42)
                                    .background(date.isSameDay(as: selectedDate) ? Color.blue : Color.gray)
                                //                                .clipShape(Circle())
                                    .onTapGesture {
                                        selectedDate = date
                                    }
                                
                                // 각 일마다 있는 소확행 커버
                                LazyVGrid(columns: Array(repeating: GridItem(spacing: 3), count: 3), spacing: 3) {
                                    ForEach(0 ..< 9, id: \.self) { i in
                                        Circle()
                                    }
                                }
                                .frame(width: 42)
                                .background(Color.brown)
                                
                                Spacer()
                            }
                            .frame(height: 98)
                        }
                    }
                    .padding(.horizontal, 26)
                    
                    Spacer()
                }
                .background(Color.red)
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
                    .madiiFont(font: .madiiBody3, color: .gray100)
                    .frame(width: 42, height: 42)
                    .background(Color.green)
                
                if weekday != weekdays.last {
                    Spacer()
                }
            }
        }
        .padding(.horizontal, 26)
    }
    
    func monthDates() -> [Date] {
        let calendar = Calendar.current
        let monthRange = calendar.range(of: .day, in: .month, for: selectedDate)!
        let startDate = calendar.date(from: calendar.dateComponents([.year, .month], from: selectedDate))!

        return (0 ..< monthRange.count).map { calendar.date(byAdding: .day, value: $0, to: startDate)! }
    }

    func countWeekday() -> Int {
        let calendar = Calendar.current
        let startDate = calendar.date(from: calendar.dateComponents([.year, .month], from: selectedDate))!
        let weekdayOfStartDate = calendar.component(.weekday, from: startDate)

        return weekdayOfStartDate - 1
    }
}

#Preview {
    CalendarView()
}

extension Date {
    var day: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        return dateFormatter.string(from: self)
    }
    
    var month: String {
        let calendar = Calendar.current
        let month = calendar.component(.month, from: self)
        return "\(month)"
    }
    
    var year: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy" // "yyyy"는 4자리 연도를 나타내는 포맷입니다
        return dateFormatter.string(from: self)
    }
    
    func isSameDay(as date: Date) -> Bool {
        Calendar.current.isDate(self, inSameDayAs: date)
    }
}
