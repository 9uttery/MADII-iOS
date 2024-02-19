//
//  LatestViewedAlbumView.swift
//  Madii
//
//  Created by 이안진 on 1/24/24.
//

import SwiftUI

struct LatestViewedAlbumView: View {
    private let albums: [Album] = Album.dummy10
    
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
        }
        .scrollIndicators(.hidden)
        .navigationTitle("최근 본 앨범")
        .toolbarBackground(Color.madiiBox, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

#Preview {
    LatestViewedAlbumView()
}
