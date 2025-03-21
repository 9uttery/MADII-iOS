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
        VStack(spacing: 0) {
            if albums.isEmpty {
                emptyView
            } else {
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(albums) { album in
                            NavigationLink {
                                AlbumDetailView(album: album)
                            } label: {
                                AlbumRow(album: album)
                            }
                            .simultaneousGesture(TapGesture().onEnded {
                                AnalyticsManager.shared.logEvent(name: "최근본앨범뷰_최근본앨범클릭")
                            })
                        }
                    }
                    .padding(.leading, 8)
                    .padding(.top, 28)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 60)
                    .onAppear { getAlbums() }
                }
                .scrollIndicators(.hidden)
            }
        }
        .navigationTitle("최근 본 앨범")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color.madiiBox, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .onAppear { getAlbums() }
        .analyticsScreen(name: "최근 본 앨범뷰")
    }
    
    private var emptyView: some View {
        VStack(spacing: 60) {
            Spacer()
            
            Image("myJoyEmpty")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 240)
            
            VStack(spacing: 20) {
                Text("최근 본 앨범이 없어요")
                    .madiiFont(font: .madiiBody3, color: .gray500)
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
            Spacer()
        }
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
