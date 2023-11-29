//
//  MadiiTabView.swift
//  Madii
//
//  Created by 이안진 on 11/29/23.
//

import SwiftUI

enum TabIndex {
    case home, record, calendar
}

struct MadiiTabView: View {
    @State var tabIndex: TabIndex = .home
    
    var body: some View {
        ZStack(alignment: .bottom) {
            switch tabIndex {
            case .home:
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Text("home")
                        Spacer()
                    }
                    Spacer()
                }
            case .record:
                Text("record")
            case .calendar:
                Text("calendar")
            }
            
            tabBar
        }
    }
    
    var tabBar: some View {
        HStack(spacing: 0) {
            TabBarButton(tabIndex: .home,
                         selectedTabIndex: $tabIndex)
                .padding(.leading, 42)
            
            Spacer()
            
            TabBarButton(tabIndex: .record,
                         selectedTabIndex: $tabIndex)
            
            Spacer()
            
            TabBarButton(tabIndex: .calendar,
                         selectedTabIndex: $tabIndex)
                .padding(.trailing, 42)
        }
        .padding(.vertical, 10)
        .background(Color.black)
        .cornerRadius(12, corners: [.topLeft, .topRight])
        .shadow(color: .gray800, radius: 0, y: -2)
    }
}

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
                    .madiiFont(font: .madiiBody4, color: fontColor())
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

#Preview {
    MadiiTabView()
}
