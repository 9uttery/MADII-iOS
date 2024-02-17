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
    
    @State private var imageName: String = "LaunchScreen"
    
    var body: some View {
        NavigationStack {
            if isLoadingFinished == false {
                // 로딩 중.. - 스플래시 뷰
                splashView
            } else if isTokenVaild {
                // 리프레시 토큰 유효 - main
                if isProfileExist {
                    // 프로필 있음 - 메인 화면
                    MadiiTabView()
                } else {
                    // 프로필 없음 - 프로필 저장 화면
                    LoginView()
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
    
    private var splashView: some View {
        VStack {
            Image(imageName)
                .resizable()
                .frame(width: 252, height: 35)
                .padding(.top, 220)
            Spacer()
            HStack { Spacer() }
        }
        .background(Color.madiiNavy)
    }
    
    private func printAppStorageVariables() {
        print("DEBUG @AppStorage hasEverLoggedIn: \(hasEverLoggedIn)")
        print("DEBUG @AppStorage isLoggedIn: \(isLoggedIn)")
    }
    
    private func reissueTokens() {
        isLoggedIn = false
        
        DispatchQueue.global().async {
            UsersAPI.shared.reissueToken { isSuccess, response in
                if isSuccess {
                    isTokenVaild = true
                    isProfileExist = response.hasProfile
                    isLoggedIn = true
                    print("DEBUG(reissue token) isSucees true: isTokenValie \(isTokenVaild), isProfileExist \(isProfileExist), isLoggedIn \(isLoggedIn)")
                } else {
                    isTokenVaild = false
                    isProfileExist = false
                    isLoggedIn = false
                    print("DEBUG(reissue token) isSucees false: isTokenValie \(isTokenVaild), isProfileExist \(isProfileExist), isLoggedIn \(isLoggedIn)")
                }
            }
        }
    }
    
    private func delaySplashView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            withAnimation(.smooth) {
                imageName = "LaunchScreenGreen"
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation {
                isLoadingFinished = true
            }
        }
    }
}

#Preview {
    SplashView()
}
