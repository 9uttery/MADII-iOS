//
//  LoginWithIdView.swift
//  Madii
//
//  Created by 이안진 on 2/8/24.
//

import SwiftUI

enum LoginError {
    case nonexistence, wrongPassword
}

struct LoginWithIdView: View {
    @AppStorage("isLoggedIn") var isLoggedIn = false
    
    @State private var id: String = ""
    @State private var password: String = ""
    var isTextFieldAllFilled: Bool { id.isEmpty == false && password.isEmpty == false }
    
    @State private var showMainView: Bool = false
    
    @State private var loginError: LoginError?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            ScrollView {
                idTextField
                    .padding(.top, 44)
                passwordTextField
            }
            .scrollIndicators(.never)
            
            VStack(spacing: 0) {
                if let error = loginError {
                    switch error {
                    case .nonexistence:
                        ToastMessage(title: "존재하지 않는 계정이에요. 이메일을 다시 확인해주세요.", color: .orange)
                    case .wrongPassword:
                        ToastMessage(title: "비밀번호가 일치하지 않아요. 다시 확인해주세요.", color: .orange)
                    }
                }
                
                Button {
                    // 로그인
                    login()
                    AnalyticsManager.shared.logEvent(name: "이메일로로그인뷰_로그인클릭")
                } label: {
                    MadiiButton(title: "다음", size: .big)
                        .opacity(isTextFieldAllFilled ? 1.0 : 0.4)
                }
                .disabled(isTextFieldAllFilled == false)
                .navigationDestination(isPresented: $showMainView) {
                    MadiiTabView().navigationBarBackButtonHidden() }
            }
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 24)
        .onTapGesture { hideKeyboard() }
        .analyticsScreen(name: "이메일로 로그인뷰")
    }
    
    // id 텍스트필드
    private var idTextField: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("이메일")
                .madiiFont(font: .madiiTitle, color: .white)
                .padding(10)
            
            MadiiTextField(placeHolder: "이메일을 입력해주세요", text: $id)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
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
    
    // 로그인
    private func login() {
        UsersAPI.shared.loginWithId(id: id, password: password) { isSuccess, error, response in
            if isSuccess {
                // api 통신 성공
                if response.hasProfile {
                    // 프로필 저장 완료 -> 메인 화면으로
                    showMainView = true
                    isLoggedIn = true
                } else {
                    // 프로필 저장 전 -> 프로필 설정 화면으로
                    print("DEBUG(LoginWithIdView): login() hasProfile false")
                }
            } else {
                withAnimation { loginError = error }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation { loginError = nil }
                }
                
                // api 통신 실패 || 계정 정보 없음
                print("DEBUG(LoginWithIdView): login() isSuccess false")
            }
        }
    }
}

#Preview {
    LoginWithIdView()
}
