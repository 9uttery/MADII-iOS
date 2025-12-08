//
//  ProfileView_P3.swift
//  Madii
//
//  Created by Anjin on 12/8/25.
//

import MadiiDesignSystem
import PhotosUI
import SwiftUI

struct ProfileView_P3: View {
    @Environment(Router.self) var router
    
    @State private var showProfileImageSheet: Bool = false
    @State private var image: UIImage = UIImage(named: "defaultProfile") ?? UIImage()
    @State private var url: String = ""
    @State private var showImageSheet = false
    
    @State private var nickname: String = ""
    @State private var isNicknameVaild: Bool = true
    
    var body: some View {
        ZStack {
            Color.madiiDefault.ignoresSafeArea()
                .onTapGesture { hideKeyboard() }
            
            VStack(spacing: 0) {
                MyPageNavigationBar(title: "프로필")
                
                VStack {
                    VStack(spacing: 40) {
                        // 프로필 이미지
                        ProfileImageView(
                            showProfileImageSheet: $showProfileImageSheet,
                            image: $image,
                            url: $url
                        )
                        .sheet(isPresented: $showImageSheet) {
                            ImagePicker(
                                sourceType: .photoLibrary,
                                selectedImage: self.$image
                            )
                        }
                        
                        // 닉네임 텍스트필드
                        NicknameTextField(
                            nickname: $nickname,
                            isNicknameVaild: $isNicknameVaild
                        )
                    }
                    
                    Spacer()
                    
                    // 저장버튼
                    MadiiDesignSystem.MadiiButton(
                        title: "저장하기",
                        color: .mainColor,
                        type: .large,
                        action: saveProfile
                    )
                    .opacity(isNicknameVaild ? 1.0 : 0.4)
                    .disabled(isNicknameVaild == false)
                    .padding(.bottom, 10)
                }
                .padding(20)
            }
            
            if showProfileImageSheet {
                Color.black.opacity(0.8)
                    .onTapGesture {
                        withoutAnimation {
                            showProfileImageSheet = false
                        }
                    }
                
                VStack {
                    Spacer()
                    
                    ProfileImageSheet(
                        showProfileImageSheet: $showProfileImageSheet,
                        image: $image,
                        url: $url,
                        showImageSheet: $showImageSheet
                    )
                        .padding(.horizontal, 20)
                        .padding(.bottom, 40)
                }
                .ignoresSafeArea()
                .transition(.move(edge: .bottom))
            }
        }
        .onAppear { getUser() }
    }
    
    private func getUser() {
        ProfileAPI.shared.getUsersProfile { isSuccess, userProfile in
            if isSuccess {
                nickname = userProfile.nickname
                url = userProfile.image
            } else {
                print("DEBUG ProfileView isSuccess false")
            }
        }
    }
    
    private func saveProfile() {
        AnalyticsManager.shared.logEvent(name: "프로필뷰_저장클릭")
        if image == UIImage(named: "defaultProfile") {
            ProfileAPI.shared.postUsersProfileWithImageUrl(nickname: nickname, imageUrl: url) { isSuccess in
                if isSuccess {
                    print("프로필 수정이 정상적으로 처리되었습니다.")
                    router.pop()
                }
            }
        } else {
            ProfileAPI.shared.postUsersProfile(nickname: nickname, image: image) { isSuccess in
                if isSuccess {
                    print("프로필 수정이 정상적으로 처리되었습니다.")
                    router.pop()
                }
            }
        }
    }
}

private struct ProfileImageView: View {
    @Binding var showProfileImageSheet: Bool
    @Binding var image: UIImage
    @Binding var url: String
    
    var body: some View {
        Button {
            withAnimation {
                self.showProfileImageSheet = true
            }
            AnalyticsManager.shared.logEvent(name: "프로필뷰_프로필이미지클릭")
        } label: {
            if image == UIImage(named: "defaultProfile") {
                AsyncImage(url: URL(string: url)) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 140, height: 140)
                        .clipShape(Circle())
                } placeholder: {
                    Image("defaultProfile")
                        .resizable()
                        .frame(width: 140, height: 140)
                }
            } else {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 140, height: 140)
                    .cornerRadius(140)
            }
        }
    }
}

private struct ProfileImageSheet: View {
    @Binding var showProfileImageSheet: Bool
    @Binding var image: UIImage
    @Binding var url: String
    @Binding var showImageSheet: Bool
    
    var body: some View {
        VStack(spacing: 40) {
            RoundedRectangle(cornerRadius: 100)
                .frame(width: 100, height: 5)
                .foregroundStyle(Color.madiiContrast)
            
            VStack(spacing: 12) {
                MadiiDesignSystem.MadiiButton(
                    title: "라이브러리에서 선택하기",
                    color: .mainColor,
                    type: .large,
                    action: showImageLibrary
                )
                
                MadiiDesignSystem.MadiiButton(
                    title: "삭제하기",
                    color: .neutral,
                    type: .large,
                    action: deleteProfileImage
                )
            }
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 20)
        .background(Color.madiiElevated)
        .clipShape(RoundedRectangle(cornerRadius: 40))
    }
    
    private func showImageLibrary() {
        let status = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        if status == .notDetermined {
            print("notDetermined")
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                DispatchQueue.main.async {
                    self.showPhotoLibrary(status: status)
                }
            }
        } else {
            showPhotoLibrary(status: status)
        }
        AnalyticsManager.shared.logEvent(name: "프로필뷰_라이브러리에서선택클릭")
    }
    
    private func showPhotoLibrary(status: PHAuthorizationStatus) {
        Task {
            await MainActor.run {
                showProfileImageSheet = false
                
                if status == .authorized {
                    print("허용")
                    showImageSheet = true
                } else if status == .limited {
                    print("제한")
                    showImageSheet = true
                } else {
                    print("거부")
                }
            }
        }
    }
    
    private func deleteProfileImage() {
        url = "https://\(Bundle.main.infoDictionary?["DEFAULT_PROFILE_IMAGE_URL"] ?? "nil default profile image url")"
        image = UIImage(named: "defaultProfile") ?? UIImage()
        showProfileImageSheet = false
        AnalyticsManager.shared.logEvent(name: "프로필뷰_현재사진삭제클릭")
    }
}

private struct NicknameTextField: View {
    @Binding var nickname: String
    @Binding var isNicknameVaild: Bool
    
    var body: some View {
        VStack(spacing: 12) {
            MadiiDesignSystem.MadiiTextField(
                text: $nickname, placeholder: "닉네임"
            )
            .overlay(alignment: .trailing) {
                Text("\(nickname.count)/10")
                    .madiiFont(.body2)
                    .foregroundStyle(Color.madiiAlternative)
                    .padding(.trailing, 12)
            }
            .onChange(of: self.nickname) { checkValidNickname() }
            .onChange(of: self.nickname) { _, newValue in
                if newValue.count > 10 {
                    nickname = String(newValue.prefix(10))
                }
            }
            
            HStack {
                Text("한글/영문/숫자만 입력할 수 있어요")
                    .madiiFont(.caption)
                    .foregroundStyle(isNicknameVaild ? Color.madiiNeutral : Color.madiiNegative)
                
                Spacer()
            }
            .padding(.horizontal, 4)
        }
    }
    
    private func checkValidNickname() {
        let nicknameRegEx = "^[가-힣a-zA-Z0-9]*$"
        let nicknamePred = NSPredicate(format: "SELF MATCHES %@", nicknameRegEx)
        self.isNicknameVaild = nicknamePred.evaluate(with: nickname)
        if nickname.isEmpty { self.isNicknameVaild = false }
    }
}
