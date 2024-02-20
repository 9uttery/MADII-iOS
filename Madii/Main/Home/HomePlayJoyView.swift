//
//  HomePlayJoyView.swift
//  Madii
//
//  Created by 정태우 on 12/23/23.
//

import SwiftUI

struct HomePlayJoyView: View {
    @State var playAlbums: [GetAlbumsResponse] = []
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            NavigationLink {
                HomePlayJoyListView()
            } label: {
                HStack {
                    Text("행복을 재생해요")
                        .madiiFont(font: .madiiSubTitle, color: .white)
                    Spacer()
                    Image("chevronRight")
                        .resizable()
                        .frame(width: 16, height: 16)
                }
                .padding(.bottom, 21.5)
            }
            VStack(spacing: 12) {
                ForEach(playAlbums) { album in
                    let newAlbum = Album(id: album.albumId, backgroundColorNum: album.albumColorNum, iconNum: album.joyIconNum, title: album.name)
                    
                    NavigationLink {
                        AlbumDetailView(album: newAlbum)
                    } label: {
                        AlbumRow(album: newAlbum)
                    }
                }
            }
        }
        .roundBackground()
        .onAppear {
            HomeAPI.shared.getAllAlbums(albumId: nil, size: 5) { isSuccess, allAlbum in
                if isSuccess {
                    playAlbums = allAlbum.content
                }
                
            }
        }
    }
}

#Preview {
    HomePlayJoyView()
}
