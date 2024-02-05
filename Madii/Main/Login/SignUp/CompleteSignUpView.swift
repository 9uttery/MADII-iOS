//
//  CompleteSignUpView.swift
//  Madii
//
//  Created by 이안진 on 2/5/24.
//

import SwiftUI

struct CompleteSignUpView: View {
    @State private var showMainView: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 8) {
                Text("일상 속 행복에 한걸음 더 가까이")
                    .madiiFont(font: .madiiBody3, color: .white)
                
                Text("마디와 함께할 준비가 완료되었어요")
                    .madiiFont(font: .madiiTitle, color: .white)
            }
            .padding(.top, 124)
            .padding(.bottom, 40)
            
            Rectangle()
                .frame(height: 440)
            
            Spacer()
            
            Button {
                showMainView = true
            } label: {
                MadiiButton(title: "시작하기", color: .yellowGreen)
            }
            .navigationDestination(isPresented: $showMainView) {
                MadiiTabView().navigationBarBackButtonHidden()
            }
        }
        .padding(.horizontal, 16)
        .background(OnboardingBackgroundGradient())
    }
}

#Preview {
    CompleteSignUpView()
}
