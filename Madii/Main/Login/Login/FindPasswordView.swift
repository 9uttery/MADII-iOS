//
//  FindPasswordView.swift
//  Madii
//
//  Created by Anjin on 5/2/24.
//

import SwiftUI

struct FindPasswordView: View {
    @State private var email: String = ""
    @State private var helperMessage: String = ""
    
    @State private var code: String = ""
    @State private var showVerificationCode: Bool = false
    @State private var showSendedEmailToast: Bool = false /// 이메일 전송 완료 안내 토스트
    enum CodeType { case sending, sended, wrong }
    @State private var codeType: CodeType = .sending
    var codeHelperMessage: String {
        switch codeType {
        case .sending: "이메일로 인증번호를 전송하고 있어요"
        case .sended: ""
        case .wrong: "인증번호가 일치하지 않아요"
        }
    }
    
    @State private var showResetPasswordView: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            emailTextField
                .padding(.top, 34)
            
            if showVerificationCode {
                VStack(alignment: .leading, spacing: 0) {
                    Text("인증번호를 입력해주세요")
                        .madiiFont(font: .madiiTitle, color: .white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 10)
                        .padding(.bottom, 14)
                    
                    ZStack(alignment: .bottomTrailing) {
                        MadiiTextField(placeHolder: "인증번호 6자리",
                                       text: $code, strokeColor: codeStrokeColor(codeType))
                        .textFieldHelperMessage(codeHelperMessage, color: codeStrokeColor(codeType))
                        .keyboardType(.numberPad)
                        .textInputAutocapitalization(.never)
                        .padding(.horizontal, 8)
                        
                        if codeType != .sending {
                            Button {
                                sendCode()
                            } label: {
                                Text("인증번호 재전송")
                                    .madiiFont(font: .madiiBody4, color: .gray500)
                                    .underline()
                            }
                            .padding(.horizontal, 25)
                        }
                    }
                }
                .padding(.top, 28)
            }
            
            Spacer()
            
            if showVerificationCode == false {
                Button {
                    
                } label: {
                    Text("CS 문의하기")
                        .madiiFont(font: .madiiBody3, color: .gray500)
                        .underline()
                }
                .padding(.bottom, 20)
            }
            
            if showSendedEmailToast {
                ToastMessage(title: "이메일로 인증번호가 전송되었어요")
            }
            
            if showVerificationCode == false {
                Button {
                    showVerificationCode = true
                    sendCode()
                } label: {
                    MadiiButton(title: "본인 인증하기", size: .big)
                        .opacity(true ? 1.0 : 0.4)
                }
            } else {
                Button {
                    codeType = .wrong
                    // 인증번호가 맞으면
                    showResetPasswordView = true
                } label: {
                    MadiiButton(title: "다음", size: .big)
                        .opacity(codeType != .wrong ? 1.0 : 0.4)
                }
                .navigationDestination(isPresented: $showResetPasswordView) {
                    Text("비밀번호 재설정")
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 24)
        .navigationTitle("비밀번호 찾기")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // email 텍스트필드
    private var emailTextField: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("이메일을 입력해주세요")
                .madiiFont(font: .madiiTitle, color: .white)
                .padding(10)
            
            MadiiTextField(placeHolder: "ex) maddi@happy.com", text: $email)
//                .textFieldHelperMessage(helperMessage, color: strokeColor(idType))
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .padding(.horizontal, 8)
        }
    }
    
    private func sendCode() {
        showVerificationCode = true
        codeType = .sending
        
        // 인증번호 이메일 전송
        UsersAPI.shared.sendVerificationCodeEmail(email: "") { isSuccess in
            if isSuccess {
                // 이메일 전송 성공
                codeType = .sended
                
                withAnimation { showSendedEmailToast = true }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation { showSendedEmailToast = false }
                }
            } else {
                // TODO: 이메일 전송 실패 처리
            }
        }
    }
    
    private func codeStrokeColor(_ type: CodeType) -> Color {
        switch type {
        case .sending: Color.gray700
        case .sended: Color.gray700
        case .wrong: Color.madiiOrange
        }
    }
}

#Preview {
    NavigationStack {
        FindPasswordView()
    }
}
