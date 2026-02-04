//
//  MonthCalendarView.swift
//  Madii
//
//  Created by 정태우 on 8/7/25.
//

import SwiftUI

enum DayItem: Hashable {
    case empty
    case date(Date)
}

struct HomeCalendarView: View {
    @Binding var isMonthly: Bool
    @State private var currentDate = Date()
    @Binding var selectedDay: Date
    @State var satisfactions: [SatisfactionDate] = []

    var days: [DayItem] {
        if isMonthly {
            return getMonthDates(for: currentDate)
        } else {
            return getWeekDates(for: selectedDay)
        }
    }
    
    var weekIndex: Int { currentWeekIndex(in: days, today: selectedDay) }

    var body: some View {
        VStack(spacing: 0) {
            calendarHeader
            calendarBody
        }
        .padding(.bottom, 24)
        .onAppear {
            getCalendarEmojiList()
        }
        .onChange(of: selectedDay) {
            getCalendarEmojiList()
        }
    }

    private var calendarHeader: some View {
        HStack(spacing: 4) {
            Button {
                if isMonthly {
                    if let prevMonth = Calendar.current.date(byAdding: .month, value: -1, to: currentDate) {
                        currentDate = prevMonth
                        updateSelectedDay(for: prevMonth)
                    }
                } else {
                    if let prevWeek = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: selectedDay) {
                        currentDate = prevWeek
                        selectedDay = prevWeek
                    }
                }
            } label: {
                Image("caretLeft")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(.madiiAlternative)
            }
            
            Text("\(currentDate.month)월")
                .madiiFont(.subTitle)
                .foregroundStyle(.madiiNormal)
            
            Button {
                if isMonthly {
                    if let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: currentDate) {
                        currentDate = nextMonth
                        updateSelectedDay(for: nextMonth)
                    }
                } else {
                    if let nextWeek = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: selectedDay) {
                        currentDate = nextWeek
                        selectedDay = nextWeek
                    }
                }
            } label: {
                Image("caretRight")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(.madiiAlternative)
            }
            
            Spacer()
            
            Button {
                selectedDay = Date()
                currentDate = Date()
            } label: {
                Text("오늘")
                    .madiiFont(.body3)
                    .foregroundStyle(selectedDay.isSameDay(as: Date()) ? .madiiGreen40 : .madiiGreen100)
            }
            .disabled(selectedDay.isSameDay(as: Date()))
            .padding(.trailing, 16)
            
            Button {
                isMonthly.toggle()
                print(weekIndex)
            } label: {
                HStack(spacing: 0) {
                    Text(isMonthly ? "월" : "주")
                        .madiiFont(.caption)
                        .foregroundStyle(.madiiNeutral)
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
        let daysOfWeek = ["일", "월", "화", "수", "목", "금", "토"]
        let todayWeekdayIndex = Calendar.current.component(.weekday, from: selectedDay) - 1
        var calendarHeight: CGFloat {
            if isMonthly {
                let weeks = numberOfWeeksInMonth(for: selectedDay)
                return CGFloat(weeks * 36 + (weeks - 1) * 12 + 16)
            } else {
                return 56
            }
        }
        
        return VStack(spacing: 0) {
            HStack {
                ForEach(daysOfWeek, id: \.self) { day in
                    Text(day)
                        .madiiFont(.body2)
                        .foregroundStyle(daysOfWeek.firstIndex(of: day) == todayWeekdayIndex ? .madiiGreen100 : .madiiAlternative)
                        .lineSpacing(9.6)
                        .frame(maxWidth: .infinity)
                }
            }

            LazyVGrid(
                columns: Array(repeating: GridItem(.flexible()), count: 7),
                spacing: 12
            ) {
                ForEach(days.indices, id: \.self) { index in
                    calendarCell(days[index])
                }
            }
            .frame(height: calendarHeight)
            .clipped()
            .contentShape(Rectangle())
        }
        .padding(.horizontal, 16)
    }
    
    @ViewBuilder
    private func calendarCell(_ item: DayItem) -> some View {
        switch item {
        case .empty:
            Color.clear
                .frame(height: 36)

        case .date(let date):
            Button {
                selectedDay = date
                if isMonthly {
                    let calendar = Calendar.current
                    if !calendar.isDate(date, equalTo: currentDate, toGranularity: .month) {
                        withAnimation {
                            currentDate = date
                        }
                    }
                }
            } label: {
                dayCell(for: date)
            }
        }
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
                .madiiFont(.body1)
                .foregroundStyle(selectedDay.isSameDay(as: date) ? .madiiContrast : (isToday ? .madiiNormal : !isToday ? .madiiAlternative : (isCurrentMonth ? .primary : .secondary)))
                .frame(maxWidth: .infinity)
                .frame(width: 36, height: 36)
                .background(selectedDay.isSameDay(as: date) ? Color.madiiGreen100 : .clear)
                .cornerRadius(8)
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
    
    func getMonthDates(for date: Date) -> [DayItem] {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "ko_KR")

        let range = calendar.range(of: .day, in: .month, for: date)!
        let firstOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: date))!

        // 이번 달 1일의 요일
        let weekday = calendar.component(.weekday, from: firstOfMonth) // 1 = 일요일
        
        var items: [DayItem] = []

        // 앞 빈칸 채우기
        for _ in 0..<(weekday - 1) {
            items.append(.empty)
        }

        // 이번 달 날짜
        for day in range {
            if let dayDate = calendar.date(byAdding: .day, value: day - 1, to: firstOfMonth) {
                items.append(.date(dayDate))
            }
        }

        return items
    }

    func dateString(_ date: Date) -> String {
        String(Calendar.current.component(.day, from: date))
    }

    func currentWeekIndex(in items: [DayItem], today: Date) -> Int {
        // 7개씩 끊어서 week 배열 생성
        let weeks = stride(from: 0, to: items.count, by: 7).map {
            Array(items[$0..<min($0 + 7, items.count)])
        }

        let calendar = Calendar.current

        for (index, week) in weeks.enumerated() {
            // 해당 주에 today's date가 포함되는지 확인
            if week.contains(where: { item in
                if case let .date(date) = item {
                    return calendar.isDate(date, inSameDayAs: today)
                }
                return false
            }) {
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
    
    func getWeekDates(for date: Date) -> [DayItem] {
        let calendar = Calendar.current
        let weekInterval = calendar.dateInterval(of: .weekOfMonth, for: date)!

        var items: [DayItem] = []
        for index in 0..<7 {
            if let date = calendar.date(byAdding: .day, value: index, to: weekInterval.start) {
                items.append(.date(date))
            }
        }
        return items
    }
}

struct SatisfactionDate: Codable, Hashable {
    let date: String
    let satisfaction: Int
}
