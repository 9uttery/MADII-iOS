//
//  AlbumDetailOtherAlbumsView.swift
//  Madii
//
//  Created by 이안진 on 2/21/24.
//

import SwiftUI

struct AlbumDetailOtherAlbumsView: View {
    let album: Album
    @State private var othersAlbums: [Album] = []
    
    var fromPlayJoy: Bool = false
    
    var body: some View {
        VStack(spacing: 12) {
            ForEach(othersAlbums) { album in
                NavigationLink {
                    AlbumDetailView(album: album, fromPlayJoy: fromPlayJoy)
                } label: {
                    AlbumRow(album: album)
                }
            }
        }
        .roundBackground("다른 소확행 앨범 모음", bottomPadding: 32)
        .onAppear { getRandomAlbums() }
    }
    
    private func getRandomAlbums() {
        RecordAPI.shared.getRandomAlbumsById(albumId: album.id) { isSuccess, albumList in
            if isSuccess {
                othersAlbums = []
                for album in albumList {
                    let newAlbum = Album(id: album.albumId, backgroundColorNum: album.albumColorNum, iconNum: album.joyIconNum, title: album.name)
                    othersAlbums.append(newAlbum)
                }
            } else {
                print("DEBUG AlbumDetailOtherAlbumsView getRandomAlbums: isSuccess false")
            }
        }
    }
}
