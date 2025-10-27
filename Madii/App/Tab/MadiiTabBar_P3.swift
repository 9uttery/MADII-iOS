//
//  MadiiTabBar_P3.swift
//  Madii
//
//  Created by Anjin on 9/27/25.
//

import SwiftUI

struct MadiiTabBar_P3: View {
    @Environment(Router.self) var router
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Spacer()
                
                HStack(spacing: 60) {
                    Spacer()
                    
                    ForEach(MadiiTab_P3.allCases, id: \.self) { tab in
                        Button {
                            router.selectedTab = tab
                        } label: {
                            VStack(spacing: 4) {
                                let isSelected = router.selectedTab == tab
                                Image(isSelected ? tab.selectedIcon : tab.unselectedIcon)
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                
                                Text(tab.title)
                                    .madiiFont(.caption).bold()
                                    .foregroundStyle(isSelected ? Color.madiiGreen100 : Color.white.opacity(0.28))
                            }
                            .frame(width: 48)
                        }
                    }
                    
                    Spacer()
                }
                .frame(width: geo.size.width, height: 84)
                .background {
                    Color.madiiGray25
                        .clipShape(
                            UnevenRoundedRectangle(
                                topLeadingRadius: 12,
                                topTrailingRadius: 12
                            )
                        )
                }
            }
            .ignoresSafeArea()
        }
    }
}
