//
//  LogOutPopUpView.swift
//  Madii
//
//  Created by 정태우 on 1/26/24.
//

import KeychainSwift
import SwiftUI

struct LogOutPopUpView: View {
    let keychain = KeychainSwift()
    @Binding var showLogOutPopUp: Bool
    @State private var showSplash: Bool = false
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.black.opacity(0.8).ignoresSafeArea()
                .onTapGesture { dismissPopUp() }
            
            PopUp(title: "로그아웃하시겠어요?", leftButtonTitle: "네", leftButtonAction: logOut, rightButtonTitle: "아니오", rightButtonColor: .white, rightButtonAction: dismissPopUp) { }
                .padding(.top, 276)
                .padding(.horizontal, 36)
        }
        .navigationDestination(isPresented: $showSplash) {
            SplashView(fromLogout: true).navigationBarBackButtonHidden()
        }
    }
    
    func dismissPopUp() {
        showLogOutPopUp = false
    }
    
    func logOut() {
        showSplash = true
        
        ProfileAPI.shared.logout { isSuccess in
            if isSuccess {
                print("Success LogOut")
                
                DispatchQueue.global().async {
                    // UserDefaults 삭제
                    for key in UserDefaults.standard.dictionaryRepresentation().keys {
                        UserDefaults.standard.removeObject(forKey: key.description)
                    }
                    
                    UserDefaults.standard.set(true, forKey: "hasEverLoggedIn")
                    
                    // 키체인 삭제
                    keychain.clear()
                    
                    print("삭제 완료")
                }
            } else {
                print("로그아웃 실패")
            }
        }
    }
}

#Preview {
    LogOutPopUpView(showLogOutPopUp: .constant(true))
}
