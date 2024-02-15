//
//  AddProfileView.swift
//  Madii
//
//  Created by 이안진 on 2/2/24.
//

import PhotosUI
import SwiftUI

struct AddProfileView: View {
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
            Text("시작 전 프로필을 완성해보세요")
                .madiiFont(font: .madiiTitle, color: .white)
                .padding(.horizontal, 8)
                .padding(.vertical, 10)
                .padding(.bottom, 36)
                .padding(.horizontal, 18)

            VStack(spacing: 24) {
                Button {
                    self.showProfileImageSheet = true
                } label: {
                    if let image = profileImage {
                        image
                            .resizable()
                            .frame(width: 140, height: 140)
                            .scaledToFill()
                            .cornerRadius(200)
                    } else {
                        Image("defaultProfile")
                            .frame(width: 140, height: 140)
                    }
                }
                .sheet(isPresented: self.$showProfileImageSheet) {
                    VStack(spacing: 0) {
                        PhotosPicker(selection: self.$selectedPhoto, matching: .images) {
                            HStack {
                                Text("라이브러리에서 선택")
                                    .madiiFont(font: .madiiBody2, color: .white)
                                Spacer()
                            }
                            .padding(.horizontal, 16)
                            .frame(height: 50)
                        }

                        HStack {
                            Text("현재 사진 삭제")
                                .madiiFont(font: .madiiBody2, color: .white)
                            Spacer()
                        }
                        .padding(.horizontal, 16)
                        .frame(height: 50)

                        Spacer()
                    }
                    .padding(.top, 60)
                    .background(Color.madiiPopUp)
                    .presentationDetents([.height(180)])
                    .presentationDragIndicator(.visible)
                }
                .task(id: self.selectedPhoto) {
                    self.showProfileImageSheet = false
                    self.profileImage = try? await self.selectedPhoto?.loadTransferable(type: Image.self)
                    
                    // FIXME: 이미지 회전되어 나타나는 버그 수정
                }

                MadiiTextField(placeHolder: "닉네임을 입력해주세요", text: self.$nickname,
                               strokeColor: self.strokeColor(), limit: 10)
                    .textFieldHelperMessage(self.helperMessage, color: self.strokeColor())
                    .onChange(of: self.nickname) { self.checkValidNickname($0) }
            }
            .padding(.horizontal, 24)

            Spacer()

            Button {
                showCompleteSignUpView = true
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
