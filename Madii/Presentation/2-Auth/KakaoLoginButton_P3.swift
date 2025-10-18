//
//  KakaoLoginButton_P3.swift
//  Madii
//
//  Created by Anjin on 10/9/25.
//

import SwiftUI

struct KakaoLoginButton_P3: View {
    @Environment(LoginViewModel.self) var viewModel
    
    var body: some View {
        Button {
            viewModel.action(.kakaoLogin)
        } label: {
            ZStack {
                Color(red: 1, green: 0.9, blue: 0)
                
                HStack {
                    Image(.kakaoLogo22)
                        .resizable()
                        .frame(width: 22, height: 22)
                    
                    Spacer()
                }
                .padding(.leading, 20)
                
                Text("카카오 로그인")
                    .madiiFont(.body1)
                    .foregroundStyle(Color.black)
            }
            .frame(height: 60)
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
}
