//
//  AddJoyPopUp.swift
//  Madii
//
//  Created by 이안진 on 2/27/24.
//

import SwiftUI

struct AddJoyPopUp: View {
    let album: Album
    @Binding var showAddJoyPopUp: Bool
    @State private var newJoyTitle: String = ""
    @State private var albums: [Album] = []
    @State private var selectedAlbumIds: [Int] = []
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.8).ignoresSafeArea()
                .onTapGesture { dismiss() }

            PopUp(title: "소확행 이름",
                  leftButtonTitle: "취소", leftButtonAction: dismiss,
                  rightButtonTitle: "저장", rightButtonColor: newJoyTitle.isEmpty ? .gray : .white, rightButtonAction: addJoy) {
                
                VStack(alignment: .leading, spacing: 24) {
                    HStack {
                        TextField("소확행 이름을 입력해주세요", text: $newJoyTitle)
                            .madiiFont(font: .madiiBody3, color: .white)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 16)
                    .background(Color.madiiOption)
                    .cornerRadius(4)
                    
                    Text("어떤 앨범에 저장할까요?")
                        .madiiFont(font: .madiiSubTitle, color: .white)
                    
                    // 앨범 리스트
                    ScrollView(.vertical) {
                        VStack(alignment: .leading, spacing: 12) {
                            // 내가 만든 앨범들
                            myAlbums
                        }
                    }
                    .frame(maxHeight: 248)
                }
            }
            .padding(36)
        }
        .onTapGesture { hideKeyboard() }
        .onAppear { getMyAlbums() }
        .analyticsScreen(name: "소확행추가팝업")
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
    
    private func dismiss() {
        withoutAnimation {
            showAddJoyPopUp = false
        }
        AnalyticsManager.shared.logEvent(name: "소확행추가팝업_취소클릭")
    }
    
    private func getMyAlbums() {
        AlbumAPI.shared.getAlbumsCreatedByMe { isSuccess, albumList in
            if isSuccess {
                albums = []
                selectedAlbumIds = []
                for album in albumList {
                    if album.albumId == self.album.id { selectedAlbumIds.append(album.albumId) }
                    let newAlbum = Album(id: album.albumId, title: album.name)
                    albums.append(newAlbum)
                }
            } else {
                print("앨범 목록 가져오기 실패")
            }
        }
    }
    
    private func addJoy() {
        if newJoyTitle.isEmpty == false {
            // 소확행 추가
            JoyAPI.shared.postJoy(contents: newJoyTitle) { isSuccess, newJoy in
                if isSuccess {
                    // 소확행을 앨범에 추가
                    RecordAPI.shared.editJoy(joyId: newJoy.joyId, contents: newJoy.contents, beforeAlbumIds: [], afterAlbumIds: selectedAlbumIds) { isSuccess, _ in
                        if isSuccess {
                            print("앨범 설정 소확행 추가에서 edit joy 성공")
                            dismiss()
                        } else {
                            print("앨범 설정 소확행 추가에서 edit joy 실패")
                        }
                    }
                } else {
                    print("앨범 설정 소확행 추가에서 postJoy 실패")
                }
            }
            AnalyticsManager.shared.logEvent(name: "소확행추가팝업_저장클릭")
        }
    }
}
