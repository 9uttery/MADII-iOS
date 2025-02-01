//
//  MadiiWidget.swift
//  MadiiWidget
//
//  Created by Anjin on 12/23/24.
//

import SwiftUI
import WidgetKit

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> TodayJoyEntry {
        TodayJoyEntry()
    }
    
    func getSnapshot(in context: Context, completion: @escaping (TodayJoyEntry) -> Void) {
        let entry = TodayJoyEntry()
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        let timeline = Timeline(entries: [TodayJoyEntry()], policy: .atEnd)
        completion(timeline)
    }
}

struct TodayJoyEntry: TimelineEntry {
    let date: Date = .now
    let todayJoy: String = "넷플릭스 보면서 귤까먹기"
}

struct MadiiWidgetEntryView: View {
    var entry: Provider.Entry
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("오늘의 소확행 선물")
                .foregroundColor(Color(red: 0.81, green: 0.98, blue: 0.32))

            Text("작은 새해 목표 세우기 위젯은 29자까지 가능할 듯함")
        }
        .frame(maxWidth: .infinity)
        .background {
            LinearGradient(
                stops: [
                    Gradient.Stop(color: Color(red: 0.06, green: 0.07, blue: 0.11), location: 0.12),
                    Gradient.Stop(color: Color(red: 0.25, green: 0.27, blue: 0.52), location: 0.62),
                    Gradient.Stop(color: Color(red: 0.42, green: 0.44, blue: 0.68), location: 1.00)
                ],
                startPoint: UnitPoint(x: 0.5, y: 0),
                endPoint: UnitPoint(x: 0.5, y: 1.27)
            )
        }
    }
}

struct MadiiWidget: Widget {
    let kind: String = "MadiiWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                MadiiWidgetEntryView(entry: entry)
                    .containerBackground(.black, for: .widget)
            } else {
                MadiiWidgetEntryView(entry: entry)
                    .background(Color.black)
            }
        }
        .configurationDisplayName("오늘의 소확행 선물 🍀")
        .description("오늘의 소확행을 확인할 수 있어요")
        .contentMarginsDisabled()
        .supportedFamilies([.systemSmall])
    }
}

// 프리뷰 정의
struct MyWidgetPreviews: PreviewProvider {
    static var previews: some View {
        // 여러 위젯 크기 프리뷰
        if #available(iOS 17.0, *) {
            MadiiWidgetEntryView(entry: TodayJoyEntry())
                .containerBackground(.black, for: .widget)
                .previewContext(WidgetPreviewContext(family: .systemSmall))
        }
    }
}
