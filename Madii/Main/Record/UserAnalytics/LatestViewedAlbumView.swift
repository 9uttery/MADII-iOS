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
                
                /* 임시 삭제
                Button {
                    popUpStatus.showSaveMyJoyOverlay = true
                    dismiss()
                } label: {
                    Text("소확행 기록하러 가기")
                        .madiiFont(font: .madiiBody2, color: .black)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .background(Color.madiiYellowGreen)
                        .clipShape(RoundedRectangle(cornerRadius: 90))
                }
                 */
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
