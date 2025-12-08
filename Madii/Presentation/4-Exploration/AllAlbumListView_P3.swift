//
//  AllAlbumListView_P3.swift
//  Madii
//
//  Created by 정태우 on 10/16/25.
//

import SwiftUI

struct AllAlbumListView_P3: View {
    @Environment(Router.self) var router
    @State var playAlbums: [GetAlbumsResponse] = []
    @State var showAddNewAlbumBottomSheet: Bool = false
    
    var body: some View {
        VStack {
            HStack(spacing: 12) {
                Button { router.pop() } label: {
                    Image("arrowBack")
                        .resizable()
                        .frame(width: 24, height: 24)
                }
                
                Spacer()
                
                Text("행복을 재생해요")
                    .madiiFont(font: .madiiSubTitle, color: .gray100.opacity(0.97))
                
                Spacer()
                
                Button {
                    showAddNewAlbumBottomSheet = true
                } label: {
                    Text("추가")
                        .madiiFont(font: .madiiBody3, color: .madiiContrast)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 12)
                        .background(.madiiGreen100)
                        .cornerRadius(10)
                }
                
            }
            .padding(.horizontal, 20)
            .frame(height: 64)
            .padding(.bottom, 12)
            
            ScrollView {
                VStack(spacing: 24) {
                    ForEach(playAlbums) { album in
                        Button {
                            router.push(.albumDetail(albumId: album.albumId, popNum: 1))
                        } label: {
                            HStack(spacing: 12) {
                                Image("Cover\(album.albumColorNum % 8 + 1)")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .cornerRadius(12)
                                
                                Text(album.name)
                                    .madiiFont(font: .madiiBody2, color: .madiiNormal)
                                    .multilineTextAlignment(.leading)
                                
                                Spacer()
                                
                                Image("caretRight")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                            }
                        }
                        .padding(.horizontal, 4)
                    }
                    
                    VStack(spacing: 0) {
                        Text("마지막이에요!\n나만의 소확행 앨범을 만들어보세요")
                            .madiiFont(font: .madiiBody3, color: .madiiNeutral)
                            .multilineTextAlignment(.center)
                            .padding(.top, 28)
                            .padding(.bottom, 16)
                        
                        Button {
                            showAddNewAlbumBottomSheet = true
                        } label: {
                            Text("소확행 앨범 추가")
                                .madiiFont(font: .madiiSubTitle, color: .madiiContrast)
                                .padding(.vertical, 16)
                                .padding(.horizontal, 24)
                                .background(.madiiGreen100)
                                .cornerRadius(20)
                        }
                        .padding(.bottom, 28)
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
        .padding(.horizontal, 20)
        .onAppear {
            getAlbums()
        }
        .onChange(of: showAddNewAlbumBottomSheet) {
            getAlbums()
        }
        .opacity(showAddNewAlbumBottomSheet ? 0.3 : 1)
        .sheet(isPresented: $showAddNewAlbumBottomSheet) {
            GeometryReader { geo in
                AddNewAlbumBottomSheet(showAddNewAlbumBottomSheet: $showAddNewAlbumBottomSheet, album: .constant(Album(id: 0, title: "")))
                    .presentationDetents([.height(503)])
                    .presentationDragIndicator(.hidden)
                    .presentationBackground(.clear)
            }
        }
    }
    
    private func getAlbums() {
        HomeAPI.shared.getAllAlbums(albumId: nil, size: 999) { isSuccess, allAlbum in
            if isSuccess {
                playAlbums = allAlbum.content
            } else {
                print("행복을 재생해요 - 전체 앨범 불러오기 실패")
            }
        }
    }
}

#Preview {
    AllAlbumListView_P3()
}
