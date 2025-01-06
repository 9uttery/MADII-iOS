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
            ScrollView {
                VStack(spacing: 0) {
                    emailTextField
                    
                    if showVerificationCode {
                        codeTextField
                    }
                }
                .padding(.vertical, 34)
            }
            
            Spacer()
            
            // 이메일 전송 완료 토스트 메시지
            if showSendedEmailToast {
                ToastMessage(title: "이메일로 인증번호가 전송되었어요")
            }
            
            // TODO: CS 문의하기 버튼
            NavigationLink {
                InquiryView()
            } label: {
                Text("CS 문의하기")
                    .madiiFont(font: .madiiBody3, color: .gray500)
                    .underline()
            }
            .padding(.bottom, 20)
            
            if showVerificationCode == false {
                // 본인 인증하기 버튼
                Button {
                    verificate()
                } label: {
                    MadiiButton(title: "본인 인증하기", color: .white, size: .big)
                        .opacity(email.isEmpty ? 0.4 : 1.0)
                        .disabled(email.isEmpty)
                }
            } else {
                // 인증번호 확인 버튼
                Button {
                    verifyCode()
                } label: {
                    MadiiButton(title: "다음", size: .big)
                        .opacity(codeType != .wrong ? 1.0 : 0.4)
                }
                .disabled(codeType == .wrong)
                .onChange(of: code) { _ in codeType = .sended }
                .navigationDestination(isPresented: $showResetPasswordView) {
                    ResetPasswordView(email: email)
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
        MadiiTextField(placeHolder: "ex) madii@happy.com",
                       text: $email,
                       strokeColor: helperMessage.isEmpty ? .gray700 : .madiiOrange)
            .textFieldLabel("이메일을 입력해주세요")
            .textFieldHelperMessage(helperMessage,
                                    color: helperMessage.isEmpty ? .gray700 : .madiiOrange)
            .keyboardType(.emailAddress)
            .textInputAutocapitalization(.never)
            .padding(.horizontal, 8)
            .disabled(showVerificationCode)
            .onChange(of: email) { _ in
                if helperMessage.isEmpty  == false {
                    helperMessage = ""
                }
            }
    }
    
    private var codeTextField: some View {
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
                        withAnimation {
                            verificate()
                        }
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
}

// methods
extension FindPasswordView {
    // 본인 인증하기
    private func verificate() {
        hideKeyboard()
        
        UsersAPI.shared.getIdCheck(id: email) { isSuccess, canUseID in
            if isSuccess {
                // canUseID == false 면, 아이디 있음 "존재"
                if canUseID == false {
                    withAnimation {
                        showVerificationCode = true
                    }
                    codeType = .sending
                    sendCode()
                } else { // canUseID == true 면, 아이디 없음
                    showVerificationCode = false
                    helperMessage = "존재하지 않는 계정이에요. 이메일을 다시 확인해주세요."
                }
            }
        }
    }
    
    private func sendCode() {
        let endpoint = AuthAPI().signUp
            .sendVerificationCodeToEmail(
                email: email,
                forSignUp: false
            )
        
        endpoint.request { request in
            switch request {
            case .success:
                // 이메일 전송 성공
                codeType = .sended
                
                withAnimation { showSendedEmailToast = true }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation { showSendedEmailToast = false }
                }
            case .failure:
                // 이메일 전송 실패 처리
                print("DEBUG \(#function): result false")
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
    
    // 인증 번호 확인하기
    private func verifyCode() {
        UsersAPI.shared.verifyCode(email: email, code: code) { isSuccess in
            if isSuccess {
                // 인증번호가 맞으면
                showResetPasswordView = true
            } else {
                codeType = .wrong
            }
        }
    }
}

#Preview {
    NavigationStack {
        FindPasswordView()
    }
}
