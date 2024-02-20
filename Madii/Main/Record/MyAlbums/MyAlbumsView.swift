//
//  MyAlbumsView.swift
//  Madii
//
//  Created by 이안진 on 12/4/23.
//

import SwiftUI

struct MyAlbumsView: View {
    @State private var albums: [Album] = []
    @State private var showAlbumDetailView: Bool = false
    @State private var showAlbumSettingSheet: Bool = false
    
    @State private var selectedAlbum: Album = Album(id: 0, backgroundColorNum: 1, iconNum: 21, title: "앨범을 불러오지 못했어요")
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(spacing: 0) {
                Text("소확행 앨범")
                    .madiiFont(font: .madiiSubTitle, color: .white)
                    
                Spacer()
                
                /*
                // 추가 버튼 삭제
                 
                Text("추가")
                    .madiiFont(font: .madiiBody5, color: .white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.madiiOption)
                    .cornerRadius(6)
                 */
            }
            
            VStack(spacing: 16) {
                ForEach(albums) { album in
                    Button {
                        selectedAlbum = album
                        showAlbumDetailView = true
                    } label: {
                        AlbumRowWithRightView(album: album) {
                            Button {
                                showAlbumSettingSheet = true
                            } label: {
                                Image(systemName: "ellipsis")
                                    .resizable()
                                    .frame(width: 20, height: 4)
                                    .foregroundStyle(Color.gray500)
                                    .padding(10)
                                    .padding(.vertical, 8)
                            }
                        }
                    }
                }
                .navigationDestination(isPresented: $showAlbumDetailView) {
                    AlbumDetailView(album: selectedAlbum) }
            }
            .onAppear { getAlbums() }
        }
        .roundBackground(bottomPadding: 32)
        .sheet(isPresented: $showAlbumSettingSheet) {
            AlbumSettingBottomSheet(showAlbumSettingSheet: $showAlbumSettingSheet)
                .presentationDetents([.height(360)])
                .presentationDragIndicator(.visible)
        }
    }
    
    private func getAlbums() {
        RecordAPI.shared.getAlbums { isSuccess, albumList in
            if isSuccess {
                albums = []
                for album in albumList {
                    let newAlbum = Album(id: album.albumId, backgroundColorNum: album.albumColorNum, iconNum: album.joyIconNum, title: album.name)
                    albums.append(newAlbum)
                }
            } else {
                print("DEBUG MyAlbumsView: isSuccess false")
            }
        }
    }
}

#Preview {
    MadiiTabView()
}
