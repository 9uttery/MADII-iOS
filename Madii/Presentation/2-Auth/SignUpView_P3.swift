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
    var currentStepIndex = 1
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
    
    init(loginType: LoginType) {
        self.loginType = loginType
    }
    
    func backButtonTapped() {
        if currentStepIndex > 0 {
            currentStepIndex -= 1
        }
    }
    
    func showNextStep() {
        if currentStepIndex < signUpSteps.count - 1 {
            currentStepIndex += 1
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
            Text("password")
        case .profile:
            Text("profile")
        }
    }
    
    private func nextButtonDisabled() -> Bool {
        switch currentStep {
        case .term:
            let use = viewModel.agreeStatus[.termOfUse] ?? false
            let privacy = viewModel.agreeStatus[.privacyPolicy] ?? false
            return use && privacy ? false : true
        case .email: return true
        case .password: return true
        case .profile: return true
        }
    }
}

struct EmailView_P3: View {
    @State private var email: String = ""
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                VStack(spacing: 28) {
                    HStack {
                        Text("이메일을 입력해 주세요")
                            .madiiFont(.title2)
                            .foregroundStyle(Color.madiiNormal)
                        Spacer()
                    }
                    .padding(.horizontal, 4)
                    
                    MadiiDesignSystem.MadiiTextField(
                        type: .constant(.error),
                        text: $email,
                        placeholder: "ex) madii@happy.com"
                    )
                }
                
                Spacer()
            }
        }
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
