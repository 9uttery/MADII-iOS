//
//  HomePlayJoyView.swift
//  Madii
//
//  Created by 정태우 on 12/23/23.
//

import SwiftUI

struct HomePlayJoyView: View {
    let playAlbums: [Album] = Album.dummy4
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
                    NavigationLink {
                        AlbumDetailView(album: Album(id: album.id, title: album.title, creator: album.creator, description: album.description))
                    } label: {
                        AlbumRow(hasName: true, name: "\(album.creator)님", title: album.title)
                    }
                }
            }
        }
        .roundBackground()
    }
}

#Preview {
    HomePlayJoyView()
}
