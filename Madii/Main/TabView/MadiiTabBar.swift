//
//  MadiiTabBar.swift
//  Madii
//
//  Created by 이안진 on 11/29/23.
//

import SwiftUI

enum TabIndex {
    case home, record, calendar
}

struct MadiiTabBar: View {
    @Binding var tabIndex: TabIndex
    
    var body: some View {
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
