//
//  HomePlayJoyListView.swift
//  Madii
//
//  Created by 정태우 on 12/23/23.
//

import SwiftUI

struct HomePlayJoyListView: View {
    @State var playAlbums: [GetAlbumsResponse] = []
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
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
                .padding(.top, 28)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(Color.madiiOption)
                    .padding(.top, 80)
                    .padding(.bottom, 40)
                
                Text("마지막이에요! 나만의 소확행 모음을 만들어보세요")
                    .madiiFont(font: .madiiBody4, color: .gray500)
                    .padding(.bottom, 8)
                
                NavigationLink {
                    
                } label: {
                    Text("나만의 소확행 앨범 만들기")
                        .madiiFont(font: .madiiBody5, color: .darkYellowGreen)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 20)
                        .background(Color.madiiYellowGreen)
                        .cornerRadius(90)
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 44)
        }
        .scrollIndicators(.never)
        .navigationTitle("행복을 재생해요")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            HomeAPI.shared.getAllAlbums(albumId: nil, size: 30) { isSuccess, allAlbum in
                if isSuccess {
                    playAlbums = allAlbum.content
                }
            }
        }
    }
}

#Preview {
    HomePlayJoyListView()
}
