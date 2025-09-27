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
                            Text(tab.title)
                                .frame(width: 60, height: 44)
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
