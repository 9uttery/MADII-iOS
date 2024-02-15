//
//  SplashView.swift
//  Madii
//
//  Created by 이안진 on 2/16/24.
//

import SwiftUI

struct SplashView: View {
    @AppStorage("hasEverLoggedIn") var hasEverLoggedIn = false
    @AppStorage("isLoggedIn") var isLoggedIn = false
    
    @State private var isLoadingFinished: Bool = false
    @State private var isTokenVaild: Bool = false
    @State private var isProfileExist: Bool = false
    
    var body: some View {
        NavigationStack {
            if isLoadingFinished == false {
                // 로딩 중.. - 스플래시 뷰
                ScrollView {
                    Text("스플래시")
                }
                .background(Color.red)
            } else if isTokenVaild {
                // 리프레시 토큰 유효 - main
                if isProfileExist {
                    MadiiTabView()
                } else {
                    // 프로필 없음 - 프로필 저장 화면
                    ScrollView { Text("프로필 저장") }
                        .background(Color.blue)
                }
            } else if hasEverLoggedIn {
                // 로그인 경험 O - 온보딩 X
                LoginView()
            } else {
                // 로그인 경험 X - 온보딩 O
                OnboardingView()
            }
        }
        .onAppear {
            printAppStorageVariables()
            reissueTokens()
            delaySplashView()
        }
    }
    
    private func printAppStorageVariables() {
        print("DEBUG @AppStorage hasEverLoggedIn: \(hasEverLoggedIn)")
        print("DEBUG @AppStorage isLoggedIn: \(isLoggedIn)")
    }
    
    private func reissueTokens() {
        DispatchQueue.global().async {
            // TODO: 리프레시 토큰으로 재발행
            isTokenVaild = false
            isProfileExist = true
        }
    }
    
    private func delaySplashView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) {
            withAnimation {
                isLoadingFinished = true
            }
        }
    }
}

#Preview {
    SplashView()
}
