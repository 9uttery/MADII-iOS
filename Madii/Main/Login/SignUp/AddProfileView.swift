//
//  AddProfileView.swift
//  Madii
//
//  Created by 이안진 on 2/2/24.
//

import PhotosUI
import SwiftUI

struct AddProfileView: View {
    let from: LoginType
    @AppStorage("isLoggedIn") var isLoggedIn = false
    @StateObject var signUpStatus = SignUpStatus()
    
    @State private var image = UIImage(named: "defaultProfile") ?? UIImage()
    @State private var showImageSheet = false
    
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var profileImage: Image?
    @State private var showProfileImageSheet: Bool = false

    @State private var nickname: String = ""
    @State private var isNicknameVaild: Bool = false
    private var helperMessage: String {
        self.isNicknameVaild ? "사용할 수 있는 닉네임이에요." : "대소문자 영문 및 한글, 숫자만 사용 가능해요."
    }
    
    @State private var showCompleteSignUpView: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ScrollView {
                VStack(spacing: 24) {
                    HStack {
                        Text("시작 전 프로필을 완성해보세요")
                            .madiiFont(font: .madiiTitle, color: .white)
                            .padding(.vertical, 10)
                            .padding(.bottom, 12)
                        
                        Spacer()
                    }
                    
                    Button {
                        self.showProfileImageSheet = true
                    } label: {
                        //                    if let image = profileImage {
                        //                        image
                        //                            .resizable()
                        //                            .frame(width: 140, height: 140)
                        //                            .scaledToFill()
                        //                            .cornerRadius(200)
                        //                    } else {
                        //                        Image("defaultProfile")
                        //                            .frame(width: 140, height: 140)
                        //                    }
                        if image == UIImage() {
                            Image("defaultProfile")
                                .frame(width: 140, height: 140)
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
                            //                        PhotosPicker(selection: self.$selectedPhoto, matching: .images) {
                            //                            HStack {
                            //                                Text("라이브러리에서 선택")
                            //                                    .madiiFont(font: .madiiBody2, color: .white)
                            //                                Spacer()
                            //                            }
                            //                            .padding(.horizontal, 16)
                            //                            .frame(height: 50)
                            //                        }
                            
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
                    //                .task(id: self.selectedPhoto) {
                    //                    self.showProfileImageSheet = false
                    //                    self.profileImage = try? await self.selectedPhoto?.loadTransferable(type: Image.self)
                    //
                    //                    // FIXME: 이미지 회전되어 나타나는 버그 수정
                    //                }
                    
                    MadiiTextField(placeHolder: "닉네임을 입력해주세요", text: self.$nickname,
                                   strokeColor: self.strokeColor(), limit: 10)
                    .textFieldHelperMessage(self.helperMessage, color: self.strokeColor())
                    .onChange(of: self.nickname) { self.checkValidNickname($0) }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 20)
            }
            .scrollIndicators(.never)

            Spacer()

            Button {
                // 프로필 등록
                postProfile()
            } label: {
                MadiiButton(title: "완료", size: .big)
                    .opacity(self.isNicknameVaild ? 1.0 : 0.4)
            }
            .disabled(self.isNicknameVaild == false)
            .padding(.horizontal, 18)
            .padding(.bottom, 24)
            .navigationDestination(isPresented: $showCompleteSignUpView) {
                CompleteSignUpView().navigationBarBackButtonHidden()
            }
        }
    }
    
    private func postProfile() {
        if from != .id {
            UsersAPI.shared.editMarketingAgree(agree: signUpStatus.marketingAgreed) { isSuccess in
                if isSuccess {
                    print("DEBUG AddProfileView: marketing isSuccess true")
                } else {
                    print("DEBUG AddProfileView: marketing isSuccess false")
                }
            }
        }
        
        ProfileAPI.shared.postUsersProfile(nickname: nickname, image: image) { isSuccess in
            if isSuccess {
                isLoggedIn = true
                showCompleteSignUpView = true
            } else {
                print("DEBUG AddProfileView: isSuccess false")
            }
        }
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
