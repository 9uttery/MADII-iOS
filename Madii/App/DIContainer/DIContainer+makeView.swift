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
        case let .dailyReview(todayJoys, visibleJoys):
            DailyReviewView_P3(todayJoys: todayJoys, visibleJoys: visibleJoys)
        case .myPage:
            MyPageView_P3()
        case .albumList:
            AlbumListView_P3(viewModel: albumListViewModel())
        case let .albumDetail(albumId):
            AlbumDetailView_P3(viewModel: albumDetailViewModel(albumId: albumId))
        case let .review(savingJoys):
            ReviewView_P3(savingJoys: savingJoys)
        case .recommend:
            RecommendJoyView_P3()
        case let .completeRecommend(joy):
            CompleteRecommendJoyView(joy: .constant(joy))
        case .allAlbumList:
            AllAlbumListView_P3()
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
