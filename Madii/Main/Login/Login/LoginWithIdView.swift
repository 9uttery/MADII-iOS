//
//  LoginWithIdView.swift
//  Madii
//
//  Created by 이안진 on 2/8/24.
//

import SwiftUI

struct LoginWithIdView: View {
    @State private var id: String = ""
    @State private var password: String = ""
    var isTextFieldAllFilled: Bool { id.isEmpty == false && password.isEmpty == false }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            ScrollView {
                idTextField
                    .padding(.top, 44)
                passwordTextField
            }
            .scrollIndicators(.never)
            
            Button {
                // 로그인
            } label: {
                MadiiButton(title: "다음", size: .big)
                    .opacity(isTextFieldAllFilled ? 1.0 : 0.4)
            }
            .disabled(isTextFieldAllFilled == false)
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 24)
    }
    
    // id 텍스트필드
    private var idTextField: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("아이디")
                .madiiFont(font: .madiiTitle, color: .white)
                .padding(10)
            
            MadiiTextField(placeHolder: "아이디를 입력해주세요", text: $id)
                .padding(.horizontal, 8)
        }
    }
    
    // password 텍스트필드
    private var passwordTextField: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("비밀번호")
                .madiiFont(font: .madiiTitle, color: .white)
                .padding(10)
            
            MadiiTextField(isSecureField: true, placeHolder: "비밀번호를 입력해주세요", text: $password)
                .padding(.horizontal, 8)
        }
    }
}

#Preview {
    LoginWithIdView()
}
