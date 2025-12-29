//
//  PasswordView_P3.swift
//  Madii
//
//  Created by Anjin on 12/29/25.
//

import MadiiDesignSystem
import SwiftUI

struct PasswordView_P3: View {
    @Environment(SignUpViewModel.self) var viewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 60) {
                PasswordTextFieldView()
                
                if viewModel.showCheckPassword {
                    CheckPasswordView()
                }
            }
        }
        .scrollIndicators(.never)
    }
}

private struct PasswordTextFieldView: View {
    @Environment(SignUpViewModel.self) var viewModel
    @State private var passwordTextFieldType: TextFieldType = .basic
    @State private var password: String = ""
    private var helperMessage: String {
        if password.isEmpty || isValidPassword(password) == false {
            return "영문자/숫자/특수문자(!, _, *, @)를 포함하여 최소 8자 이상 작성해야 해요"
        } else {
            return "사용할 수 있는 비밀번호예요"
        }
    }
    
    var body: some View {
        VStack(spacing: 28) {
            HStack {
                Text("비밀번호를 입력해 주세요")
                    .madiiFont(.title2)
                    .foregroundStyle(Color.madiiNormal)
                Spacer()
            }
            .padding(.horizontal, 4)
            
            VStack(alignment: .leading, spacing: 12) {
                MadiiDesignSystem.MadiiTextField(
                    type: $passwordTextFieldType,
                    text: $password,
                    placeholder: "비밀번호",
                    isSecureTextField: true
                )
                .padding(1)
                .textInputAutocapitalization(.never)
                .onChange(of: password) { _, newValue in
                    viewModel.password = newValue
                    checkValidatePassword()
                }
                .disabled(viewModel.showCheckPassword)
                
                Text(helperMessage)
                    .madiiFont(.caption)
                    .foregroundStyle(passworedHelperMessageColor())
                    .padding(.leading, 4)
            }
        }
    }
    
    private func passworedHelperMessageColor() -> Color {
        if password.isEmpty {
            return Color.madiiNeutral
        } else {
            return isValidPassword(password) ? Color.madiiLime : Color.madiiNegative
        }
    }
    
    private func checkValidatePassword() {
        if isValidPassword(password) {
            passwordTextFieldType = .basic
        } else {
            passwordTextFieldType = .error
        }
    }
    
    private func isValidPassword(_ text: String) -> Bool {
        let pattern = #"^(?=.*[A-Za-z])(?=.*\d)(?=.*[!_*@])[A-Za-z\d!_*@]{8,}$"#
        return text.range(of: pattern, options: .regularExpression) != nil
    }
}

private struct CheckPasswordView: View {
    @Environment(SignUpViewModel.self) var viewModel
    @State private var reenteredPassword: String = ""
    @State private var textFieldType: TextFieldType = .basic
    @State private var helperMessage: String = ""
    
    var body: some View {
        VStack(spacing: 28) {
            HStack {
                Text("다시 한 번 비밀번호를 입력해 주세요")
                    .madiiFont(.title2)
                    .foregroundStyle(Color.madiiNormal)
                Spacer()
            }
            .padding(.horizontal, 4)
            
            VStack(alignment: .leading, spacing: 12) {
                MadiiDesignSystem.MadiiTextField(
                    type: $textFieldType,
                    text: $reenteredPassword,
                    placeholder: "비밀번호 확인",
                    isSecureTextField: true
                )
                .padding(1)
                .textInputAutocapitalization(.never)
                .onChange(of: reenteredPassword) { _, _ in
                    checkPassword()
                }
                
                Text(helperMessage)
                    .madiiFont(.caption)
                    .foregroundStyle(reenteredPassword == viewModel.password ? Color.madiiLime : Color.madiiNegative)
                    .padding(.leading, 4)
            }
        }
    }
    
    private func checkPassword() {
        if reenteredPassword == viewModel.password {
            textFieldType = .basic
            helperMessage = "비밀번호가 일치해요"
            viewModel.checkPassword = true
        } else {
            textFieldType = .error
            helperMessage = "비밀번호가 일치하지 않아요"
            viewModel.checkPassword = false
        }
    }
}
