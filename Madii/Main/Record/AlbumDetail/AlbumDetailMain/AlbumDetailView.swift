//
//  AlbumDetailView.swift
//  Madii
//
//  Created by 이안진 on 12/5/23.
//

import SwiftUI

struct AlbumDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var appStatus: AppStatus
    
    @State var album: Album
    @State private var joys: [Joy] = []
    
    @State private var isAlbumMine: Bool = true
    @State private var isAlbumSaved: Bool = true
    
    @State private var selectedJoy: Joy?
    @State private var joy: Joy = Joy(title: "")
    @State private var showSaveJoyPopUp: Bool = false
    @State private var showTodayPlaylist: Bool = false /// 오플리 sheet 열기
    
    @State private var showReportSheet: Bool = false
    @State private var showReportPopUp: Bool = false
    
    @State private var showSettingSheet: Bool = false
    @State private var showChangeInfo: Bool = false
    
    var fromPlayJoy: Bool = false
    
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
                                    Button {
                                        AchievementsAPI.shared.playJoy(joyId: joy.joyId) { isSuccess in
                                            if isSuccess {
                                                print("DEBUG AlbumDetailView: 오플리에 추가 true")
                                            } else {
                                                print("DEBUG AlbumDetailView: 오플리에 추가 false")
                                            }
                                        }
                                    } label: {
                                        JoyRowWithButton(joy: joy) {
                                            if isAlbumMine {
                                                // 나의 앨범: 소확행 메뉴 bottom sheet
                                                selectedJoy = joy
                                            } else {
                                                // 타인의 앨범: 소확행 저장 아이콘
                                                showSaveJoyPopUp = true
                                                self.joy = joy
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
                                                Image(joy.isSaved ? "activeSave" : "inactiveSave")
                                                    .resizable()
                                                    .frame(width: 36, height: 36)
                                            }
                                        }
                                    }
                                    .padding(.leading, 12)
                                    .padding(.trailing, 16)
                                    .padding(.vertical, 4)
                                }
                            }
                        }
                        .sheet(item: $selectedJoy, onDismiss: getAlbumInfo, content: { _ in
                            JoyMenuBottomSheet(joy: $selectedJoy, isMine: true)
                        })
                        .padding(.vertical, 20)
                        .background(Color.madiiBox)
                        .cornerRadius(20)
                        
                        // 다른 소확행 앨범 모음 - '행복을 재생해요' 에서만 띄우기
                        if fromPlayJoy {
                            AlbumDetailOtherAlbumsView(album: album, fromPlayJoy: fromPlayJoy)
                        }
                    }
                    .padding(.horizontal, 16)
                }
                // 스크롤 하단 여백 40
                .padding(.bottom, 40)
            }
            .scrollIndicators(.hidden)
            .refreshable { getAlbumInfo() }
            .onChange(of: showSaveJoyPopUp) { _ in
                // 소확행을 앨범에 저장하는 팝업이 사라지면 앨범정보 새로 부르기
                if showSaveJoyPopUp == false { getAlbumInfo() }
            }
            .onChange(of: showChangeInfo) { _ in
                // 앨범 정보를 수정하는 팝업이 사라지면 앨범정보 새로 부르기
                if showSaveJoyPopUp == false { getAlbumInfo() }
            }
            
            // 오플리 추가 안내 토스트
            if appStatus.showAddPlaylistToast {
                VStack {
                    Spacer()
                    AddTodayPlaylistBarToast(showTodayPlaylist: $showTodayPlaylist)
                }
             }
            
            // 앨범 정보 수정
            if showChangeInfo {
                ChangeAlbumInfoPopUpView(album: album, showChangeInfo: $showChangeInfo)
            }
            
            // 소확행을 앨범에 저장하는 팝업
            if showSaveJoyPopUp {
                SaveMyJoyPopUpView(joy: $joy, showSaveJoyToAlbumPopUp: $showSaveJoyPopUp, showSaveJoyPopUpFromRecordMain: .constant(false), fromAlbumSetting: true)
            }
            
            // 신고 완료 토스트
            if appStatus.showReportToast {
                VStack {
                    Spacer()
                    ReportAlbumToast()
                }
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
                ReportBottomSheet(album: album, showReportSheet: $showReportSheet, showReportPopUp: $showReportPopUp, dismissAlbumDetailView: dismissView)
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
        // 오늘의 소확행 오플리에 추가 후, 바로가기에서 sheet
        .sheet(isPresented: $showTodayPlaylist) {
            TodayPlaylistView(showPlaylist: $showTodayPlaylist) }
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
                    album.isPublic = albumInfo.isAlbumOfficial
                }
                
                // 앨범 설명
                album.title = albumInfo.name
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
