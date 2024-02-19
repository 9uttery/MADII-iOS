//
//  LatestViewedAlbumView.swift
//  Madii
//
//  Created by 이안진 on 1/24/24.
//

import SwiftUI

struct LatestViewedAlbumView: View {
    @State private var albums: [Album] = []
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(albums) { album in
                    AlbumRow(album: album)
                        .padding(.leading, 8)
                }
            }
            .padding(.top, 28)
            .padding(.horizontal, 16)
            .padding(.bottom, 60)
            .onAppear { getAlbums() }
        }
        .scrollIndicators(.hidden)
        .navigationTitle("최근 본 앨범")
        .toolbarBackground(Color.madiiBox, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
    
    private func getAlbums() {
        RecordAPI.shared.getRecent { isSuccess, albumList in
            if isSuccess {
                albums = []
                
                for album in albumList {
                    let newAlbum = Album(id: album.albumId, backgroundColorNum: album.albumColorNum, iconNum: album.joyIconNum, title: album.name)
                    albums.append(newAlbum)
                }
            }
        }
    }
}

#Preview {
    LatestViewedAlbumView()
}
