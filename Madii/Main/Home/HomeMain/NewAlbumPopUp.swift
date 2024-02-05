//
//  NewAlbumPopUp.swift
//  Madii
//
//  Created by 정태우 on 12/24/23.
//

import SwiftUI

struct NewAlbumPopUp: View {
    @EnvironmentObject private var tabBarManager: TabBarManager
    @Binding var showSaveJoyPopUp: Bool

    @State private var selectedAlbumIds: [Int] = []
    @State private var albumName: String = ""
    @State private var albumDescription: String = ""
    @State private var isEditing: Bool = false
    @Binding var showSaveJoyToast: Bool

    var body: some View {
        ZStack(alignment: .top) {
            Color.black.opacity(0.8).ignoresSafeArea()
                .onTapGesture {
                    dismissPopUp()
                }

            PopUp(title: "새로운 앨범",
                  leftButtonTitle: "취소", leftButtonAction: dismissPopUp,
                  rightButtonTitle: "생성", rightButtonColor: .white, rightButtonAction: saveJoy)
            {
                // 이름 설명 입력
                VStack(alignment: .leading, spacing: 0) {
                    Text("이름")
                        .madiiFont(font: .madiiBody2, color: .white)
                        .padding(.top, 24)
                        .padding(.bottom, 8)
                    TextField("앨범 이름을 적어주세요.", text: $albumName)
                        .madiiFont(font: .madiiBody3, color: .white)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 6)
                        .scrollContentBackground(.hidden)
                        .background(.madiiOption)
                        .cornerRadius(4)
                    Text("설명")
                        .madiiFont(font: .madiiBody2, color: .white)
                        .padding(.top, 24)
                        .padding(.bottom, 8)
                    ZStack(alignment: .topLeading) {
                        TextEditor(text: Binding(
                            get: { albumDescription },
                            set: {
                                if $0.count <= 30 {
                                    albumDescription = $0
                                }
                            }
                        ))
                        .scrollContentBackground(.hidden)
                        .background(.madiiOption)
                        .cornerRadius(4)
                        .frame(height: 58)
                        if albumDescription.isEmpty && !isEditing {
                            Text("앨범에 대한 소개를 적어주세요.(30자 이내)")
                                .madiiFont(font: .madiiBody3, color: Color(UIColor.placeholderText))
                                .padding(.horizontal, 4)
                                .padding(.top, 8)
                        }
                    }
                    .padding(.bottom, 32)
                }
                .frame(maxHeight: 180)
            }
            .padding(.horizontal, 37)
            .padding(.top, 160)
        }
    }

    var createAlbumButton: some View {
        Button {
            // showCreateAlbumPopUp
        } label: {
            HStack {
                Image(systemName: "plus.app")
                    .frame(width: 20, height: 20)
                    .foregroundStyle(Color.gray500)

                Text("새로운 앨범")
                    .madiiFont(font: .madiiBody3, color: .gray500)
                Spacer()
            }
            .padding(.horizontal, 6)
            .padding(.vertical, 8)
            .background(Color.madiiOption)
            .cornerRadius(4)
        }
    }

    func dismissPopUp() {
        showSaveJoyPopUp = false
        tabBarManager.isTabBarShown = true
    }

    func saveJoy() {
        // 소확행 저장
        dismissPopUp()

        withAnimation {
            showSaveJoyToast = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation {
                showSaveJoyToast = false
            }
        }
    }
}


#Preview {
    NewAlbumPopUp(showSaveJoyPopUp: .constant(false), showSaveJoyToast: .constant(false))
}
