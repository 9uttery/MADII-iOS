//
//  TodayJoyEntry.swift
//  MadiiWidget
//
//  Created by Anjin on 2/1/25.
//

import MadiiNetworking
import WidgetKit

struct TodayJoyEntry: TimelineEntry {
    let date: Date
    let todayJoy: String
    
    init(date: Date, todayJoy: String) {
        self.date = date
        self.todayJoy = todayJoy
    }
    
    init() {
        self.date = .now
        self.todayJoy = "넷플릭스 보면서 귤 까먹기"
    }
}

struct TodayJoyProvider: TimelineProvider {
    // placeholder: 위젯 미리보기 등에서 사용
    func placeholder(in context: Context) -> TodayJoyEntry {
        TodayJoyEntry()
    }
    
    // Snapshot: 위젯 갤러리 등에서 사용
    func getSnapshot(in context: Context, completion: @escaping (TodayJoyEntry) -> Void) {
        let entry = TodayJoyEntry()
        completion(entry)
    }
    
    // 실제 타임라인 생성: 네트워킹을 통해 todayJoy 값을 가져오고, 다음 업데이트 시간을 계산
    func getTimeline(in context: Context, completion: @escaping (Timeline<TodayJoyEntry>) -> Void) {
        Task {
            let currentDate = Date()
            let nextUpdate = computeNextUpdateDate()
            
            // async/await를 사용하여 네트워크 호출
            let result = await JoyAPI().getTodayJoy()
            let todayJoyText: String
            switch result {
            case .success(let response):
                todayJoyText = response.contents
            case .failure(let error):
                print("네트워크 요청 실패: \(error)")
                todayJoyText = "데이터를 가져오지 못했습니다."
            }
            
            let entry = TodayJoyEntry(date: currentDate, todayJoy: todayJoyText)
            let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
            completion(timeline)
        }
    }
    
    // 한국 시간(서울) 기준 아침 10시 다음 업데이트 시간 계산
    private func computeNextUpdateDate() -> Date {
        let calendar = Calendar(identifier: .gregorian)
        let seoulTimeZone = TimeZone(identifier: "Asia/Seoul")!
        let now = Date()
        
        // 현재 날짜를 서울 시간 기준으로 변환한 후, 시, 분, 초를 아침 10시로 설정
        var comps = calendar.dateComponents(in: seoulTimeZone, from: now)
        comps.hour = 10
        comps.minute = 0
        comps.second = 0
        
        guard let today10AM = calendar.date(from: comps) else {
            // 실패 시 fallback: 1시간 뒤 업데이트
            return now.addingTimeInterval(3600)
        }
        
        // 만약 현재 시각이 오늘 10시보다 늦으면, 내일 10시를 반환
        if now >= today10AM {
            return calendar.date(byAdding: .day, value: 1, to: today10AM)!
        } else {
            // 아직 오늘 10시가 안 됐다면, 오늘 10시를 반환
            return today10AM
        }
    }
}
