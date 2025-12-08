//
//  SignOutView_P3.swift
//  Madii
//
//  Created by Anjin on 12/8/25.
//

import KeychainSwift
import MadiiDesignSystem
import SwiftUI

struct SignOutView_P3: View {
    var body: some View {
        ZStack {
            Color.madiiDefault.ignoresSafeArea()
                .onTapGesture { hideKeyboard() }
            
            VStack(spacing: 0) {
                MyPageNavigationBar(title: "회원탈퇴")
                
                GeometryReader { geo in
                    ScrollView(.vertical) {
                        VStack(spacing: 0) {
                            UserStatusView()
                                .frame(width: geo.size.width, height: geo.size.height + geo.safeAreaInsets.bottom)
                            
                            FinalSignOutView()
                                .frame(width: geo.size.width, height: geo.size.height - geo.safeAreaInsets.bottom)
                        }
                    }
                    .scrollTargetBehavior(.paging)
                    .scrollIndicators(.hidden)
                }
            }
        }
    }
}

private struct UserStatusView: View {
    @State var nickname: String = "사용자"
    @State var days: Int = 0
    @State var joy: Int = 0
    @State var play: Int = 0
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text("\(nickname)님은")
                    Text("\(days)일 동안 일상 속에서")
                    Text("\(joy)개의 행복을")
                    Text("\(play)번 재생해왔어요")
                }
                .madiiFont(.subTitle)
                .foregroundStyle(Color.madiiGray100)
                
                Spacer()
            }
            
            Spacer()
            
            Image(.signOutClover)
                .resizable()
                .scaledToFit()
                .frame(width: 320)
            
            Spacer()
            
            Image(.signOutArrow)
                .resizable()
                .scaledToFit()
                .frame(width: 32)
                .padding(.bottom, 26)
        }
        .padding(20)
        .onAppear { getUserStat() }
    }
    
    private func getUserStat() {
        ProfileAPI.shared.getUsersStat { isSuccess, userStat in
            if isSuccess {
                nickname = userStat.nickname
                days = userStat.activeDays
                joy = userStat.achievedJoyCount
                play = userStat.achievementCount
            }
        }
    }
}

private struct FinalSignOutView: View {
    @Environment(Router.self) var router
    private let keychain = KeychainSwift()
    
    var body: some View {
        VStack(spacing: 80) {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text("정말 마디를 떠나시겠어요?")
                        .madiiFont(.subTitle)
                    
                    Text("지금 마디를 탈퇴하면\n모든 데이터가 사라지고 복원되지 않아요")
                        .madiiFont(.body2)
                }
                .foregroundStyle(Color.madiiGray100)
                .multilineTextAlignment(.leading)
                
                Spacer()
            }
            
            Image(.signOutTrashCan)
                .resizable()
                .scaledToFit()
                .frame(width: 180)
            
            Spacer()
            
            HStack(spacing: 10) {
                MadiiDesignSystem.MadiiButton(
                    title: "탈퇴하기",
                    color: .neutral,
                    action: signOut
                )
                .frame(width: 115)
                
                MadiiDesignSystem.MadiiButton(
                    title: "홈으로 가기",
                    color: .mainColor,
                    action: { router.popToRoot() }
                )
            }
        }
        .padding(20)
    }
    
    private func signOut() {
        AnalyticsManager.shared.logEvent(name: "탈퇴뷰_회원탈퇴클릭")
        ProfileAPI.shared.deleteUsersProfile { isSuccess in
            if isSuccess {
                Task {
                    // UserDefaults 삭제
                    for key in UserDefaults.standard.dictionaryRepresentation().keys {
                        UserDefaults.standard.removeObject(forKey: key.description)
                    }
                    
                    UserDefaults.standard.set(true, forKey: "hasEverLoggedIn")
                    
                    // 키체인 삭제
                    keychain.clear()
                    
                    // Router
                    await MainActor.run {
                        router.isLoggedIn = false
                        router.popToRoot()
                    }
                    
                    print("삭제 완료")
                }
                
                print("회원탈퇴에 성공하였습니다.")
            }
        }
    }
}
