//
//  EmailView_P3.swift
//  Madii
//
//  Created by Anjin on 12/23/25.
//

import Combine
import MadiiDesignSystem
import SwiftUI

struct EmailView_P3: View {
    @Environment(SignUpViewModel.self) var viewModel
    enum EmailType { case none, correct, wrong, possible, impossible }
    enum CodeType { case sending, sended, wrong }
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 60) {
                    EmailTextField()
                    
                    if viewModel.showVerificationCode {
                        CodeTextField()
                            .disabled(viewModel.isCodeVerified)
                    }
                    
                    Spacer()
                }
            }
            .scrollIndicators(.never)
            
            VStack {
                Spacer()
                
                if viewModel.showSendedCodeToast {
                    MadiiToast(
                        type: .complete,
                        title: "이메일로 인증번호가 전송되었어요",
                        isShowToast: .constant(viewModel.showSendedCodeToast)
                    )
                    .padding(.horizontal, 16)
                    .padding(.bottom, 4)
                    .transition(.move(edge: .bottom))
                }
            }
        }
    }
}

private struct EmailTextField: View {
    @Environment(SignUpViewModel.self) var viewModel
    @StateObject private var textFieldObserver = TextFieldObserver()
    private var cancellable: AnyCancellable?
    
    @State private var textFieldType: TextFieldType = .basic
    var helperMessage: String {
        switch viewModel.emailType {
        case .none, .correct: ""
        case .wrong: "올바른 이메일 형식이 아니에요"
        case .possible: "사용할 수 있는 이메일이에요"
        case .impossible: "이미 가입된 계정이에요"
        }
    }
    
    var body: some View {
        VStack(spacing: 28) {
            HStack {
                Text("이메일을 입력해 주세요")
                    .madiiFont(.title2)
                    .foregroundStyle(Color.madiiNormal)
                Spacer()
            }
            .padding(.horizontal, 4)
            
            VStack(alignment: .leading, spacing: 12) {
                MadiiDesignSystem.MadiiTextField(
                    type: $textFieldType,
                    text: $textFieldObserver.searchText,
                    placeholder: "ex) madii@happy.com"
                )
                .padding(1)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .onChange(of: textFieldObserver.searchText) { _, new in checkEmailVaild(new) }
                .onReceive(textFieldObserver.$debouncedText) { checkEmailDuplicated($0) }
                .disabled(viewModel.showVerificationCode)
                .onAppear { textFieldObserver.searchText = viewModel.email }
                
                Text(helperMessage)
                    .madiiFont(.caption)
                    .foregroundStyle(viewModel.emailType == .possible ? Color.madiiLime : Color.madiiNegative)
                    .padding(.leading, 4)
            }
        }
    }
    
    private func checkEmailVaild(_ email: String) {
        if email.isEmpty {
            viewModel.emailType = .none
            textFieldType = .basic
        } else if isValidInput(email) {
            viewModel.emailType = .correct
            textFieldType = .active
        } else {
            viewModel.emailType = .wrong
            textFieldType = .error
        }
    }
    
    private func isValidInput(_ text: String) -> Bool {
        // 정규식을 사용하여 공백 없이 대소문자 영문자 및 숫자만 허용하는지 체크
//        let pattern = "^[a-zA-Z0-9]*$"
        let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return text.range(of: pattern, options: .regularExpression) != nil
    }
    
    private func checkEmailDuplicated(_ email: String) {
        if viewModel.emailType == .correct {
            if email.isEmpty {
                viewModel.emailType = .none
            } else {
                UsersAPI.shared.getIdCheck(id: email) { isSuccess, canUseID in
                    if isSuccess && canUseID {
                        // api 통신 성공 && 아이디 사용 가능
                        viewModel.emailType = .possible
                        viewModel.email = textFieldObserver.searchText
                    } else {
                        // api 통신 오류 || 아이디 사용 불가능
                        viewModel.emailType = .impossible
                    }
                }
            }
        }
    }
}

private struct CodeTextField: View {
    @Environment(SignUpViewModel.self) var viewModel
    @State private var code: String = ""
    @State private var textFieldType: TextFieldType = .basic
    var helperMessage: String {
        if viewModel.isCodeVerified { return "인증번호가 일치해요" }
        switch viewModel.codeType {
        case .sending: return "이메일로 인증번호를 전송하고 있어요"
        case .sended: return ""
        case .wrong: return "인증번호가 일치하지 않아요"
        }
    }
    
    var body: some View {
        VStack(spacing: 28) {
            HStack {
                Text("인증번호를 입력해 주세요")
                    .madiiFont(.title2)
                    .foregroundStyle(Color.madiiNormal)
                Spacer()
            }
            .padding(.horizontal, 4)
            
            VStack(alignment: .leading, spacing: 12) {
                MadiiDesignSystem.MadiiTextField(
                    type: $textFieldType,
                    text: $code,
                    placeholder: "인증번호 6자리"
                )
                .padding(1)
                .keyboardType(.numberPad)
                .textInputAutocapitalization(.never)
                .overlay(alignment: .trailing) {
                    Button {
                        viewModel.verifyCode()
                    } label: {
                        Text("인증하기")
                            .madiiFont(.body3)
                            .foregroundStyle(code.isEmpty ? Color.madiiStrong : Color.madiiContrast)
                            .frame(height: 22)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 4)
                            .background(code.isEmpty ? Color.white.opacity(0.35) : Color.madiiGreen100)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .disabled(code.isEmpty)
                    .padding(.trailing, 12)
                }
                .onChange(of: code) { _, newValue in
                    viewModel.code = newValue
                    if viewModel.codeType == .wrong {
                        viewModel.codeType = .sended
                    }
                }
                .onChange(of: viewModel.codeType) { _, newValue in
                    textFieldType = newValue == .wrong ? .error : .basic
                }
                
                HStack {
                    Text(helperMessage)
                        .madiiFont(.caption)
                        .foregroundStyle(viewModel.codeType == .wrong ? Color.madiiNegative : Color.madiiLime)
                    
                    Spacer()
                    
                    if viewModel.codeType == .sended {
                        Button {
                            viewModel.sendCode()
                        } label: {
                            Text("인증번호 재전송")
                                .madiiFont(.body3)
                                .foregroundStyle(Color.madiiNeutral)
                                .underline()
                        }
                    }
                }
                .padding(.horizontal, 4)
            }
        }
    }
}
