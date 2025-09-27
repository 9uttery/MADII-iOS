//
//  Router.swift
//  Madii
//
//  Created by Anjin on 8/10/25.
//

import SwiftUI

@Observable
class Router {
    private let onboardingRepository: OnboardingRepository
    private let container: DIContainer
    
    var path: [Route] = []        // navigation stack view
    var fullScreenRoute: Route?   // full screen view
    var selectedTab: MadiiTab_P3 = .home  // Tab view
    
    // 앱 실행 시, 2초간 로딩 화면 종료 여부
    var isLoadingViewFinished: Bool = false
    
    // 앱 최초 실행 여부 - 온보딩 화면 전환 확인
    var hasEverOnboarded: Bool = false {
        didSet {
            onboardingRepository.setOnboarded()
        }
    }
    
    // 사용자 로그인 여부
    var isLoggedIn: Bool = false
    
    init(
        onboardingRepository: OnboardingRepository,
        container: DIContainer
    ) {
        self.onboardingRepository = onboardingRepository
        
        hasEverOnboarded = onboardingRepository.hasEverOnboarded()
        self.container = container
    }
    
    @MainActor
    @ViewBuilder
    func rootView() -> some View {
        if isLoadingViewFinished == false {
            container.makeView(.splash)
        } else if hasEverOnboarded == false { // 앱 최초 실행
            container.makeView(.onboarding)
        } else if isLoggedIn == false { // 로그인
            container.makeView(.login)
        } else { // 메인 화면
            container.makeView(.tab)
        }
    }
    
    @MainActor
    @ViewBuilder
    func tabRootView() -> some View {
        switch selectedTab {
        case .home:
            container.makeView(.home)
        case .exploration:
            container.makeView(.exploration)
        case .archiving:
            container.makeView(.archiving)
        }
    }
}
