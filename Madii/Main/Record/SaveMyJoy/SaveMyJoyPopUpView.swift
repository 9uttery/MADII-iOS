//
//  SaveJoyAtAlbumPopUpView.swift
//  Madii
//
//  Created by 이안진 on 12/1/23.
//

import SwiftUI

struct SaveMyJoyPopUpView: View {
    @EnvironmentObject private var tabBarManager: TabBarManager
    @Binding var showSaveJoyPopUp: Bool

    @State private var albums: [Album] = Album.dummy2
    @State private var selectedAlbumIds: [Int] = []

    @Binding var showSaveJoyToast: Bool

    var body: some View {
        ZStack(alignment: .top) {
            Color.black.opacity(0.8).ignoresSafeArea()
                .onTapGesture {
                    dismissPopUp()
                }

            PopUp(title: "어떤 앨범에 저장할까요?",
                  leftButtonTitle: "취소", leftButtonAction: dismissPopUp,
                  rightButtonTitle: "확인", rightButtonColor: .white, rightButtonAction: saveJoy)
            {
                // 앨범 리스트
                ScrollView(.vertical) {
                    VStack(alignment: .leading, spacing: 12) {
                        // 기본 선택: 내가 찾은 소확행
                        SelectAlbumRow(title: "내가 찾은 소확행", isSelected: true)

                        // 내가 가지고 있는 앨범들
                        myAlbums

                        // 새로운 앨범 추가 버튼
                        createAlbumButton
                    }
                }
                .frame(maxHeight: 180)
            }
            .padding(.horizontal, 40)
            .padding(.top, 160)
        }
    }

    var myAlbums: some View {
        ForEach(albums) { album in
            Button {
                if let index = selectedAlbumIds.firstIndex(of: album.id) {
                    selectedAlbumIds.remove(at: index)
                } else {
                    selectedAlbumIds.append(album.id)
                }
            } label: {
                SelectAlbumRow(title: album.title, isSelected: selectedAlbumIds.contains(album.id))
            }
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
