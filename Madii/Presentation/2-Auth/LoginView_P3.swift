//
//  LoginView_P3.swift
//  Madii
//
//  Created by Anjin on 9/27/25.
//

import SwiftUI

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
