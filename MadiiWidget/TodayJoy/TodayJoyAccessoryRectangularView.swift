//
//  TodayJoyAccessoryRectangularView.swift
//  MadiiWidgetExtension
//
//  Created by Anjin on 4/1/25.
//

import SwiftUI

struct TodayJoyAccessoryRectangularView: View {
    let entry: TodayJoyProvider.Entry
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("☘️ 오늘의 소확행 선물")
                    .font(.footnote).bold()
                    .foregroundColor(Color(red: 0.81, green: 0.98, blue: 0.32))
                
                Spacer(minLength: 0)
            }
            
            Text(entry.todayJoy)
                .font(.subheadline).bold()
            
            Spacer(minLength: 0)
        }
    }
}
