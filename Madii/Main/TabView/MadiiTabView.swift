//
//  MadiiTabView.swift
//  Madii
//
//  Created by 이안진 on 11/29/23.
//

import SwiftUI

struct MadiiTabView: View {
    @State var tabIndex: TabIndex = .record
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                switch tabIndex {
                case .home: HomeView()
                case .record: RecordView()
                case .calendar: CalendarView()
                }
                
                MadiiTabBar(tabIndex: $tabIndex)
            }
        }
    }
}

#Preview {
    MadiiTabView()
}
