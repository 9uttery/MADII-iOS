//
//  AlbumDetailView.swift
//  Madii
//
//  Created by 이안진 on 12/5/23.
//

import SwiftUI

struct AlbumDetailView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State var album: Album
    @State private var joys: [Joy] = Joy.manyAchievedDummy
    
    @State private var isAlbumMine: Bool = true
    @State private var isAlbumSaved: Bool = true
    
    @State private var selectedJoy: Joy?
    
    @State private var showReportSheet: Bool = false
    @State private var showReportPopUp: Bool = false
    
    @State private var showSettingSheet: Bool = false
    @State private var showChangeInfo: Bool = false
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    // 앨범 커버 & 저장 버튼
                    ZStack(alignment: .bottomTrailing) {
                        // 앨범 커버 이미지
                        AlbumDetailCoverView(album: album)
                        
                        // 저장 버튼
                        if isAlbumMine == false {
                            AlbumDetailBookmarkButton(albumId: album.id, isAlbumSaved: $isAlbumSaved)
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
                                            Image(joy.isSaved ? "inactiveSave" : "activeSave")
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
                        .sheet(item: $selectedJoy, content: { _ in
                            JoyMenuBottomSheet(joy: $selectedJoy, isMine: true)
                        })
                        .padding(.vertical, 20)
                        .background(Color.madiiBox)
                        .cornerRadius(20)
                        
                        // 다른 소확행 앨범 모음
                        AlbumDetailOtherAlbumsView(album: album)
                    }
                    .padding(.horizontal, 16)
                }
                // 스크롤 하단 여백 40
                .padding(.bottom, 40)
            }
            .scrollIndicators(.hidden)
            
            // 앨범 정보 수정
            if showChangeInfo {
                ChangeAlbumInfoPopUpView(showChangeInfo: $showChangeInfo)
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: showAlbumSheetButton)
        .toolbarBackground(Color.madiiBox, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .onAppear {
            getAlbumInfo()
            postRecentAlbum()
        }
        .sheet(isPresented: $showReportSheet) {
            GeometryReader { geo in
                ReportBottomSheet(album: album, showReportSheet: $showReportSheet, showReportPopUp: $showReportPopUp)
                    .presentationDetents([.height(160 + geo.safeAreaInsets.bottom)])
                    .presentationDragIndicator(.hidden)
            }
        }
        .sheet(isPresented: $showSettingSheet) {
            GeometryReader { geo in
                AlbumSettingBottomSheet(album: album, showAlbumSettingSheet: $showSettingSheet, showChangeInfo: $showChangeInfo, dismiss: dismissView)
                    .presentationDetents([.height(340 + geo.safeAreaInsets.bottom)])
                    .presentationDragIndicator(.hidden)
            }
        }
    }
    
    private func dismissView() {
        dismiss()
    }
    
    private var showAlbumSheetButton: some View {
        Button {
            if isAlbumMine {
                // 내 앨범이면 설정
                showSettingSheet = true
            } else {
                // 다른 사람 앨범이면 신고
                showReportSheet = true
            }
        } label: {
            Image(systemName: "ellipsis")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20)
                .foregroundStyle(Color.gray500)
                .padding(10)
        }
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
                
                // 앨범 설명
                album.description = albumInfo.description
                
                // 소확행 리스트
                joys = []
                for joy in albumInfo.joyInfoList {
                    let newJoy = Joy(joyId: joy.joyId, icon: joy.joyIconNum, title: joy.contents, isSaved: joy.isJoySaved ?? false)
                    joys.append(newJoy)
                }
            } else {
                print("DEBUG AlbumDetailView getAlbumInfos: isSuccess false")
            }
        }
    }
    
    private func postRecentAlbum() {
        AlbumAPI.shared.postRecentByAlbumId(albumId: album.id) { isSuccess in
            if isSuccess {
                print("DEBUG AlbumDetailView: 최근 본 앨범 등록 success")
            } else {
                print("DEBUG AlbumDetailView: 최근 본 앨범 등록 fail")
            }
        }
    }
}
