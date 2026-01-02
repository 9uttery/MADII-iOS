//
//  FindPasswordView_P3.swift
//  Madii
//
//  Created by 정태우 on 12/16/25.
//

import MadiiDesignSystem
import SwiftUI

struct FindPasswordView_P3: View {
    @State private var viewModel: FindPasswordViewModel
    
    init(viewModel: FindPasswordViewModel) {
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
//        ZStack {
//            Color.madiiDefault.ignoresSafeArea()
//            
//            VStack(spacing: 0) {
//                MadiiNavigationBar_P3(title: "비밀번호 찾기")
//                
//                
//                MadiiDesignSystem.MadiiButton(
//                    title: "본인 인증하기",
//                    color: .mainColor,
//                    action: viewModel.showNextStep
//                )
//                .disabled(nextButtonDisabled())
//                .opacity(nextButtonDisabled() ? 0.4 : 1.0)
//                .padding(.horizontal, 20)
//                .padding(.bottom, 30)
//            }
//        }
//        .environment(viewModel)
    }
}
