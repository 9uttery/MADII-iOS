//
//  TodayJoyEntryView.swift
//  MadiiWidget
//
//  Created by Anjin on 2/1/25.
//

import SwiftUI
import WidgetKit

struct TodayJoyEntryView: View {
    @Environment(\.widgetFamily) var family: WidgetFamily
    let entry: TodayJoyProvider.Entry
    
    var body: some View {
        switch self.family {
        case .systemSmall:
            TodayJoySystemSmallView(entry: entry)
        case .accessoryRectangular:
            TodayJoyAccessoryRectangularView(entry: entry)
        default:
            TodayJoySystemSmallView(entry: entry)
        }
    }
}
