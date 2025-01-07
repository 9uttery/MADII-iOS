//
//  HomePlayJoyListView.swift
//  Madii
//
//  Created by 정태우 on 12/23/23.
//

import SwiftUI

struct HomePlayJoyListView: View {
    @EnvironmentObject var appStatus: AppStatus
    @State var playAlbums: [GetAlbumsResponse] = []
    @State private var showAddAlbumPopUp: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(alignment: .center) {
                    VStack(spacing: 12) {
                        ForEach(playAlbums) { album in
                            let newAlbum = Album(id: album.albumId, backgroundColorNum: album.albumColorNum, iconNum: album.joyIconNum, title: album.name)
                            
                            NavigationLink {
                                AlbumDetailView(album: newAlbum, fromPlayJoy: true)
                            } label: {
                                AlbumRow(album: newAlbum)
                            }
                            .simultaneousGesture(TapGesture().onEnded {
                                AnalyticsManager.shared.logEvent(name: "행복을재생해요뷰_앨범클릭")
                                AnalyticsManager.shared.logEvent(name: "행복을재생해요뷰_\(album.name)클릭")
                            })
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
                    
                    Button {
                        withoutAnimation {
                            showAddAlbumPopUp = true
                        }
                        AnalyticsManager.shared.logEvent(name: "행복을재생해요뷰_나만의소확행앨범만들기클릭")
                    } label: {
                        Text("나만의 소확행 앨범 만들기")
                            .madiiFont(font: .madiiBody5, color: .darkYellowGreen)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 20)
                            .frame(width: 178, height: 44)
                            .background(Color.madiiYellowGreen)
                            .cornerRadius(90)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 44)
            }
            .scrollIndicators(.never)
            
            // 신고 완료 토스트
            if appStatus.showReportToast { ReportAlbumToast() }
        }
        .navigationTitle("행복을 재생해요")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            getAlbums()
        }
        .onDisappear {
            appStatus.isNaviPlayJoy = false
        }
        .navigationBarItems(trailing: addButton)
        .transparentFullScreenCover(isPresented: $showAddAlbumPopUp) {
            AddAlbumPopUp(showAddAlbumPopUp: $showAddAlbumPopUp) }
        .analyticsScreen(name: "행복을 재생해요뷰")
    }
    
    private var addButton: some View {
        Button {
            withoutAnimation {
                showAddAlbumPopUp = true
                AnalyticsManager.shared.logEvent(name: "행복을재생해요뷰_추가클릭")
            }
        } label: {
            Text("추가")
                .madiiFont(font: .madiiBody5, color: .darkYellowGreen)
                .padding(.vertical, 6)
                .padding(.horizontal, 12)
                .frame(width: 48, height: 32)
                .background(Color.madiiYellowGreen)
                .cornerRadius(6)
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
