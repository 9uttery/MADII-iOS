//
//  ExplorationView.swift
//  Madii
//
//  Created by 정태우 on 8/14/25.
//

import MadiiDesignSystem
import SwiftUI

struct ExplorationView_P3: View {
    @Environment(Router.self) var router
    @State var albums: [Album] = []
    
    var body: some View {
        ScrollView {
            VStack {
                MadiiTabNavigation(tabTitle: "탐색")
                
                ZStack {
                    Image("recommendJoy")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    VStack(alignment: .leading) {
                        Text("취향저격 소확행")
                            .madiiFont(font: .caption, color: .madiiNormal)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 8)
                            .background(.madiiGray100.opacity(0.16))
                            .cornerRadius(90)
                            .padding(.bottom, 8)
                        
                        Text("나에게 꼭 맞는\n소확행을 찾아보세요!")
                            .madiiFont(font: .madiiSubTitle, color: .madiiGray100)
                            .padding(.bottom, 16)
                        
                        Button {
                            router.push(.recommend)
                        } label: {
                            Text("나만의 소확행 찾기")
                                .madiiFont(font: .madiiSubTitle, color: .madiiStrong)
                                .padding(.vertical, 16)
                                .frame(maxWidth: .infinity)
                                .background(.gray100.opacity(0.52))
                                .cornerRadius(20)
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("행복을 재생해요")
                        .madiiFont(font: .madiiSubTitle, color: .madiiNormal)
                        .padding(.top, 24)
                        .padding(.leading, 16)
                        .padding(.bottom, 32)
                        .padding(.horizontal, 8)
                    
                    ForEach(albums, id: \.self) { album in
                        Button {
                            AnalyticsManager.shared.logEvent(name: "앨범 선택")
                            router.push(.albumDetail(albumId: album.id, popNum: 1))
                        } label: {
                            HStack(spacing: 12) {
                                Image("Cover\(album.backgroundColorNum)")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .cornerRadius(12)
                                
                                Text(album.title)
                                    .madiiFont(font: .madiiBody2, color: .madiiNormal)
                                    .lineSpacing(9.6)
                                
                                Spacer()
                                
                                Image("caretRight")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 20)
                    }
                    .padding(.bottom, 4)
                    
                    Button {
                        router.push(.allAlbumList)
                    } label: {
                        Text("더보기")
                            .madiiFont(font: .madiiSubTitle, color: .madiiContrast)
                            .frame(maxWidth: .infinity)
                            .padding(.top, 16)
                            .padding(.bottom, 20)
                            .background(.madiiGreen100)
                    }
                }
                .background(.madiiElevated)
                .cornerRadius(40)
                .overlay(
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(
                            LinearGradient(
                                gradient: Gradient(stops: [
                                    .init(color: Color(red: 1.0, green: 1.0, blue: 1.0).opacity(0.1), location: 0.0),   // FFFFFF
                                    .init(color: Color(red: 0.239, green: 0.761, blue: 1.0).opacity(0.1), location: 0.33), // 3DC2FF
                                    .init(color: Color(red: 0.831, green: 0.471, blue: 1.0).opacity(0.1), location: 0.66), // D478FF
                                    .init(color: Color(red: 1.0, green: 1.0, blue: 1.0).opacity(0.1), location: 1.0)
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1
                        )
                )
                .padding(.horizontal, 20)
            }
            
            Spacer()
                .frame(height: 100)
        }
        .scrollIndicators(.hidden)
        .onAppear {
            getAllAlbums()
            AnalyticsManager.shared.logEvent(name: "탐색 진입")
        }
    }
    
    func getAllAlbums() {
        HomeAPI.shared.getAllAlbums(albumId: nil, size: 6) { isSuccess, allAlbums in
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
