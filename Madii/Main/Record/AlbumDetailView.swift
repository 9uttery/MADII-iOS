//
//  AlbumDetailView.swift
//  Madii
//
//  Created by 이안진 on 12/5/23.
//

import SwiftUI

struct AlbumDetailView: View {
    @State var album: Album = .dummy1
    let myAlbums: [Album] = Album.dummy4
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                // 앨범 커버
                ZStack {
                    Color.madiiPurple
                        .frame(maxWidth: .infinity)
                        .frame(height: 180)
                    
                    HStack(spacing: 0) {
                        ForEach(0 ..< 3, id: \.self) { index in
                            Rectangle()
                                .frame(width: 100, height: 100)
                            
                            if index != 2 { Spacer() }
                        }
                    }
                    .padding(.horizontal, 12)
                }
                
                // 앨범 정보
                VStack(alignment: .leading, spacing: 12) {
                    Text(album.title)
                        .madiiFont(font: .madiiTitle, color: .white)
                    
                    Text(album.description)
                        .madiiFont(font: .madiiBody4, color: .white.opacity(0.6))
                }
                .padding(.horizontal, 25)
                .padding(.vertical, 20)
                
                VStack(spacing: 12) {
                    // 소확행 리스트
                    VStack(spacing: 4) {
                        ForEach(0 ..< 3, id: \.self) { _ in
                            HStack {
                                JoyRowWithButton(title: "샤브샤브 먹기") {
                                    // sheet
                                } buttonLabel: {
                                    // 메뉴 버튼 이미지
                                    Image(systemName: "ellipsis")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 20, height: 20)
                                        .foregroundStyle(Color.gray500)
                                        .padding(10)
                                }
                                .padding(.leading, 12)
                                .padding(.trailing, 16)
                                .padding(.vertical, 4)
                            }
                        }
                    }
                    .padding(.vertical, 20)
                    .background(Color.madiiBox)
                    .cornerRadius(20)
                    
                    // 다른 소확행 앨범 모음
                    VStack(spacing: 12) {
                        ForEach(myAlbums) { album in
                            NavigationLink {
                                AlbumDetailView(album: Album(id: album.id,
                                                             title: album.title,
                                                             creator: album.creator,
                                                             description: album.description))
                            } label: {
                                AlbumRow(hasName: true, name: "\(album.creator)님의", title: album.title)
                            }
                        }
                    }
                    .roundBackground("다른 소확행 앨범 모음", bottomPadding: 32)
                }
                .padding(.horizontal, 16)
            }
            // 스크롤 하단 여백 40
            .padding(.bottom, 40)
        }
        .scrollIndicators(.hidden)
        .navigationTitle("")
        .toolbarBackground(Color.madiiBox, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

#Preview {
    AlbumDetailView()
}
