//
//  MadiiTabView_P3.swift
//  Madii
//
//  Created by Anjin on 9/27/25.
//

import SwiftUI

struct MadiiTabView_P3: View {
    @Environment(Router.self) var router
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // Background
            Color.madiiDefault.ignoresSafeArea()
            
            // Selected View
            router.tabRootView()
            
            // Tab Bar
            MadiiTabBar_P3()
        }
    }
}
