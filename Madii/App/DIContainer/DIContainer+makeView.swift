//
//  DIContainer+makeView.swift
//  Madii
//
//  Created by Anjin on 8/10/25.
//

import SwiftUI

// MARK: Presentation(View)
extension DIContainer {
    @MainActor
    @ViewBuilder
    func makeView(_ route: Route) -> some View {
        switch route {
        case .splash:
            SplashView_P3()
        case .onboarding:
            OnboardingView_P3()
        case .login:
            LoginView_P3()
        case .tab:
            MadiiTabView_P3()
        case .home:
            HomeView_P3(viewModel: homeViewModel())
        case .exploration:
            ExplorationView_P3()
        case .archiving:
            ArchivingView_P3(viewModel: archivingViewModel())
        case .dailyReview:
            DailyReviewView_P3()
        case .myPage:
            MyPageView_P3()
        }
    }
}

#Preview {
    let router = Router(
        onboardingRepository: .init(userDefaults: .init()),
        container: .init()
    )
    
    MadiiTabView_P3()
        .environment(router)
}
