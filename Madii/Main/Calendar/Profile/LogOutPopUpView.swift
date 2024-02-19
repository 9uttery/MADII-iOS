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
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.black.opacity(0.8).ignoresSafeArea()
                .onTapGesture {
                    dismissPopUp()
                }
            PopUp(title: "로그아웃 하시겠어요?", leftButtonTitle: "네", leftButtonAction: logOut, rightButtonTitle: "아니오", rightButtonColor: .white, rightButtonAction: cancleLogOut) {
                
            }
            .padding(.top, 276)
            .padding(.horizontal, 36)
        }
    }
    
    func dismissPopUp() {
        showLogOutPopUp = false
    }

    func cancleLogOut() {
        showLogOutPopUp = false
    }
    
    func logOut() {
        showLogOutPopUp = false
        keychain.clear()
        print("keychain: \(keychain.allKeys)")
    }
}

#Preview {
    LogOutPopUpView(showLogOutPopUp: .constant(true))
}
