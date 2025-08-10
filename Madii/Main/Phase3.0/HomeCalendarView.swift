//
//  MonthCalendarView.swift
//  Madii
//
//  Created by 정태우 on 8/7/25.
//

import SwiftUI

struct HomeCalendarView: View {
    @Binding var isMonthly: Bool
    let currentDate = Date()
    var days: [Date] {
        getMonthDates(for: currentDate)
    }

    var weekIndex: Int {
        currentWeekIndex(in: days, today: currentDate)
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text("\(currentDate.month)월")
                    .madiiFont(font: .madiiSubTitle, color: .madiiNormal)
                
                Spacer()
                
                Button {
                    isMonthly.toggle()
                    print(weekIndex)
                } label: {
                    HStack(spacing: 0) {
                        Text(isMonthly ? "월" : "주")
                            .madiiFont(font: .caption, color: .madiiNeutral)
                            .padding(.leading, 8)
                        
                        Image(isMonthly ? "caretDown" : "caretUp")
                            .padding(.trailing, 2)
                    }
                    .background(.madiiAssistive)
                    .cornerRadius(90)
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 16)
            
            VStack(spacing: 0) {
                let daysOfWeek = ["일", "월", "화", "수", "목", "금", "토"]
                let todayWeekdayIndex = Calendar.current.component(.weekday, from: Date()) - 1
                HStack {
                    ForEach(daysOfWeek, id: \.self) { day in
                        Text(day)
                            .madiiFont(
                                font: .madiiBody2,
                                color: daysOfWeek.firstIndex(of: day) == todayWeekdayIndex ? .madiiGreen100 : .madiiAlternative
                            )
                            .frame(maxWidth: .infinity)
                    }
                }
                let days = getMonthDates(for: currentDate)
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 12) {
                    ForEach(days, id: \.self) { date in
                        Text(dateString(date))
                            .madiiFont(
                                font: .madiiBody1,
                                color: Calendar.current.isDateInToday(date) ? .madiiContrast : Calendar.current.isDate(date, equalTo: currentDate, toGranularity: .month) ? .primary : .secondary
                            )
                            .frame(maxWidth: .infinity)
                            .frame(height: 36)
                            .background(Calendar.current.isDateInToday(date)
                                        ? .madiiGreen100
                                        : .clear)
                            .cornerRadius(8)
                            .padding(.horizontal, 6)
                    }
                }
                .offset(y: isMonthly ? 0 : CGFloat(numberOfWeeksInMonth(for: currentDate) - 1) * 24 - CGFloat(weekIndex) * 48)
                .frame(height: CGFloat(isMonthly ? numberOfWeeksInMonth(for: currentDate) * 36 + (numberOfWeeksInMonth(for: currentDate) - 1) * 12 + 20 : 56))
                .clipped()
            }
            .padding(.horizontal, 16)
        }
        .padding(.bottom, 32)
    }
    
    func getMonthDates(for date: Date) -> [Date] {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "ko_KR")

        let range = calendar.range(of: .day, in: .month, for: date)!
        let firstOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: date))!
        let firstWeekday = calendar.component(.weekday, from: firstOfMonth)

        var dates: [Date] = []

        // 전달 마지막 며칠 + 이번 달 날짜 추가
        for offset in -(firstWeekday - 1)..<range.count {
            if let date = calendar.date(byAdding: .day, value: offset, to: firstOfMonth) {
                dates.append(date)
            }
        }

        // 총 셀 수: 주 수 * 7
        let totalCells = numberOfWeeksInMonth(for: date) * 7

        // 현재 dates에 들어있는 날짜 수 빼고, 남은 칸 만큼 다음 달 날짜 추가
        let remaining = totalCells - dates.count

        if remaining > 0 {
            let nextMonth = calendar.date(byAdding: .month, value: 1, to: firstOfMonth)!
            for day in 0..<remaining {
                if let nextDate = calendar.date(byAdding: .day, value: day, to: nextMonth) {
                    dates.append(nextDate)
                }
            }
        }

        return dates
    }

    func dateString(_ date: Date) -> String {
        String(Calendar.current.component(.day, from: date))
    }
    
    func currentWeekIndex(in monthDates: [Date], today: Date) -> Int {
        // monthDates를 7일씩 나누기
        let weeks = stride(from: 0, to: monthDates.count, by: 7).map {
            Array(monthDates[$0..<min($0+7, monthDates.count)])
        }

        // 오늘 날짜가 포함된 주의 인덱스 찾기
        for (index, week) in weeks.enumerated() {
            if week.contains(where: { Calendar.current.isDate($0, inSameDayAs: today) }) {
                return index
            }
        }

        return 0 // 못 찾으면 첫 번째 주로
    }
    
    func numberOfWeeksInMonth(for date: Date) -> Int {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "ko_KR")

        let range = calendar.range(of: .day, in: .month, for: date)!
        let firstOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: date))!
        let firstWeekday = calendar.component(.weekday, from: firstOfMonth)

        // 첫 주 시작 요일 이전 공백 + 이번 달 날짜 수
        let totalCells = (firstWeekday - 1) + range.count

        // 총 칸수를 7로 나눠 올림 → 주 수
        return Int(ceil(Double(totalCells) / 7.0))
    }
}
