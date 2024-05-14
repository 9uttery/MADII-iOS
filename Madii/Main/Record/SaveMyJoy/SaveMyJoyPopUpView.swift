//
//  SaveJoyAtAlbumPopUpView.swift
//  Madii
//
//  Created by 이안진 on 12/1/23.
//

import SwiftUI

struct SaveMyJoyPopUpView: View {
    @EnvironmentObject var appStatus: AppStatus
    @Binding var joy: Joy
    @Binding var showSaveJoyToAlbumPopUp: Bool /// 현재 팝업 show 여부
    @Binding var showSaveJoyPopUpFromRecordMain: Bool /// 레코드 메인화면에 넘어오는지
    
    @State private var albums: [Album] = []
    @State private var beforeAlbumIds: [Int] = []
    @State private var selectedAlbumIds: [Int] = []
    
    @State private var showCreateAlbumPopUp: Bool = false /// 새로운 앨범 팝업 show 여부
    
    var fromAlbumSetting: Bool = false
    
    var canEditTitle: Bool = false
    @State private var newJoyTitle: String = ""

    var body: some View {
        ZStack {
            Color.black.opacity(0.8).ignoresSafeArea()
                .onTapGesture { withoutAnimation { dismissPopUp() } }

            PopUp(title: canEditTitle ? "소확행 이름" : "어떤 앨범에 저장할까요?", leftButtonTitle: "취소", leftButtonAction: dismissPopUp, rightButtonTitle: "확인", rightButtonColor: .white, rightButtonAction: saveJoy) {
                
                VStack(alignment: .leading, spacing: 24) {
                    if canEditTitle {
                        // 소확행 이름 수정 가능
                        HStack {
                            TextField("소확행을 적어주세요", text: $newJoyTitle)
                                .madiiFont(font: .madiiBody3, color: .white)
                                .multilineTextAlignment(.leading)
                                .onChange(of: newJoyTitle, perform: { newJoyTitle = String($0.prefix(30)) })
                            
                            Spacer()
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 16)
                        .background(Color.madiiOption)
                        .cornerRadius(4)
                    
                        Text("어떤 앨범에 저장할까요?")
                            .madiiFont(font: .madiiSubTitle, color: .white)    
                    }
                    
                    // 앨범 리스트
                    ScrollView(.vertical) {
                        VStack(alignment: .leading, spacing: 12) {
                            // 내가 만든 앨범들
                            myAlbums

                            // 새로운 앨범 추가 버튼
                            createAlbumButton
                        }
                    }
                    .frame(maxHeight: 248)
                }
            }
            .padding(36)
        }
        .onAppear {
            newJoyTitle = joy.title
            getMyAlbums()
        }
        .transparentFullScreenCover(isPresented: $showCreateAlbumPopUp) {
            AddAlbumPopUp(showAddAlbumPopUp: $showCreateAlbumPopUp, getAlbums: selectNewAlbum) }
    }
    
    private func getMyAlbums() {
        AlbumAPI.shared.getAlbumsWithJoySavedInfo(joyId: joy.joyId) { isSuccess, albumList in
            if isSuccess {
                albums = []
                beforeAlbumIds = []
                selectedAlbumIds = []
                for album in albumList {
                    if album.isSaved {
                        selectedAlbumIds.append(album.albumId)
                        beforeAlbumIds.append(album.albumId)
                    }
                    let newAlbum = Album(id: album.albumId, backgroundColorNum: album.albumColorNum, iconNum: album.joyIconNum, title: album.name)
                    albums.append(newAlbum)
                }
            } else {
                print("앨범 목록 가져오기 실패")
            }
        }
    }
    
    private func selectNewAlbum() {
        AlbumAPI.shared.getAlbumsWithJoySavedInfo(joyId: joy.joyId) { isSuccess, albumList in
            if isSuccess {
                albums = []
                beforeAlbumIds = []
                selectedAlbumIds = []
                for album in albumList {
                    if album.isSaved {
                        selectedAlbumIds.append(album.albumId)
                        beforeAlbumIds.append(album.albumId)
                    }
                    let newAlbum = Album(id: album.albumId, backgroundColorNum: album.albumColorNum, iconNum: album.joyIconNum, title: album.name)
                    albums.append(newAlbum)
                }
                
                selectedAlbumIds.append(albums.last?.id ?? 0)
            } else {
                print("앨범 목록 가져오기 실패")
            }
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
             showCreateAlbumPopUp = true
        } label: {
            HStack {
                Image(systemName: "plus.app")
                    .frame(width: 20, height: 20)
                    .foregroundStyle(Color.gray500)

                Text("새로운 앨범")
                    .madiiFont(font: .madiiBody3, color: .gray500)
                Spacer()
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 16)
            .background(Color.madiiOption)
            .cornerRadius(4)
        }
    }

    func dismissPopUp() {
        if fromAlbumSetting {
            showSaveJoyToAlbumPopUp = false
        } else {
            showSaveJoyPopUpFromRecordMain = false
        }
    }

    func saveJoy() {
        // 소확행 저장
        print("hoho \(beforeAlbumIds), \(selectedAlbumIds)")
        RecordAPI.shared.editJoy(joyId: joy.joyId, contents: newJoyTitle, beforeAlbumIds: beforeAlbumIds, afterAlbumIds: selectedAlbumIds) { isSuccess, _ in
            if isSuccess {
                print("소확행 앨범에 저장 성공")
                joy.title = newJoyTitle
                print(selectedAlbumIds)
                if !selectedAlbumIds.isEmpty {
                    appStatus.showSaveJoyToast = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        withAnimation {
                            appStatus.showSaveJoyToast = false
                        }
                    }
                }
                dismissPopUp()
            } else {
                print("소확행 앨범에 저장 실패")
            }
        }
    }
}
