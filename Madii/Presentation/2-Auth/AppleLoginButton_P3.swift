//
//  AppleLoginButton_P3.swift
//  Madii
//
//  Created by Anjin on 10/9/25.
//

import SwiftUI

struct AppleLoginButton_P3: View {
    @Environment(Router.self) var router
    
    var body: some View {
        Button {
            // TODO: 애플 로그인 구현
//            router.isLoggedIn = true
        } label: {
            ZStack {
                Color.black
                
                HStack {
                    Image(.appleLogo22)
                        .resizable()
                        .frame(width: 22, height: 22)
                    
                    Spacer()
                }
                .padding(.leading, 20)
                
                Text("Apple 로그인")
                    .madiiFont(.body1)
                    .foregroundStyle(Color.madiiNormal)
            }
            .frame(height: 60)
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
}
