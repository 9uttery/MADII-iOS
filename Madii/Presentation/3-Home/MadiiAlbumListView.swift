//
//  MadiiAlbumListView.swift
//  Madii
//
//  Created by 정태우 on 7/21/25.
//

import SwiftUI

struct MadiiAlbumListView: View {
    @State private var albums: [Album] = Album.dummy10
    @State private var isSelect: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    
                } label: {
                    if isSelect {
                        Image(systemName: "arrow.left")
                            .resizable()
                            .frame(width: 24, height: 24)
                    } else {
                        Text("취소")
                            .madiiFont(font: .madiiBody3, color: .madiiNormal)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 12)
                            .background(.madiiContrast)
                            .cornerRadius(10)
                    }
                }
                
                Spacer()
                
                Text("소확행 앨범")
                    .madiiFont(font: .madiiSubTitle, color: .white.opacity(0.97))
                
                Spacer()
                
                Button {
                    
                } label: {
                    if isSelect {
                        Text("삭제")
                            .madiiFont(font: .madiiBody3, color: .madiiStrong)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 12)
                            .background(.madiiNegative)
                            .cornerRadius(10)
                    } else {
                        Text("선택")
                            .madiiFont(font: .madiiBody3, color: .madiiNormal)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 12)
                            .background(.madiiBox)
                            .cornerRadius(10)
                    }
                }
            }
            .padding(.horizontal, 20)
            
            ScrollView {
                LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 0, alignment: .top), count: 2), spacing: 24) {
                    VStack(alignment: .leading, spacing: 12) {
                        Button {
                            // 라우터 처리
                        } label: {
                            Image("plus")
                                .foregroundStyle(.darkYellowGreen)
                                .frame(width: 48, height: 48)
                                .padding(52)
                                .background(.madiiBox)
                                .cornerRadius(32)
                        }
                        
                        Text("새로운 앨범")
                            .madiiFont(font: .madiiBody3, color: .madiiLime)
                    }
                    .frame(height: 186)
                    
                    ForEach(albums) { album in
                        Button {
                            // 라우터 처리
                        } label: {
                            VStack(alignment: .leading, spacing: 12) {
                                Image("Cover\(album.backgroundColorNum)")
                                    .frame(width: 152, height: 152)
                                    .cornerRadius(32)
                                
                                Text(album.title)
                                    .madiiFont(font: .madiiBody3, color: .white)
                                    .multilineTextAlignment(.leading)
                                    .frame(maxWidth: 152, alignment: .leading)
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            getAllAlbums()
        }
    }
    
    func getAllAlbums() {
        HomeAPI.shared.getAllAlbums(albumId: nil, size: 999) { isSuccess, allAlbums in
            if isSuccess {
                print("DEBUG getAllAlbums: get isSuccess true")
                self.albums = allAlbums.content.map { dto in
                    Album(
                        id: dto.albumId,
                        backgroundColorNum: dto.albumColorNum,
                        iconNum: dto.joyIconNum,
                        title: dto.name,
                        creator: dto.nickname ?? "",
                        description: "",
                        isPublic: false
                    )
                }
            } else {
                print("DEBUG getAllAlbums:  isSuccess false")
            }
        }
    }
}

#Preview {
    MadiiAlbumListView()
}
