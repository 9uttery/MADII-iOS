//
//  MadiiApp.swift
//  Madii
//
//  Created by 이안진 on 11/9/23.
//

import KakaoSDKAuth
import KakaoSDKCommon
import SwiftUI

@main
struct MadiiApp: App {
    @AppStorage("hasEverLogin") var hasEverLogin = false
    
    init() {
        // Kakao SDK 초기화
        let kakaoNativeAppKey = Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"] ?? ""
        KakaoSDK.initSDK(appKey: kakaoNativeAppKey as! String)
        print("DEBUG @AppStorage hasEverLogin: \(hasEverLogin)")
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if hasEverLogin {
                    LoginView()
                } else {
                    OnboardingView()
                }
            }
            .onOpenURL { url in
                if AuthApi.isKakaoTalkLoginUrl(url) {
                    _ = AuthController.handleOpenUrl(url: url)
                }
            }
        }
    }
}
