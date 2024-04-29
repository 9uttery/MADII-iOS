//
//  TabBarButton.swift
//  Madii
//
//  Created by 이안진 on 11/29/23.
//

import SwiftUI

struct TabBarButton: View {
    let tabIndex: TabIndex
    @Binding var selectedTabIndex: TabIndex
    
    var body: some View {
        Button {
            selectedTabIndex = tabIndex
        } label: {
            VStack(spacing: 4) {
                Image(imageName())
                    .resizable()
                    .frame(width: 24, height: 24)
                
                Text(title())
                    .madiiFont(font: .madiiCaption, color: fontColor(), withHeight: true)
            }
            .frame(width: 48)
        }
    }
    
    func title() -> String {
        switch tabIndex {
        case .home: "홈"
        case .record: "레코드"
        case .calendar: "캘린더"
        }
    }
    
    func imageName() -> String {
        let isSelected: Bool = tabIndex == selectedTabIndex
        
        switch tabIndex {
        case .home:
            return isSelected ? "home" : "unHome"
        case .record:
            return isSelected ? "record" : "unRecord"
        case .calendar:
            return isSelected ? "calendar" : "unCalendar"
        }
    }
    
    func fontColor() -> Color {
        if selectedTabIndex == tabIndex {
            return .madiiYellowGreen
        } else {
            return .gray500
        }
    }
}
