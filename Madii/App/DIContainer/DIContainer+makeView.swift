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
        // 초기 화면
        case .splash:
            SplashView_P3()
        case .onboarding:
            OnboardingView_P3()
        case .login:
            LoginView_P3()
                .environment(loginViewModel())
        case .tab:
            MadiiTabView_P3()
            
        // 로그인
        case .loginWithID:
            Text("아이디로 로그인\n구현중")
        case .signInWithID:
            Text("간편 회원가입\n구현중")
        case .setProfile:
            Text("소셜 로그인 후 프로필 설정\n구현중")
            
        // 홈
        case .home:
            HomeView_P3(viewModel: homeViewModel())
        case .exploration:
            ExplorationView_P3()
        case .archiving:
            ArchivingView_P3(viewModel: archivingViewModel())
        case let .dailyReview(todayJoys, visibleJoys, date):
            DailyReviewView_P3(date: date, todayJoys: todayJoys, visibleJoys: visibleJoys)
        
        case .albumList:
            AlbumListView_P3(viewModel: albumListViewModel())
        case let .albumDetail(albumId, popNum):
            AlbumDetailView_P3(viewModel: albumDetailViewModel(albumId: albumId, popNum: popNum))
        case let .review(savingJoys, date):
            ReviewView_P3(date: date, savingJoys: savingJoys)
        case .recommend:
            RecommendJoyView_P3()
        case let .completeRecommend(joy):
            CompleteRecommendJoyView(joy: .constant(joy))
        case .allAlbumList:
            AllAlbumListView_P3()
        case .completeOhadol:
            CompleteReviewView()
            
        // 마이페이지
        case .myPage:
            MyPageView_P3()
        case .profile:
            ProfileView_P3()
        case .notification:
            NotificationView_P3()
        case .notice:
            NoticeView_P3()
        case .inquiry:
            InquiryView_P3()
        case .signOut:
            SignOutView_P3()
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
