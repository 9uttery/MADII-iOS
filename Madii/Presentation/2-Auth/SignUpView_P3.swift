//
//  SignUpView_P3.swift
//  Madii
//
//  Created by Anjin on 12/14/25.
//

import MadiiDesignSystem
import SwiftUI

enum SignUpStep {
    case term
    case email
    case password
    case profile
}

@Observable
class SignUpViewModel {
    var loginType: LoginType
    var currentStepIndex = 0
    var signUpSteps: [SignUpStep] {
        switch loginType {
        case .kakao, .apple:
            return [.term, .profile]
        case .id:
            return [.term, .email, .password, .profile]
        }
    }
    
    // 1. 서비스 이용 동의서
    var agreeStatus: [ServiceTerm: Bool] = [
        .termOfUse: false, .privacyPolicy: false, .marketing: false
    ]
    
    // 2. 이메일
    var email: String = ""
    var emailType: EmailView_P3.EmailType = .none
    var showVerificationCode: Bool = false
    var code: String = ""
    var codeType: EmailView_P3.CodeType = .sending
    var showSendedCodeToast: Bool = false
    
    // 3. 비밀번호
    var password: String = ""
    var showCheckPassword: Bool = false
    var checkPassword: Bool = false
    
    // MARK: init
    init(loginType: LoginType) {
        self.loginType = loginType
    }
    
    func backButtonTapped() {
        let currentStep = signUpSteps[currentStepIndex]
        switch currentStep {
        case .term:
            // dismiss
            print("dismiss")
        case .email:
            resetEmailState()
            currentStepIndex -= 1
        case .password:
            currentStepIndex -= 1
        case .profile:
            currentStepIndex -= 1
        }
    }
    
    // 다음 버튼 동작
    func showNextStep() {
        let currentStep = signUpSteps[currentStepIndex]
        switch currentStep {
        case .term:
            currentStepIndex += 1
        case .email:
            hideKeyboard()
            if showVerificationCode == false {
                sendCode()
            } else {
                verifyCode()
            }
        case .password:
            if showCheckPassword == false {
                // 비밀번호 1
                showCheckPassword = true
            } else {
                // 비밀번호 2
                if checkPassword {
                    showCheckPassword = false
                    checkPassword = false
                    currentStepIndex += 1
                }
            }
        case .profile:
            print("login")
        }
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    private func resetEmailState() {
        email = ""
        emailType = .none
        showVerificationCode = false
        codeType = .sending
        showSendedCodeToast = false
    }
    
    func sendCode() {
        showVerificationCode = true
        codeType = .sending
        
        // 인증번호 이메일 전송
        UsersAPI.shared.sendVerificationCodeEmail(email: email) { isSuccess in
            if isSuccess {
                // 이메일 전송 성공
                self.codeType = .sended
                
                withAnimation { self.showSendedCodeToast = true }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    self.showSendedCodeToast = false
                }
            } else {
                // TODO: 이메일 전송 실패 처리
            }
        }
    }
    
    private func verifyCode() {
        UsersAPI.shared.verifyCode(email: email, code: code) { isSuccess in
            if isSuccess {
                self.currentStepIndex += 1
            } else {
                self.codeType = .wrong
            }
        }
    }
}

struct SignUpView_P3: View {
    @State private var viewModel: SignUpViewModel
    var currentStep: SignUpStep {
        viewModel.signUpSteps[viewModel.currentStepIndex]
    }
    
    init(loginType: LoginType) {
        viewModel = SignUpViewModel(loginType: loginType)
    }
    
    var body: some View {
        ZStack {
            Color.madiiDefault.ignoresSafeArea()
            
            VStack(spacing: 0) {
                SignUpNavigationBar()
                
                contentView(currentStep)
                    .padding(20)
                
                MadiiDesignSystem.MadiiButton(
                    title: "다음",
                    color: .mainColor,
                    action: viewModel.showNextStep
                )
                .disabled(nextButtonDisabled())
                .opacity(nextButtonDisabled() ? 0.4 : 1.0)
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
            }
        }
        .environment(viewModel)
    }
    
    @ViewBuilder
    private func contentView(_ step: SignUpStep) -> some View {
        switch step {
        case .term:
            ServiceTermView_P3()
        case .email:
            EmailView_P3()
        case .password:
            PasswordView_P3()
        case .profile:
            Text("profile")
        }
    }
    
    // true면 disable
    private func nextButtonDisabled() -> Bool {
        switch currentStep {
        case .term:
            let use = viewModel.agreeStatus[.termOfUse] ?? false
            let privacy = viewModel.agreeStatus[.privacyPolicy] ?? false
            return use && privacy ? false : true
        case .email:
            if viewModel.showVerificationCode == false {
                return viewModel.emailType == .possible ? false : true
            } else {
                if viewModel.codeType == .wrong {
                    return true
                } else {
                    return viewModel.code.count >= 6 ? false : true
                }
            }
        case .password:
            if viewModel.showCheckPassword == false {
                return isValidPassword(viewModel.password) == false
            } else {
                return viewModel.checkPassword == false
            }
        case .profile: return true
        }
    }
    
    private func isValidPassword(_ text: String) -> Bool {
        let pattern = #"^(?=.*[A-Za-z])(?=.*\d)(?=.*[!_*@])[A-Za-z\d!_*@]{8,}$"#
        return text.range(of: pattern, options: .regularExpression) != nil
    }
}

private struct SignUpNavigationBar: View {
    @Environment(SignUpViewModel.self) var viewModel
    
    var body: some View {
        HStack {
            Button {
                viewModel.backButtonTapped()
            } label: {
                Image(.arrowBack)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .colorMultiply(.madiiAlternative)
            }
            
            Spacer()
            
            let totalSteps = viewModel.signUpSteps.count
            HStack(spacing: 4) {
                ForEach(0 ..< totalSteps, id: \.self) { index in
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundStyle(
                            index == viewModel.currentStepIndex
                            ? Color.madiiAlternative
                            : Color.madiiContrast
                        )
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
    }
}

#Preview {
    SignUpView_P3(loginType: .id)
}
