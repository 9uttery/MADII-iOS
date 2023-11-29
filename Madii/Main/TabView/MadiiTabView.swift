//
//  MadiiTabView.swift
//  Madii
//
//  Created by 이안진 on 11/29/23.
//

import SwiftUI

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
            
            MadiiTabBar(tabIndex: $tabIndex)
        }
    }
}

#Preview {
    MadiiTabView()
}
