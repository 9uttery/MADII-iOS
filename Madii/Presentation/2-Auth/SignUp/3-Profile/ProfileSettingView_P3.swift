//
//  ProfileSettingView_P3.swift
//  Madii
//
//  Created by Anjin on 12/29/25.
//

import SwiftUI

struct ProfileSettingView_P3: View {
    @Bindable var viewModel: SignUpViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 60) {
                HStack {
                    Text("시작 전, 프로필을 완성해 보세요")
                        .madiiFont(.title2)
                        .foregroundStyle(Color.madiiNormal)
                    Spacer()
                }
                .padding(.horizontal, 4)
                
                // 프로필 사진
                ProfileImageView(
                    showProfileImageSheet: $viewModel.showProfileImageSheet,
                    image: $viewModel.image,
                    url: $viewModel.url
                )
                .sheet(isPresented: $viewModel.showImageSheet) {
                    ImagePicker(
                        sourceType: .photoLibrary,
                        selectedImage: self.$viewModel.image
                    )
                }
                
                // 닉네임 필드
                NicknameTextField(
                    nickname: $viewModel.nickname,
                    isNicknameVaild: $viewModel.isNicknameVaild
                )
            }
        }
        .scrollIndicators(.never)
        .onTapGesture {
            hideKeyboard()
        }
    }
}
