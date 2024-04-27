//
//  PasswordView.swift
//  Madii
//
//  Created by 이안진 on 1/29/24.
//

import SwiftUI

struct PasswordView: View {
    @AppStorage("hasEverLoggedIn") var hasEverLoggedIn = false
    @EnvironmentObject private var signUpStatus: SignUpStatus
    
    @State private var password: String = ""
    @State private var isValidPassword: Bool = false
    var helperMessage: String {
        if isValidPassword {
            return "사용할 수 있는 비밀번호예요"
        } else {
            return "영문 대소문자, 숫자 및 특수문자 !, _, *, @만 사용할 수 있어요"
        }
    }
    
    @State private var showCheckPassword: Bool = false
    @State private var reenteredPassword: String = ""
    var isPasswordSame: Bool { password == reenteredPassword }
    var reenterHelperMessage: String {
        isPasswordSame ? "비밀번호가 일치해요." : "비밀번호가 일치하지 않아요"
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    Text("비밀번호를 입력해 주세요")
                        .madiiFont(font: .madiiTitle, color: .white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 10)
                        .padding(.bottom, 14)
                        .padding(.horizontal, 18)
                    
                    MadiiTextField(isSecureField: true, placeHolder: "비밀번호를 입력하세요",
                                   text: $password, strokeColor: strokeColor())
                    .textFieldHelperMessage(helperMessage, color: strokeColor())
                    .padding(.horizontal, 25)
                    .onChange(of: password) { checkValidPassword($0) }
                    .padding(.bottom, 28)
                    
                    if showCheckPassword {
                        Text("다시 한 번 비밀번호를 입력해 주세요")
                            .madiiFont(font: .madiiTitle, color: .white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 10)
                            .padding(.bottom, 14)
                            .padding(.horizontal, 18)
                        
                        MadiiTextField(isSecureField: true, placeHolder: "비밀번호를 입력하세요",
                                       text: $reenteredPassword, strokeColor: reenteredStrokeColor())
                        .textFieldHelperMessage(reenterHelperMessage, color: reenteredStrokeColor())
                        .padding(.horizontal, 25)
                    }
                }
                .padding(.top, 34)
                .padding(.bottom, 24)
            }
            .scrollIndicators(.never)
            .padding(.top, 60)
            
            Spacer()
            
            nextButton
                .padding(.horizontal, 18)
                .padding(.bottom, 24)
        }
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
                signUp()
            } label: {
                MadiiButton(title: "다음", size: .big)
                    .opacity(isValidPassword && isPasswordSame ? 1.0 : 0.4)
            }
            .disabled((isValidPassword == false) || (isPasswordSame == false))
        }
    }
    
    private func signUp() {
        // 일반 회원가입
        UsersAPI.shared.signUpWithId(id: signUpStatus.id, password: password,
                                     agree: signUpStatus.marketingAgreed) { isSuccess, _ in
            if isSuccess {
                print("DEBUG PasswordView: signup isSuccess true")
                hasEverLoggedIn = true
                signUpStatus.count += 1
            } else {
                print("DEBUG PasswordView: signup isSuccess false")
            }
        }
    }
    
    private func checkValidPassword(_ password: String) {
        let passwordRegEx = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[~!_@#$%^&*+=])[A-Za-z0-9~!_@#$%^&*+=]{8,}$"
//        let passwordRegEx = "^[A-Za-z0-9!_@*]{8,}$"

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
    PasswordView()
}
