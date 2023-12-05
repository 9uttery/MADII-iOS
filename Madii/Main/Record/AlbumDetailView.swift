//
//  AlbumDetailView.swift
//  Madii
//
//  Created by 이안진 on 12/5/23.
//

import SwiftUI

struct AlbumDetailView: View {
    @State var album: Album = Album.dummy1
    let myAlbums: [Album] = Album.dummy4
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .top) {
                // 앨범 커버
                ZStack(alignment: .topLeading) {
                    Rectangle()
                        .foregroundStyle(Color.madiiPurple)
                        .frame(height: UIScreen.main.bounds.width)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text(album.title)
                            .madiiFont(font: .madiiTitle, color: .black)
                        
                        Text("\(album.creator)님")
                            .madiiFont(font: .madiiBody4, color: .black.opacity(0.6))
                        
                        Text(album.description)
                            .madiiFont(font: .madiiCaption, color: .black.opacity(0.6))
                    }
                    .padding(.top, 20)
                    .padding(.horizontal, 24)
                }
                
                VStack(spacing: 12) {
                    // 소확행 리스트
                    VStack(spacing: 12) {
                        ForEach(0 ..< 3, id: \.self) { _ in
                            HStack {
                                JoyRow(title: "샤브샤브 먹기")
                                Spacer()
                                Button {
                                    
                                } label: {
                                    Image(systemName: "ellipsis")
                                        .resizable()
                                        .frame(width: 20, height: 4)
                                        .foregroundStyle(Color.gray500)
                                        .padding(10)
                                        .padding(.vertical, 8)
                                }
                            }
                            .padding(.vertical, 8)
                        }
                    }
                    .roundBackground()
                    
                    // 다른 소확행 앨범 모음
                    VStack(spacing: 12) {
                        ForEach(myAlbums) { album in
                            NavigationLink {
                                AlbumDetailView(album: Album(id: album.id,
                                                             title: album.title,
                                                             creator: album.creator,
                                                             description: album.description))
                            } label: {
                                AlbumRow(hasName: true, name: "\(album.creator)님", title: album.title)
                            }
                        }
                    }
                    .roundBackground("다른 소확행 앨범 모음", bottomPadding: 32)
                }
                .padding(.horizontal, 16)
                .padding(.top, 284)
            }
            .padding(.bottom, 40)
        }
        .scrollIndicators(.hidden)
        // 다음 앨범으로 넘어갈 때 title "" 처리하기
        .navigationTitle("소확행 앨범")
        .toolbarBackground(Color.madiiBox, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

#Preview {
    AlbumDetailView()
}
