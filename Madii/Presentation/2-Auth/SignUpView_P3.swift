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
    private let router: Router
    
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
    var isCodeVerified: Bool = false
    
    // 3. 비밀번호
    var password: String = ""
    var showCheckPassword: Bool = false
    var checkPassword: Bool = false
    
    // 4. 프로필
    var showProfileImageSheet: Bool = false
    var image: UIImage = UIImage(named: "defaultProfile") ?? UIImage()
    var url: String = ""
    var showImageSheet = false
    var nickname: String = ""
    var isNicknameVaild: Bool = true
    
    // MARK: init
    init(router: Router, loginType: LoginType) {
        self.router = router
        self.loginType = loginType
    }
    
    func backButtonTapped() {
        let currentStep = signUpSteps[currentStepIndex]
        switch currentStep {
        case .term:
            router.pop()
        case .email:
            resetEmailState()
            currentStepIndex -= 1
        case .password:
            showVerificationCode = false
            code = ""
            codeType = .sending
            isCodeVerified = false
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
                if isCodeVerified {
                    code = ""
                    currentStepIndex += 1
                }
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
            if isNicknameVaild {
                if loginType == .id {
                    // 일반 회원가입
                    UsersAPI.shared.signUpWithId(
                        id: email,
                        password: password,
                        agree: agreeStatus[.marketing] ?? false
                    ) { isSuccess, _ in
                        if isSuccess {
                            print("🌟 일반 회원가입 성공")
                            self.setprofile()
                        } else {
                            print("🚨 일반 회원가입 실패")
                        }
                    }
                } else {
                    // 소셜 프로필 추가
                    UsersAPI.shared.editMarketingAgree(
                        agree: agreeStatus[.marketing] ?? false
                    ) { isSuccess in
                        if isSuccess {
                            print("🌟 소셜 마케팅 동의 여부 추가 성공")
                            self.setprofile()
                        } else {
                            print("🚨 소셜 마케팅 동의 여부 추가 실패")
                        }
                    }
                }
            }
        }
    }
    
    private func setprofile() {
        ProfileAPI.shared.postUsersProfile(nickname: nickname, image: image) { isSuccess in
            if isSuccess {
                self.router.isLoggedIn = true
                self.router.popToRoot()
//                showCompleteSignUpView = true
                print("🌟 프로필 설정 성공")
            } else {
                print("🚨 프로필 설정 실패")
            }
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
        isCodeVerified = false
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
    
    func verifyCode() {
        UsersAPI.shared.verifyCode(email: email, code: code) { isSuccess in
            if isSuccess {
                withAnimation {
                    self.isCodeVerified = true
                }
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
    
    init(router: Router, loginType: LoginType) {
        viewModel = SignUpViewModel(router: router, loginType: loginType)
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
            
            if viewModel.showProfileImageSheet {
                Color.black.opacity(0.8)
                    .onTapGesture {
                        withoutAnimation {
                            viewModel.showProfileImageSheet = false
                        }
                    }
                
                VStack {
                    Spacer()
                    
                    ProfileImageSheet(
                        showProfileImageSheet: $viewModel.showProfileImageSheet,
                        image: $viewModel.image,
                        url: $viewModel.url,
                        showImageSheet: $viewModel.showImageSheet
                    )
                    .padding(.horizontal, 20)
                    .padding(.bottom, 40)
                }
                .ignoresSafeArea()
                .transition(.move(edge: .bottom))
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
            ProfileSettingView_P3(viewModel: viewModel)
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
                return viewModel.isCodeVerified == false
            }
        case .password:
            if viewModel.showCheckPassword == false {
                return isValidPassword(viewModel.password) == false
            } else {
                return viewModel.checkPassword == false
            }
        case .profile:
            return viewModel.isNicknameVaild == false || viewModel.nickname.isEmpty
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
