//
//  OnboardingStep.swift
//  Madii
//
//  Created by Anjin on 10/8/25.
//

import SwiftUI

struct OnboardingStep: Identifiable {
    let id: UUID = .init()
    let title: String
    let description: String
    let image: ImageResource
}

extension OnboardingStep {
    static let steps: [OnboardingStep] = [
        .init(
            title: "단단한 내가 되기 위한 시간",
            description: "매일매일 나를 위한\n시간을 가지면서 나를 들여다보고,\n일상을 다시 살아갈 힘을 얻어요",
            image: .onboarding1P3
        ),
        .init(
            title: "아주 소소한 것이라도 좋아요!",
            description: "바쁜 일상 속에서도 잠깐 시간을 내어\n내가 온전히 행복한 순간들을 기록해보세요\n",
            image: .onboarding2P3
        ),
        .init(
            title: "새로운 행복을 발견해요",
            description: "무심코 놓치고 있던 행복을 발견하고,\n취향에 맞는 행복도 추천받을 수 있어요\n",
            image: .onboarding3P3
        )
    ]
}
