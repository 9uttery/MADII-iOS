//
//  OnboardingView_P3.swift
//  Madii
//
//  Created by Anjin on 9/27/25.
//

import SwiftUI

struct OnboardingView_P3: View {
    @Environment(Router.self) var router
    
    var body: some View {
        VStack(spacing: 40) {
            Text("OnboardingView_P3")
            Text("온보딩 화면")
            
            Button {
                router.hasEverOnboarded = true
            } label: {
                Text("다음")
                    .foregroundStyle(.blue)
            }
        }
    }
}
