//
//  OnboardingView_P3.swift
//  Madii
//
//  Created by Anjin on 9/27/25.
//

import MadiiDesignSystem
import SwiftUI

struct OnboardingView_P3: View {
    @Environment(Router.self) var router
    
    @State private var selectedStep = 0
    private let steps = OnboardingStep.steps
    
    var body: some View {
        ZStack {
            OnboardingBackground_P3()
                .ignoresSafeArea()
            
            VStack(spacing: 28) {
                // 온보딩 카드 이미지 캐러셀
                TabView(selection: $selectedStep) {
                    ForEach(0 ..< steps.count, id: \.self) { index in
                        OnboardingCard_P3(step: steps[index])
                            .padding(.horizontal, 36)
                            .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .frame(maxHeight: 460)
                
                // 점 인디케이터
                HStack(spacing: 4) {
                    ForEach(0 ..< steps.count, id: \.self) { index in
                        Circle()
                            .frame(width: 8, height: 8)
                            .foregroundStyle(
                                index == selectedStep
                                ? Color.madiiNormal
                                : Color.white.opacity(0.35)
                            )
                    }
                }
                
                Spacer()
            }
            .padding(.top, 80)
            
            VStack {
                Spacer()
                
                // 다음 버튼
                Button {
                    if selectedStep < steps.count - 1 {
                        withAnimation {
                            selectedStep += 1
                        }
                    } else {
                        // 온보딩 끝
                        router.hasEverOnboarded = true
                    }
                } label: {
                    MadiiButton(
                        title: selectedStep < steps.count - 1 ? "다음" : "로그인하기",
                        color: .yellowGreen
                    )
                }
                .padding(.horizontal, 20)
            }
            .padding(.bottom, 16)
        }
    }
}

private struct OnboardingBackground_P3: View {
    var body: some View {
        LinearGradient(
            stops: [
                Gradient.Stop(color: .black, location: 0.00),
                Gradient.Stop(color: Color(red: 0.08, green: 0.1, blue: 0.21), location: 1.00)
            ],
            startPoint: UnitPoint(x: 0.5, y: 0),
            endPoint: UnitPoint(x: 0.5, y: 1)
        )
    }
}

#Preview {
    let router = Router(
        onboardingRepository: .init(userDefaults: .init()),
        container: .init()
    )
    
    OnboardingView_P3()
        .environment(router)
}
