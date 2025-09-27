//
//  AlbumDetailsView.swift
//  Madii
//
//  Created by 정태우 on 7/22/25.
//

import SwiftUI

struct AlbumDetailsView: View {
    @State var albumId: Int = 0
    @State var albumTitle: String = ""
    @State var albumDescription: String = ""
    @State var albumList = []
    @State var albumCoverId: Int = 0
    @State var joyResponses: [GetAlbumByIdResponseJoyInfo] = []
    @State var joyTitle: String = ""
    @State var albums: [Album] = Album.dummy3
    @State var isMine: Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                Image("Cover\(albumCoverId)")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .cornerRadius(40)
                    .padding(.bottom, 40)
                
                Text(albumTitle)
                    .madiiFont(font: .madiiSubTitle, color: .madiiNormal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 4)
                
                Text(albumDescription)
                    .madiiFont(font: .caption, color: .white.opacity(0.43))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 20)
                
                VStack(spacing: 0) {
                    ForEach(joyResponses, id: \.joyId) { joy in
                        HStack(spacing: 12) {
                            Circle()
                                .foregroundStyle(.madiiYellowGreen)
                            
                            Text(joy.contents)
                                .madiiFont(font: .madiiBody2, color: .madiiNormal)
                            
                            Spacer()
                            
                            Image(systemName: "ellipsis")
                                .frame(width: 28, height: 28)
                                .foregroundStyle(.madiiAlternative)
                        }
                    }
                    
                    HStack(spacing: 8) {
                        Button {
                            
                        } label: {
                            Image("plusSquare")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundStyle(.madiiAlternative)
                        }
                        
                        TextField("행복 추가하기", text: $joyTitle)
                    }
                }
                .padding(12)
                .background(.madiiGray30)
                .cornerRadius(12)
                .padding(.vertical, 28)
                .padding(.horizontal, 16)
                .background(.madiiElevated)
                .cornerRadius(32)
                .padding(.bottom, 40)
                
                Text("다른 소확행 앨범 모음")
                    .madiiFont(font: .madiiSubTitle, color: .madiiNormal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 40)
                
                VStack(alignment: .leading, spacing: 16) {
                    ForEach(albums) { album in
                        HStack(spacing: 12) {
                            Image("CoverB")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .cornerRadius(12)
                            
                            Text(album.title)
                                .madiiFont(font: .madiiBody2, color: .madiiNormal)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                        }
                    }
                }
                .padding(.vertical, 28)
                .padding(.horizontal, 20)
                .background(.madiiBox)
                .cornerRadius(40)
            }
            .padding(.horizontal, 20)
        }
        .onAppear {
            getAlbumByAlbumId()
        }
    }
    
    func getAlbumByAlbumId() {
        AlbumAPI().getAlbumByAlbumId(albumId: albumId) { isSuccess, albumInfo in
            if isSuccess {
                print("DEBUG getAlbumByAlbumId: get isSuccess true")
                self.albumTitle = albumInfo.name
                self.albumDescription = albumInfo.description
                self.joyResponses = albumInfo.joyInfoList
                self.albumCoverId = albumInfo.albumColorNum
            } else {
                print("DEBUG getAlbumByAlbumId: get isSuccess false")
            }
            
        }
    }
}

#Preview {
    AlbumDetailsView()
}
