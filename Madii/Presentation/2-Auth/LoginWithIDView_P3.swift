//
//  LoginWithIDView.swift
//  Madii
//
//  Created by 정태우 on 12/16/25.
//

import MadiiDesignSystem
import SwiftUI

struct LoginWithIDView_P3: View {
    @State private var viewModel: LoginWithIDViewModel

    init(viewModel: LoginWithIDViewModel) {
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            MadiiNavigationBar_P3(title: "로그인")
            
            ZStack(alignment: .bottom) {
                ScrollView {
                    VStack(alignment: .leading, spacing: 28) {
                        Text("이메일")
                            .madiiFont(.title2)
                            .foregroundStyle(Color.madiiNormal)
                            .padding(.leading, 4)
                        
                        MadiiDesignSystem.MadiiTextField(
                            text: $viewModel.email,
                            placeholder: "이메일을 입력해주세요"
                        )
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                    }
                    .padding(.bottom, 60)
                    
                    VStack(alignment: .leading, spacing: 28) {
                        Text("비밀번호")
                            .madiiFont(.title2)
                            .foregroundStyle(Color.madiiNormal)
                            .padding(.leading, 4)
                        
                        SecureField("비밀번호를 입력해주세요", text: $viewModel.password)
                            .madiiFont(.body2)
                            .foregroundStyle(.madiiNeutral)
                            .frame(maxWidth: .infinity)
                            .frame(height: 26)
                            .padding(12)
                            .background(.madiiGray30)
                            .cornerRadius(12)
                    }
                }
                .padding(.horizontal, 20)
                .scrollIndicators(.never)
                
                // 로그인 에러 토스트
                if let error = viewModel.loginError {
                    MadiiDesignSystem.MadiiToast(
                        type: .error,
                        title: error.description,
                        isShowToast: .constant(viewModel.loginError != nil)
                    )
                    .transition(.move(edge: .bottom))
                }
            }
            
            VStack(spacing: 10) {
                MadiiDesignSystem.MadiiButton(
                    title: "다음",
                    color: .mainColor,
                    action: {
                        hideKeyboard()
                        viewModel.action(.loginWithID)
                    }
                )
                .padding(.horizontal, 20)
                .disabled(!viewModel.validate)
                .opacity(viewModel.validate ? 1: 0.3)
                
                /*
                Button {
                    viewModel.action(.findPassword)
                } label: {
                    Text("비밀번호 찾기")
                        .madiiFont(font: .madiiBody3, color: .madiiNeutral)
                        .underline()
                }
                .frame(maxWidth: .infinity, alignment: .center)
                 */
            }
            .padding(.bottom, 14)
        }
        .onChange(of: viewModel.email) { viewModel.action(.validateLogin) }
        .onChange(of: viewModel.password) { viewModel.action(.validateLogin) }
    }
}
