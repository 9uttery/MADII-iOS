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
    @Binding var showAddAlbumPopUp: Bool
    
    @State private var selectedAlbum: Album = Album(id: 0, backgroundColorNum: 1, iconNum: 21, title: "앨범을 불러오지 못했어요")
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(spacing: 0) {
                Text("소확행 앨범")
                    .madiiFont(font: .madiiSubTitle, color: .white)
                    
                Spacer()
                
                // 새로운 앨범 추가 버튼
                Button {
                    showAddAlbumPopUp = true
                    AnalyticsManager.shared.logEvent(name: "레코드뷰_앨범추가클릭")
                } label: {
                    ZStack {
                        Rectangle()
                            .foregroundStyle(Color.madiiOption)
                            .frame(width: 24, height: 24)
                            .cornerRadius(6)
                        
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 13, height: 13)
                            .foregroundStyle(Color.white)
                            .padding(.horizontal, 8)
                    }
                }
            }
            
            VStack(spacing: 16) {
                ForEach(albums) { album in
                    NavigationLink {
                        AlbumDetailView(album: album)
                    } label: {
                        AlbumRowWithRightView(album: album) { }
                    }
                }
            }
            .onAppear { getAlbums() }
            .onChange(of: showAddAlbumPopUp) { _ in
                // 팝업 사라지면 앨범 새로 불러오기
                if showAddAlbumPopUp == false { getAlbums() }
            }
        }
        .roundBackground(bottomPadding: 32)
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

//#Preview {
//    MadiiTabView()
//}
