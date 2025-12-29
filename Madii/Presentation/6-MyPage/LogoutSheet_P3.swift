//
//  LogoutSheet_P3.swift
//  Madii
//
//  Created by Anjin on 12/1/25.
//

import KeychainSwift
import SwiftUI

struct LogoutSheet_P3: View {
    @Environment(Router.self) var router
    @Binding var showLogoutSheet: Bool
    private let keychain = KeychainSwift()
    
    var body: some View {
        VStack(spacing: 40) {
            RoundedRectangle(cornerRadius: 100)
                .frame(width: 100, height: 5)
                .foregroundStyle(Color.madiiContrast)
            
            HStack {
                Text("로그아웃 하시겠어요?")
                    .madiiFont(.title2)
                    .foregroundStyle(Color.madiiStrong)
                
                Spacer()
            }
            
            HStack(spacing: 12) {
                Button {
                    logout()
                } label: {
                    HStack {
                        Spacer()
                        Text("로그아웃")
                            .madiiFont(.subTitle)
                            .foregroundStyle(Color.madiiNormal)
                        Spacer()
                    }
                    .padding(.vertical, 16)
                    .background(Color.madiiContrast)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                
                Button {
                    withoutAnimation {
                        showLogoutSheet = false
                    }
                } label: {
                    HStack {
                        Spacer()
                        Text("취소")
                            .madiiFont(.subTitle)
                            .foregroundStyle(Color.madiiContrast)
                        Spacer()
                    }
                    .padding(.vertical, 16)
                    .background(Color.madiiGreen100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                }
            }
        }
        .padding(.top, 16)
        .padding(.bottom, 40)
        .padding(.horizontal, 20)
        .background(Color.madiiElevated)
        .clipShape(RoundedRectangle(cornerRadius: 40))
    }
    
    private func logout() {
        ProfileAPI.shared.logout { isSuccess in
            if isSuccess {
                print("Success LogOut")
                
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
            } else {
                print("로그아웃 실패")
            }
        }
    }
}

