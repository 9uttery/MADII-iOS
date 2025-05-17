//
//  MadiiWidget.swift
//  MadiiWidget
//
//  Created by Anjin on 12/23/24.
//

import SwiftUI
import WidgetKit

struct MadiiWidget: Widget {
    let kind: String = "MadiiWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: TodayJoyProvider()) { entry in
            if #available(iOS 17.0, *) {
                TodayJoyEntryView(entry: entry)
                    .containerBackground(.black, for: .widget)
            } else {
                TodayJoyEntryView(entry: entry)
                    .background(Color.black)
            }
        }
        .configurationDisplayName("오늘의 소확행 선물 ☘️")
        .description("오늘의 소확행을 확인할 수 있어요")
        .contentMarginsDisabled()
        .supportedFamilies([.systemSmall, .accessoryRectangular])
    }
}

// 프리뷰 정의
struct MyWidgetPreviews: PreviewProvider {
    static var previews: some View {
        // 여러 위젯 크기 프리뷰
        if #available(iOS 17.0, *) {
            TodayJoyEntryView(entry: TodayJoyEntry())
                .containerBackground(.black, for: .widget)
                .previewContext(WidgetPreviewContext(family: .systemSmall))
        }
    }
}
