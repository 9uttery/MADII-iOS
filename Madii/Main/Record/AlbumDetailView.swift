//
//  AlbumDetailView.swift
//  Madii
//
//  Created by 이안진 on 12/5/23.
//

import SwiftUI

struct AlbumDetailView: View {
    private let colors: [Int: Color] = [1: Color.orange, 2: Color.madiiPurple, 3: Color.madiiSkyBlue, 4: Color.madiiPink]
    @State var album: Album
    
    private let joys: [Joy] = Joy.manyAchievedDummy
    private let othersAlbums: [Album] = Album.dummy4
    
    @State private var isAlbumMine: Bool = true
    @State private var isAlbumSaved: Bool = true
    
    @State private var selectedJoy: Joy?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                // 앨범 커버 & 저장 버튼
                ZStack(alignment: .bottomTrailing) {
                    // 앨범 커버 이미지
                    ZStack {
                        colors[album.backgroundColorNum]
                            .frame(maxWidth: .infinity)
                            .frame(height: 180)
                        
                        HStack(spacing: 0) {
                            ForEach(0 ..< 3, id: \.self) { index in
                                Image("icon_\(album.iconNum)")
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                
                                if index != 2 { Spacer() }
                            }
                        }
                        .padding(.horizontal, 12)
                    }
                    
                    // 저장 버튼
                    if isAlbumMine == false {
                        Button {
                            isAlbumSaved.toggle()
                        } label: {
                            HStack(spacing: 4) {
                                Image(systemName: "bookmark.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20, height: 18)
                                    .foregroundStyle(isAlbumSaved ? Color.madiiYellowGreen : Color.white)
                                
                                Text(isAlbumSaved ? "저장 완료" : "앨범 저장")
                                    .madiiFont(font: .madiiBody3, color: .white)
                            }
                            .padding(.leading, 8)
                            .padding(.trailing, 12)
                            .padding(.vertical, 8)
                            .frame(height: 40, alignment: .center)
                            .background(.black.opacity(isAlbumSaved ? 0.6 : 1.0))
                            .cornerRadius(6)
                            .overlay(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(.white, lineWidth: 1)
                            )
                            .opacity(isAlbumSaved ? 1.0 : 0.5)
                        }
                        .offset(x: -18, y: -12)
                    }
                }
                
                // 앨범 정보
                VStack(alignment: .leading, spacing: 12) {
                    Text(album.title)
                        .madiiFont(font: .madiiTitle, color: .white)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        if isAlbumMine == false { Text("\(album.creator)님") }
                        Text(album.description)
                    }
                    .madiiFont(font: .madiiBody4, color: .white.opacity(0.6))
                }
                .padding(.horizontal, 25)
                .padding(.vertical, 20)
                
                VStack(spacing: 20) {
                    // 소확행 리스트
                    VStack(spacing: 4) {
                        ForEach(joys) { joy in
                            HStack {
                                JoyRowWithButton(joy: joy) {
                                    if isAlbumMine {
                                        // 나의 앨범: 소확행 메뉴 bottom sheet
                                        selectedJoy = joy
                                    } else {
                                        // 타인의 앨범: 소확행 저장 아이콘
                                    }
                                } buttonLabel: {
                                    if isAlbumMine {
                                        // 나의 앨범: 메뉴 버튼 이미지
                                        Image(systemName: "ellipsis")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 20, height: 20)
                                            .foregroundStyle(Color.gray500)
                                            .padding(10)
                                    } else {
                                        // 타인의 앨범: 북마크 버튼 이미지
                                        Image(true ? "inactiveSave" : "activeSave")
                                            .resizable()
                                            .frame(width: 36, height: 36)
                                    }
                                }
                                .padding(.leading, 12)
                                .padding(.trailing, 16)
                                .padding(.vertical, 4)
                            }
                        }
                    }
                    .sheet(item: $selectedJoy, content: { item in
                        JoyMenuBottomSheet(joy: item, isMine: true)
                    })
                    .padding(.vertical, 20)
                    .background(Color.madiiBox)
                    .cornerRadius(20)
                    
                    // 다른 소확행 앨범 모음
                    VStack(spacing: 12) {
                        ForEach(othersAlbums) { album in
                            NavigationLink {
                                AlbumDetailView(album: Album(id: album.id,
                                                             title: album.title,
                                                             creator: album.creator,
                                                             description: album.description))
                            } label: {
                                AlbumRow(album: album)
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
        .navigationBarItems(trailing:
            Button {
                // Handle button tap
                print("Button tapped!")
            } label: {
                Image(systemName: "ellipsis")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .foregroundStyle(Color.gray500)
                    .padding(10)
            }
        )
        .toolbarBackground(Color.madiiBox, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .onAppear { getAlbumInfo() }
    }
    
    private func getAlbumInfo() {
        AlbumAPI.shared.getAlbumByAlbumId(albumId: album.id) { isSuccess, albumInfo in
            if isSuccess {
                print("DEBUG AlbumDetailView: albumInfo \(albumInfo)")
                
                if let creator = albumInfo.nickname {
                    // 다른 사람의 앨범
                    isAlbumMine = false
                    isAlbumSaved = albumInfo.isAlbumSaved ?? true
                    album.creator = creator
                } else {
                    // 나의 앨범
                    isAlbumMine = true
                }
                
                // 소확행 리스트
                
                // 다른 소확행 앨범 모음
                
                
            } else {
                print("DEBUG AlbumDetailView: isSuccess false")
            }
        }
    }
}

#Preview {
    AlbumDetailView(album: Album(id: 1, title: ""))
}
