//
//  MyProfileView.swift
//  Madii
//
//  Created by 정태우 on 1/25/24.
//

import PhotosUI
import SwiftUI

struct MyProfileView: View {
    @State private var image = UIImage(named: "defaultProfile") ?? UIImage()
    @Environment(\.presentationMode) var presentationMode
    @State private var showImageSheet = false
    @State private var showProfileImageSheet: Bool = false
    @Binding var url: String
    @State var nickname: String = ""
    @State private var isNicknameVaild: Bool = true
    private var helperMessage: String {
        self.isNicknameVaild ? "사용할 수 있는 닉네임이에요." : "대소문자 영문 및 한글, 숫자만 사용 가능해요."
    }
    @Binding var name: String
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 24) {
                    Button {
                        self.showProfileImageSheet = true
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
                    .sheet(isPresented: self.$showProfileImageSheet) {
                        VStack(spacing: 0) {
                            Button {
                                let status = PHPhotoLibrary.authorizationStatus(for: .readWrite)
                                if status == .notDetermined {
                                    print("notDetermined")
                                    PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                                        showPhotoLibrary(status: status)
                                    }
                                } else {
                                    showPhotoLibrary(status: status)
                                }
                            } label: {
                                HStack {
                                    Text("라이브러리에서 선택")
                                        .madiiFont(font: .madiiBody2, color: .white)
                                    Spacer()
                                }
                                .padding(.horizontal, 16)
                                .frame(height: 50)
                            }
                            
                            Button {
                                url = "https://\(Bundle.main.infoDictionary?["DEFAULT_PROFILE_IMAGE_URL"] ?? "nil default profile image url")"
                                image = UIImage(named: "defaultProfile") ?? UIImage()
                                showProfileImageSheet = false
                            } label: {
                                HStack {
                                    Text("현재 사진 삭제")
                                        .madiiFont(font: .madiiBody2, color: .white)
                                    Spacer()
                                }
                                .padding(.horizontal, 16)
                                .frame(height: 50)
                            }
                            
                            Spacer()
                        }
                        .padding(.top, 60)
                        .background(Color.madiiPopUp)
                        .presentationDetents([.height(180)])
                        .presentationDragIndicator(.visible)
                    }
                    .sheet(isPresented: $showImageSheet) {
                        // Pick an image from the photo library:
                        ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
                        
                        //  If you wish to take a photo from camera instead:
                        // ImagePicker(sourceType: .camera, selectedImage: self.$image)
                    }
                    
                    if name == nickname {
                        MadiiTextField(placeHolder: "닉네임을 입력해주세요", text: self.$nickname)
                    } else {
                        MadiiTextField(placeHolder: "닉네임을 입력해주세요", text: self.$nickname,
                                       strokeColor: self.strokeColor(), limit: 10)
                        .textFieldHelperMessage(self.helperMessage, color: self.strokeColor())
                        .onChange(of: self.nickname) { self.checkValidNickname($0) }
                    }
                }
                .padding(.top, 28)
                .padding(.horizontal, 24)
                .padding(.bottom, 20)
            }
            .scrollIndicators(.never)
            
            Spacer()
            
            Button {
                if image == UIImage(named: "defaultProfile") {
                    ProfileAPI.shared.postUsersProfileWithImageUrl(nickname: nickname, imageUrl: url) { isSuccess in
                        if isSuccess {
                            print("프로필 수정이 정상적으로 처리되었습니다.")
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                } else {
                    ProfileAPI.shared.postUsersProfile(nickname: nickname, image: image) { isSuccess in
                        if isSuccess {
                            print("프로필 수정이 정상적으로 처리되었습니다.")
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
            } label: {
                MadiiButton(title: "저장", color: nickname.isEmpty || isNicknameVaild == false ? .gray : .white)
            }
            .disabled(nickname.isEmpty || isNicknameVaild == false)
            .padding(.bottom, 24)
            .padding(.horizontal, 16)
        }
        .navigationTitle("프로필")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color.madiiBox, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
    
    private func showPhotoLibrary(status: PHAuthorizationStatus) {
        showProfileImageSheet = false
        
        if status == .authorized {
            print("허용")
            showImageSheet.toggle()
        } else if status == .limited {
            print("제한")
            showImageSheet.toggle()
        } else {
            print("거부")
        }
    }
    
    private func checkValidNickname(_ nickname: String) {
        let nicknameRegEx = "^[가-힣a-zA-Z0-9]*$"
        let nicknamePred = NSPredicate(format: "SELF MATCHES %@", nicknameRegEx)
        self.isNicknameVaild = nicknamePred.evaluate(with: nickname)
        if nickname.isEmpty { self.isNicknameVaild = false }
    }
    
    private func strokeColor() -> Color {
        if self.nickname.isEmpty {
            return Color.gray500
        } else if self.isNicknameVaild {
            return Color.madiiYellowGreen
        } else {
            return Color.madiiOrange
        }
    }
}
