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
        }
    }
}

struct SplashView_P3: View {
    var body: some View {
        Text("Splash View P3")
    }
}

struct OnboardingView_P3: View {
    var body: some View {
        Text("OnboardingView_P3")
    }
}

struct LoginView_P3: View {
    var body: some View {
        Text("LoginView_P3")
    }
}

struct MadiiTabView_P3: View {
    var body: some View {
        Text("MadiiTabView_P3")
    }
}
