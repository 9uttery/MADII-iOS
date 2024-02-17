//
//  CalendarDays.swift
//  Madii
//
//  Created by 이안진 on 12/6/23.
//

import SwiftUI

struct CalendarDays: View {
    let today = Date()
    @Binding var selectedDate: Date
    @State private var showDailyJoyView: Bool = false
    
    // 소확행 커버 구현에 필요한 임시 데이터
    let count = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    let colors = [Color.madiiPurple, Color.madiiOrange, Color.teal]
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(), count: 7), spacing: 10) {
            emptyDays
            
            ForEach(monthDates(), id: \.self) { date in
                NavigationLink {
                    DailyJoyView(date: date)
                } label: {
                    VStack(spacing: 0) {
                        // 일자
                        Text(date.day)
                            .madiiFont(font: .madiiCalendar, color: fontColor(at: date))
                            .frame(width: 36, height: 36)
                            .background(backgroundColor(at: date))
                            .overlay(Circle().strokeBorder(borderColor(at: date), lineWidth: 1))
                            .clipShape(Circle())
                            .frame(width: 42, height: 42)
                        
                        // 각 일마다 있는 소확행 커버
                        LazyVGrid(columns: Array(repeating: GridItem(spacing: 3), count: 3), spacing: 3) {
                            ForEach(0 ..< (count.randomElement() ?? 9), id: \.self) { _ in
                                ZStack {
                                    Circle()
                                        .frame(width: 12, height: 12)
                                        .foregroundStyle(Color.black)
                                        .overlay { Circle().stroke(Color.white.opacity(0.2), lineWidth: 1) }
                                    
                                    Image("icon_1_2")
                                        .resizable()
                                        .frame(width: 6, height: 6)
                                }
                            }
                        }
                        .frame(width: 42)
                        
                        Spacer()
                    }
                    .frame(height: 98)
                    
                }
                .simultaneousGesture(TapGesture().onEnded {
                    selectedDate = date
                    print(selectedDate)
                })
            }
        }
        .padding(.horizontal, 26)
        .onAppear { getJoyIcons() }
//        .navigationDestination(isPresented: $showDailyJoyView) {
//            DailyJoyView(date: selectedDate)
//        }
    }
    
    private func getJoyIcons() {
        AchievementsAPI.shared.getJoyIconsForMonth(date: selectedDate) { isSuccess, response in
            if isSuccess {
                print("DEBUG CalendarDays \(response)")
            } else {
                print("DEBUG CalendarDays 실패")
            }
        }
    }
    
    var emptyDays: some View {
        ForEach(0 ..< countWeekday(), id: \.self) { _ in
            Rectangle()
                .foregroundStyle(Color.clear)
                .frame(width: 42, height: 98)
        }
    }
    
    func countWeekday() -> Int {
        let calendar = Calendar.current
        let startDate = calendar.date(from: calendar.dateComponents([.year, .month], from: selectedDate))!
        let weekdayOfStartDate = calendar.component(.weekday, from: startDate)

        return weekdayOfStartDate - 1
    }
    
    func monthDates() -> [Date] {
        let calendar = Calendar.current
        let monthRange = calendar.range(of: .day, in: .month, for: selectedDate)!
        let startDate = calendar.date(from: calendar.dateComponents([.year, .month], from: selectedDate))!

        return (0 ..< monthRange.count).map { calendar.date(byAdding: .day, value: $0, to: startDate)! }
    }

    func fontColor(at date: Date) -> Color {
        if date.isSameDay(as: today) {
            return Color.madiiOrange
        } else {
            return Color.white
        }
    }
    
    func backgroundColor(at date: Date) -> Color {
        if date.isSameDay(as: selectedDate) {
            // 선택된 날짜가
            if date.isSameDay(as: today) {
                // 오늘이면 하얀색
                return Color.white
            } else {
                // 다른 날이면 주황색
                return Color.madiiOrange
            }
        } else {
            // 나머지는 투명
            return Color.clear
        }
    }
    
    func borderColor(at date: Date) -> Color {
        // 오늘이고 선택되지 않았을 때
        if date.isSameDay(as: today) && date.isSameDay(as: selectedDate) == false {
            return Color.madiiOrange
        } else {
            return Color.clear
        }
    }
}

#Preview {
    CalendarView()
}
