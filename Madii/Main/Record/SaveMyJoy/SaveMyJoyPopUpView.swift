//
//  SaveJoyAtAlbumPopUpView.swift
//  Madii
//
//  Created by 이안진 on 12/1/23.
//

import SwiftUI

struct SaveMyJoyPopUpView: View {
    @EnvironmentObject private var popUpStatus: PopUpStatus
    
    @Binding var joy: Joy
    @State private var albums: [Album] = []
    @State private var selectedAlbumIds: [Int] = []

    var body: some View {
        ZStack {
            Color.black.opacity(0.8).ignoresSafeArea()
                .onTapGesture { withoutAnimation { dismissPopUp() } }

            PopUp(title: "소확행 이름", leftButtonTitle: "취소", leftButtonAction: dismissPopUp, rightButtonTitle: "확인", rightButtonColor: selectedAlbumIds.isEmpty ? .gray : .white, rightButtonAction: saveJoy) {
                
                VStack(alignment: .leading, spacing: 24) {
                    SelectAlbumRow(title: joy.title, isSelected: false)
                    
                    Text("어떤 앨범에 저장할까요?")
                        .madiiFont(font: .madiiSubTitle, color: .white)
                    
                    // 앨범 리스트
                    ScrollView(.vertical) {
                        VStack(alignment: .leading, spacing: 12) {
                            // 내가 만든 앨범들
                            myAlbums

                            // 새로운 앨범 추가 버튼
//                            createAlbumButton
                        }
                    }
                    .frame(maxHeight: 248)
                }
            }
            .padding(.horizontal, 40)
        }
        .onAppear { getMyAlbums() }
    }
    
    private func getMyAlbums() {
        AlbumAPI.shared.getAlbumsWithJoySavedInfo(joyId: joy.joyId) { isSuccess, albumList in
            if isSuccess {
                albums = []
                selectedAlbumIds = []
                for album in albumList {
                    if album.isSaved { selectedAlbumIds.append(album.albumId) }
                    let newAlbum = Album(id: album.albumId, backgroundColorNum: album.albumColorNum, iconNum: album.joyIconNum, title: album.name)
                    albums.append(newAlbum)
                }
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
            .padding(.horizontal, 8)
            .padding(.vertical, 16)
            .background(Color.madiiOption)
            .cornerRadius(4)
        }
    }

    func dismissPopUp() {
        popUpStatus.showSaveJoyToAlbumPopUp = false
    }

    func saveJoy() {
        // 소확행 저장
        RecordAPI.shared.saveJoy(joyId: joy.joyId, albumIds: selectedAlbumIds) { isSuccess in
            if isSuccess {
                print("소확행 앨범에 저장 성공")
                dismissPopUp()
            } else {
                print("소확행 앨범에 저장 실패")
            }
        }
    }
}

// 투명 fullScreenCover
extension View {
    func transparentFullScreenCover<Content: View>(isPresented: Binding<Bool>, content: @escaping () -> Content) -> some View {
        fullScreenCover(isPresented: isPresented) {
            ZStack {
                content()
            }
            .background(TransparentBackground())
        }
    }
}

struct TransparentBackground: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}

#Preview {
//    SplashView()
    MadiiTabView()
}
