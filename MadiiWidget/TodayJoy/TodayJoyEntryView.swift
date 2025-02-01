//
//  TodayJoyEntryView.swift
//  MadiiDesignSystem
//
//  Created by Anjin on 2/1/25.
//

import MadiiDesignSystem
import SwiftUI

struct TodayJoyEntryView: View {
    var entry: TodayJoyProvider.Entry
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text("오늘의 소확행 선물")
                        .madiiFont(font: .madiiBody5, color: .madiiYellowGreen)
                        .foregroundColor(Color(red: 0.81, green: 0.98, blue: 0.32))
                        .padding(.vertical, (20 - fontHeight(size: 12)) / 2)
                    
                    Spacer(minLength: 0)
                }
                
                Text(entry.todayJoy)
                    .madiiFont(font: .madiiBody1, color: .white)
                    .lineSpacing(23 - fontHeight(size: 16))
                    .padding(.vertical, (23 - fontHeight(size: 16)) / 2)
            }
            
            Spacer(minLength: 0)
            
            Image("widget_logo")
        }
        .frame(maxWidth: .infinity)
        .padding()
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
    
    private func fontHeight(size: CGFloat) -> CGFloat {
        let height = UIFont(name: "SpoqaHanSansNeo-Bold", size: size)?.lineHeight
        var tempHeight: CGFloat = 0
        if size == 12 {
            tempHeight = 15.024
        } else if size == 16 {
            tempHeight = 20.032
        }
        return height ?? tempHeight
    }
}
