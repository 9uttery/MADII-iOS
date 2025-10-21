//
//  MonthCalendarView.swift
//  Madii
//
//  Created by 정태우 on 8/7/25.
//

import SwiftUI

struct HomeCalendarView: View {
    @Binding var isMonthly: Bool
    @State private var currentDate = Date()
    @Binding var selectedDay: Date
    @State var satisfactions: [SatisfactionDate] = []

    var days: [Date] { getMonthDates(for: currentDate) }
    var weekIndex: Int { currentWeekIndex(in: days, today: selectedDay) }

    var body: some View {
        VStack(spacing: 0) {
            calendarHeader
            calendarBody
        }
        .padding(.bottom, 32)
        .onAppear {
            getCalendarEmojiList()
        }
    }

    private var calendarHeader: some View {
        HStack(spacing: 4) {
            Button {
                if let prevMonth = Calendar.current.date(byAdding: .month, value: -1, to: currentDate) {
                    currentDate = prevMonth
                    updateSelectedDay(for: prevMonth)
                }
            } label: {
                Image("caretLeft")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(.madiiAlternative)
            }
            
            Text("\(currentDate.month)월")
                .madiiFont(font: .madiiSubTitle, color: .madiiNormal)
            
            Button {
                if let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: currentDate) {
                    currentDate = nextMonth
                    updateSelectedDay(for: nextMonth)
                }
            } label: {
                Image("caretRight")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(.madiiAlternative)
            }
            
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
    }

    private var calendarBody: some View {
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
                        .lineSpacing(9.6)
                        .frame(maxWidth: .infinity)
                }
            }

            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 12) {
                ForEach(days, id: \.self) { date in
                    Button {
                        selectedDay = date
                    } label: {
                        dayCell(for: date)
                    }
                }
            }
            .offset(y: isMonthly ? 0 : CGFloat(numberOfWeeksInMonth(for: selectedDay) - 1) * 24 - CGFloat(weekIndex) * 48)
            .frame(height: CGFloat(isMonthly ? numberOfWeeksInMonth(for: selectedDay) * 36 + (numberOfWeeksInMonth(for: selectedDay) - 1) * 12 + 20 : 56))
            .clipped()
            .contentShape(Rectangle())
        }
        .padding(.horizontal, 16)
    }

    @ViewBuilder
    private func dayCell(for date: Date) -> some View {
        if let matched = satisfactions.first(where: { $0.date == date.serverDateFormat }), !selectedDay.isSameDay(as: date) {
            Image("satisfaction\(matched.satisfaction.intToSatisfaction)")
                .resizable()
                .frame(width: 30, height: 30)
        } else {
            let isToday = Calendar.current.isDateInToday(date)
            let isCurrentMonth = Calendar.current.isDate(date, equalTo: currentDate, toGranularity: .month)
            
            Text(dateString(date))
                .madiiFont(
                    font: .madiiBody1,
                    color: selectedDay.isSameDay(as: date) ? .madiiContrast : (isToday ? .madiiNormal : !isToday ? .madiiAlternative : (isCurrentMonth ? .primary : .secondary))
                )
                .frame(maxWidth: .infinity)
                .frame(height: 36)
                .background(selectedDay.isSameDay(as: date) ? Color.madiiGreen100 : .clear)
                .cornerRadius(8)
                .padding(.horizontal, 5)
                .overlay(
                    Circle()
                        .stroke(
                            style: StrokeStyle(lineWidth: 1, lineCap: .butt, dash: [1, 1])
                        )
                        .frame(width: 36, height: 36)
                        .foregroundStyle(selectedDay.isSameDay(as: date) || date > Date() || date.isSameDay(as: Date()) ? .clear : .madiiAssistive)
                )
        }
    }

    func getMonthDates(for date: Date) -> [Date] {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "ko_KR")
        let range = calendar.range(of: .day, in: .month, for: date)!
        let firstOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: date))!
        let firstWeekday = calendar.component(.weekday, from: firstOfMonth)
        var dates: [Date] = []

        for offset in -(firstWeekday - 1)..<range.count {
            if let date = calendar.date(byAdding: .day, value: offset, to: firstOfMonth) {
                dates.append(date)
            }
        }

        let totalCells = numberOfWeeksInMonth(for: date) * 7
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
        let weeks = stride(from: 0, to: monthDates.count, by: 7).map {
            Array(monthDates[$0..<min($0+7, monthDates.count)])
        }
        for (index, week) in weeks.enumerated() {
            if week.contains(where: { Calendar.current.isDate($0, inSameDayAs: today) }) {
                return index
            }
        }
        return 0
    }

    func numberOfWeeksInMonth(for date: Date) -> Int {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "ko_KR")
        let range = calendar.range(of: .day, in: .month, for: date)!
        let firstOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: date))!
        let firstWeekday = calendar.component(.weekday, from: firstOfMonth)
        let totalCells = (firstWeekday - 1) + range.count
        return Int(ceil(Double(totalCells) / 7.0))
    }

    func updateSelectedDay(for newMonth: Date) {
        let calendar = Calendar.current
        let day = calendar.component(.day, from: selectedDay)
        let range = calendar.range(of: .day, in: .month, for: newMonth)!
        let maxDay = range.count
        let newDay = min(day, maxDay)
        if let adjustedDate = calendar.date(from: DateComponents(
            year: calendar.component(.year, from: newMonth),
            month: calendar.component(.month, from: newMonth),
            day: newDay
        )) {
            selectedDay = adjustedDate
        }
    }
    func getCalendarEmojiList() {
        DailySummaryAPI.shared.getDailySummaryList(date: selectedDay) { isSuccess, dailySummary in
            if isSuccess {
                print("Debug getDailySummaryList: isSuccess true")
                satisfactions = []
                satisfactions = dailySummary.map { dto in
                    SatisfactionDate(date: dto.createdDate, satisfaction: dto.satisfaction)
                }
            } else {
                print("Debug getDailySummaryList: isSuccess false")
            }
        }
    }
}

struct SatisfactionDate: Codable, Hashable {
    let date: String
    let satisfaction: Int
}
