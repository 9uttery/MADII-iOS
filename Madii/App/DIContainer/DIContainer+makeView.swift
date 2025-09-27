//
//  DIContainer+makeView.swift
//  Madii
//
//  Created by Anjin on 8/10/25.
//

import SwiftUI

// MARK: - Presentation
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
            HomeView_P3()
        case .exploration:
            ExplorationView_P3()
        case .archiving:
            ArchivingView_P3()
        }
    }
}

struct SplashView_P3: View {
    var body: some View {
        Text("Splash View P3")
    }
}

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

struct LoginView_P3: View {
    @Environment(Router.self) var router
    
    var body: some View {
        VStack(spacing: 40) {
            Text("LoginView_P3")
            
            Button {
                // FIXME: 임시 로그인 로직으로 추후 필요
                router.isLoggedIn = true
            } label: {
                Text("로그인")
                    .foregroundStyle(.blue)
            }
        }
    }
}

struct HomeView_P3: View {
    var body: some View {
        VStack {
            Spacer()
            Text("HomeView_P3_홈화면")
            Spacer()
        }
    }
}

struct ExplorationView_P3: View {
    var body: some View {
        VStack {
            Spacer()
            Text("ExplorationView_P3_탐색화면")
            Spacer()
        }
    }
}

struct ArchivingView_P3: View {
    var body: some View {
        VStack {
            Spacer()
            Text("ArchivingView_P3_아카이브화면")
            Spacer()
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
