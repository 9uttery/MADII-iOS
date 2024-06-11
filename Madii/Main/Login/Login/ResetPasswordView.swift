//
//  ResetPasswordView.swift
//  Madii
//
//  Created by Anjin on 6/11/24.
//

import SwiftUI

struct ResetPasswordView: View {
    @State private var password: String = ""
    @State private var isValidPassword: Bool = false
    var helperMessage: String {
        if isValidPassword {
            return "사용할 수 있는 비밀번호예요"
        } else if password.isEmpty {
            return ""
        } else {
            return "영문 대소문자, 숫자 및 특수문자 !, _, *, @만 사용할 수 있어요"
        }
    }
    
    @State private var showCheckPassword: Bool = false
    @State private var reenteredPassword: String = ""
    var isPasswordSame: Bool { password == reenteredPassword }
    var reenterHelperMessage: String {
        isPasswordSame ? "비밀번호가 일치해요" : (reenteredPassword.isEmpty ? "" : "비밀번호가 일치하지 않아요")
    }
    
    @State private var showLoginView: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 28) {
                    MadiiTextField(isSecureField: true,
                                   placeHolder: "비밀번호 (8자 이상, 영문/숫자/!, _, *, @ 사용 가능)",
                                   text: $password,
                                   strokeColor: strokeColor())
                    .textFieldHelperMessage(helperMessage, color: strokeColor())
                    .textFieldLabel("비밀번호를 입력해주세요")
                    .padding(.horizontal, 25)
                    .onChange(of: password) { checkValidPassword($0) }
                    
                    if showCheckPassword {
                        MadiiTextField(isSecureField: true,
                                       placeHolder: "비밀번호 확인",
                                       text: $reenteredPassword,
                                       strokeColor: reenteredStrokeColor())
                        .textFieldHelperMessage(reenterHelperMessage, color: reenteredStrokeColor())
                        .textFieldLabel("다시 한번 비밀번호를 입력해주세요")
                        .padding(.horizontal, 25)
                    }
                }
                .padding(.vertical, 34)
            }
            
            Spacer()
            
            // 다음, 완료 버튼
            nextButton
                .padding(.horizontal, 18)
                .padding(.bottom, 24)
                .navigationDestination(isPresented: $showLoginView) {
                    LoginView()
                }
        }
        .onTapGesture { hideKeyboard() }
        .navigationTitle("비밀번호 재설정")
    }
    
    // 다음 버튼
    private var nextButton: some View {
        if showCheckPassword == false {
            Button {
                withAnimation {
                    showCheckPassword = true
                }
            } label: {
                MadiiButton(title: "다음", size: .big)
                    .opacity(isValidPassword ? 1.0 : 0.4)
            }
            .disabled(isValidPassword == false)
        } else {
            Button {
                // 비밀번호 재설정, 완료 시 로그인 화면으로
                UsersAPI.shared.resetPassword(password: password) { isSuccess in
                    if isSuccess {
                        showLoginView = true
                    }
                }
            } label: {
                MadiiButton(title: "완료", size: .big)
                    .opacity(isValidPassword && isPasswordSame ? 1.0 : 0.4)
            }
            .disabled((isValidPassword == false) || (isPasswordSame == false))
        }
    }
    
    private func checkValidPassword(_ password: String) {
//        let passwordRegEx = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[~!_@#$%^&*+=])[A-Za-z0-9~!_@#$%^&*+=]{8,}$"
        let passwordRegEx = "^[A-Za-z0-9!_@*]{8,}$"

        let passwordPred = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        isValidPassword = passwordPred.evaluate(with: password)
    }
    
    private func strokeColor() -> Color {
        if password.isEmpty {
            return Color.gray500
        } else if isValidPassword {
            return Color.madiiYellowGreen
        } else {
            return Color.madiiOrange
        }
    }
    
    private func reenteredStrokeColor() -> Color {
        if reenteredPassword.isEmpty {
            return Color.gray500
        } else if isPasswordSame {
            return Color.madiiYellowGreen
        } else {
            return Color.madiiOrange
        }
    }
}

#Preview {
    ResetPasswordView()
}
