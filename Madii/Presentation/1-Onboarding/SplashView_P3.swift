//
//  SplashView_P3.swift
//  Madii
//
//  Created by Anjin on 9/27/25.
//

import SwiftUI

struct SplashView_P3: View {
    @State private var animateImage: Bool = false
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.madiiDepth.ignoresSafeArea()
            
            Image(.splashLogo)
                .resizable()
                .frame(width: 240, height: 50)
                .offset(y: 228)
            
            Image(.splashLogoTinted)
                .resizable()
                .frame(width: 240, height: 50)
                .offset(y: 228)
                .mask(
                    Rectangle()
                        .frame(width: animateImage ? 240 : 0, height: 50)
                        .animation(.easeInOut(duration: 0.45), value: animateImage)
                        .offset(y: 228) // 위치 맞추기
                        .frame(maxWidth: .infinity, alignment: .leading)
                )
        }
        .task {
            try? await Task.sleep(for: .seconds(0.7))
            animateImage = true
        }
    }
}
