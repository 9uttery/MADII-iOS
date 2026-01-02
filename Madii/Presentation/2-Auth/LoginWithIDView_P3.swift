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
        VStack(alignment: .leading) {
            MadiiNavigationBar_P3(title: "로그인")
            
            Text("이메일")
                .madiiFont(.title2)
                .foregroundStyle(.madiiNormal)
                .padding(.top, 20)
                .padding(.bottom, 28)
            
            MadiiDesignSystem.MadiiTextField(text: $viewModel.email, placeholder: "이메일을 입력해주세요")
            
            Text("비밀번호")
                .madiiFont(.title2)
                .foregroundStyle(.madiiNormal)
                .padding(.top, 60)
                .padding(.bottom, 28)
            
            SecureField("비밀번호를 입력해주세요", text: $viewModel.password)
                .madiiFont(.body2)
                .foregroundStyle(.madiiNeutral)
                .frame(maxWidth: .infinity)
                .frame(height: 26)
                .padding(12)
                .background(.madiiGray30)
                .cornerRadius(12)
            
            Spacer()
            
            MadiiDesignSystem.MadiiButton(
                title: "다음",
                color: .mainColor,
                action: { viewModel.action(.loginWithID) }
            )
            .padding(.bottom, 10)
            .disabled(!viewModel.validate)
            .opacity(viewModel.validate ? 1: 0.3)
            
            Button {
                viewModel.action(.findPassword)
            } label: {
                Text("비밀번호 찾기")
                    .madiiFont(.body3)
                    .foregroundStyle(.madiiNeutral)
                    .underline()
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding(.horizontal, 20)
        .onChange(of: viewModel.email) {
            viewModel.action(.validateLogin)
        }
        .onChange(of: viewModel.password) {
            viewModel.action(.validateLogin)
        }
    }
}

// #Preview {
//     LoginWithIDView_P3()
// }
