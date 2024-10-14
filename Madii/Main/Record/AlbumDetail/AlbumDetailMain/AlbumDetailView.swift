//
//  AlbumDetailView.swift
//  Madii
//
//  Created by 이안진 on 12/5/23.
//

import Combine
import SwiftUI

struct AlbumDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var appStatus: AppStatus
    @Environment(\.presentationMode) var presentationMode
    
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
    @State private var isAlbumEditMode: Bool = false
    @State private var showCloseEditAlbumPopUp: Bool = false
    @State private var isClose: Bool = false
    @State private var addJoyName: String = ""
    @FocusState private var isTextFieldFocused: Bool
    @State private var showChangeInfo: Bool = false
    @State private var keyboardHeight: CGFloat = 0
    @State private var isClickCompleteButton: Bool = false
    @State private var albumTitle: String = ""
    @State private var albumDescription: String = ""
    @State private var deletedJoyIds: [Int] = []
    @State private var joyResponses: [JoyResponse] = []
    
    var fromPlayJoy: Bool = false
    
    var body: some View {
        ZStack {
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        // 앨범 커버 & 저장 버튼
                        ZStack(alignment: .bottomTrailing) {
                            // 앨범 커버 이미지
                            AlbumDetailCoverView(album: album)
                            
                            if isAlbumMine == false {
                                AlbumDetailBookmarkButton(albumId: album.id, isAlbumSaved: $isAlbumSaved)
                                    .offset(x: -18, y: -12)
                                    .onChange(of: isAlbumSaved) { _ in getAlbumInfo() }
                            }
                        }
                        
                        editModeAlbumInform(title: album.title, description: album.description)
                        
                        editModeJoyRow(joys: joys)
                            .padding(.horizontal, 16)
                            .id(1)
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
                .onChange(of: isAlbumEditMode) { _ in
                    // 앨범 정보를 수정하는 팝업이 사라지면 앨범정보 새로 부르기
                    if isAlbumEditMode == false { getAlbumInfo() }
                }
                .onChange(of: isTextFieldFocused) { _ in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.16) {
                        withAnimation {
                            proxy.scrollTo(1, anchor: .bottom)
                        }
                    }
                }
                .onChange(of: showChangeInfo) { _ in
                    // 앨범 정보를 수정하는 팝업이 사라지면 앨범정보 새로 부르기
                    if showSaveJoyPopUp == false { getAlbumInfo() }
                }
            }
            
            // 오플리 추가 안내 토스트
            if appStatus.showAddPlaylistToast {
                VStack {
                    Spacer()
                    AddTodayPlaylistBarToast(showTodayPlaylist: $showTodayPlaylist)
                }
            }
            
            // 오플리 중복 안내 토스트
            if appStatus.isDuplicate {
                VStack {
                    Spacer()
                    JoyDuplicateToast()
                }
            }
            
            // 소확행 앨범에 저장 안내토스트
            if appStatus.showSaveJoyToast {
                VStack {
                    Spacer()
                    SaveAlbumJoyToast()
                }
            }
            
            // 소확행을 앨범에 저장하는 팝업
            if showSaveJoyPopUp { SaveMyJoyPopUpView(joy: $joy, showSaveJoyToAlbumPopUp: $showSaveJoyPopUp, showSaveJoyPopUpFromRecordMain: .constant(false), fromAlbumSetting: true) }
            
            if showCloseEditAlbumPopUp { CloseEditAlbumPopUp(showCloseEditAlbumPopUp: $showCloseEditAlbumPopUp, isClose: $isClose) }
            
            // 신고 완료 토스트
            if appStatus.showReportToast {
                VStack {
                    Spacer()
                    ReportAlbumToast()
                }
            }
            
            NavigationLink(
                destination: RecommendView(),
                isActive: $appStatus.isNaviRecommend
            ) {
                EmptyView() // 자동으로 화면 전환을 트리거하는 빈 뷰
            }
            
            NavigationLink(
                destination: HomePlayJoyListView(),
                isActive: $appStatus.isNaviPlayJoy
            ) {
                EmptyView() // 자동으로 화면 전환을 트리거하는 빈 뷰
            }
            
            // 앨범 저장 토스트
            if appStatus.showSaveAlbumToast {
                VStack {
                    Spacer()
                    ToastMessage(title: "레코드에 앨범이 저장되었어요")
                        .padding(.horizontal, 16)
                }
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: showAlbumSheetButton)
        .toolbarBackground(Color.madiiBox, for: .navigationBar)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button {
            if isAlbumEditMode {
                showCloseEditAlbumPopUp = true
            } else {
                presentationMode.wrappedValue.dismiss()
            }
        } label: {
            Image(systemName: "chevron.left")
        })
        .toolbarBackground(.visible, for: .navigationBar)
        .onAppear {
            getAlbumInfo()
            postRecentAlbum()
        }
        .onChange(of: isClose) { _ in
            presentationMode.wrappedValue.dismiss()
        }
        .onChange(of: isAlbumEditMode) { _ in
            if isAlbumEditMode {
                albumTitle = album.title
                albumDescription = album.description
            } else {
                for (index, joy) in joys.enumerated() {
                    joys[index].joyOrder = index + 1
                }
                print(joys)
                joyResponses = joys.map { $0.toJoyResponse() }
                print("안녕하세요 조이리스판스입니다\(joyResponses)")
                print("deleteIds입니다\(deletedJoyIds)")
                putAlbumsAll()
                getAlbumInfo()
            }
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
                AlbumSettingBottomSheet(album: album, showAlbumSettingSheet: $showSettingSheet, showChangeInfo: $showChangeInfo, isAlbumEditMode: $isAlbumEditMode, dismiss: dismissView)
                    .presentationDetents([.height(280 + geo.safeAreaInsets.bottom)])
                    .presentationDragIndicator(.hidden)
            }
        }
        .sheet(isPresented: $showTodayPlaylist) {
            TodayPlaylistView(showPlaylist: $showTodayPlaylist) }
        .analyticsScreen(name: "앨범상세뷰")
    }
    
    @ViewBuilder
    private func albumDetailJoyRow(joy: Joy) -> some View {
        JoyRowWithButton(joy: joy) {
            if !isAlbumEditMode {
                selectedJoy = joy
                AnalyticsManager.shared.logEvent(name: "앨범상세뷰_ellipsis클릭")
            }
        } buttonLabel: {
            Image(systemName: isAlbumEditMode ? "line.3.horizontal" : "ellipsis")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20)
                .foregroundStyle(Color.gray500)
                .padding(10)
        }
    }
    
    private func editModeAlbumInform(title: String, description: String) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            if !isAlbumEditMode {
                Text(title)
                    .madiiFont(font: .madiiTitle, color: .white)
                    .padding(.bottom, 12)
                
                VStack(alignment: .leading, spacing: 4) {
                    if isAlbumMine == false { Text("\(album.creator)님") }
                    Text(description)
                }
                .madiiFont(font: .madiiBody4, color: .white.opacity(0.6))
            } else {
                VStack(alignment: .leading, spacing: 8) {
                    Text("앨범 제목")
                        .madiiFont(font: .madiiBody2, color: .white)
                    
                    TextField(title, text: $albumTitle)
                        .madiiFont(font: .madiiBody3, color: .white)
                        .frame(maxWidth: .infinity)
                        .padding(12)
                        .background(Color.buttonGray)
                        .cornerRadius(4)
                }
                .padding(.bottom, 28)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("앨범 설명")
                        .madiiFont(font: .madiiBody2, color: .white)
                    
                    TextField(description, text: $albumDescription, axis: .vertical)
                            .lineLimit(2, reservesSpace: true)
                            .madiiFont(font: .madiiBody3, color: .white)
                            .frame(maxWidth: .infinity)
                            .padding(12)
                            .background(Color.buttonGray)
                            .cornerRadius(4)
                }
            }
        }
        .padding(.top, 20)
        .padding(.horizontal, 24)
        .padding(.bottom, 40)
    }
    
    private func editModeJoyRow(joys: [Joy]) -> some View {
        VStack {
            List {
                ForEach(joys) { joy in
                    Group {
                        if !isAlbumEditMode {
                            Button {
                                playJoy(joy: joy)
                            } label: {
                                albumDetailJoyRow(joy: joy)
                            }
                        } else {
                            albumDetailJoyRow(joy: joy)
                        }
                    }
                    .listRowBackground(Color.madiiBox)
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 16))
                    .if(isAlbumEditMode) { view in
                        view.swipeActions(edge: .trailing) {
                            Button {
                                if let index = joys.firstIndex(where: { $0.joyId == joy.joyId }) {
                                    self.joys.remove(at: index)
                                    deletedJoyIds.append(joy.joyId ?? 0)
                                }
                            } label: {
                                Label("Trash", systemImage: "trash")
                            }
                            .tint(Color(red: 1.0, green: 0.231, blue: 0.188))
                        }
                    }
                }
                .onMove(perform: move)
                
                if isAlbumEditMode {
                    HStack(spacing: 16) {
                        Button {
                            if isTextFieldFocused {
                                self.joys.append(Joy(joyId: nil, title: addJoyName))
                                addJoyName = ""
                            }
                            isTextFieldFocused.toggle()
                        } label: {
                            Image("plus")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundStyle(isTextFieldFocused ? Color.buttonGray : Color.gray500)
                                .padding(14)
                                .background(isTextFieldFocused ? Color.madiiYellowGreen : Color.buttonGray)
                                .cornerRadius(90)
                        }
                        ZStack {
                            TextField("소확행 추가하기", text: $addJoyName)
                                .madiiFont(font: .madiiBody3, color: .white)
                                .frame(maxWidth: .infinity)
                                .focused($isTextFieldFocused)
                            
                            if isTextFieldFocused {
                                Rectangle()
                                    .frame(height: 1)
                                    .frame(maxWidth: .infinity)
                                    .padding(.top, 47)
                                    .foregroundColor(.madiiYellowGreen)
                            }
                        }
                        .padding(.trailing, 16)
                    }
                    .listRowBackground(Color.madiiBox)
                    .listRowInsets(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 16))
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
            .frame(maxWidth: .infinity)
            .frame(height: isAlbumEditMode ? 64 * CGFloat(joys.count + 1) : 64 * CGFloat(joys.count))
            .environment(\.defaultMinListRowHeight, 64)
        }
        .padding(.vertical, 20)
        .background(Color.madiiBox)
        .cornerRadius(20)
        .sheet(item: $selectedJoy, onDismiss: getAlbumInfo) { _ in
            JoyMenuBottomSheet(joy: $selectedJoy, isMine: isAlbumMine)
        }
    }
    
    func move(from source: IndexSet, to destination: Int) {
        joys.move(fromOffsets: source, toOffset: destination)
    }
    
    private func dismissView() {
        dismiss()
    }
    
    private var showAlbumSheetButton: some View {
        Button {
            if isAlbumEditMode {
                isClickCompleteButton = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    isAlbumEditMode = false
                    isClickCompleteButton = false
                }
            } else if isAlbumMine {
                showSettingSheet = true
            } else {
                showReportSheet = true
            }
            AnalyticsManager.shared.logEvent(name: "앨범상세뷰_내비게이션바ellipsis클릭")
        } label: {
            if isClickCompleteButton {
                Image("gear")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .rotationEffect(.degrees(isClickCompleteButton ? 360 : 0)) // 360도 회전
                    .animation(.linear(duration: 1).repeatForever(autoreverses: false), value: isClickCompleteButton)
            } else if isAlbumEditMode {
                Text("완료")
                    .madiiFont(font: .madiiBody1, color: .gray200)
            } else {
                Image(systemName: "ellipsis")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .foregroundStyle(Color.gray500)
                    .padding(10)
            }
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
    
    private func putAlbumsAll() {
        AlbumAPI.shared.putAlbumsAll(albumId: album.id, name: albumTitle, description: albumDescription, joys: joyResponses, deletedJoyIds: deletedJoyIds) { isSuccess in
            if isSuccess {
                print("DEBUG AlbumDetailView: 앨범 편집하기 success")
                getAlbumInfo()
            } else {
                print("DEBUG AlbumDetailView: 앨범 편집하기 fail")
                getAlbumInfo()
            }
        }
    }
    
    private func playJoy(joy: Joy) {
        AchievementsAPI.shared.playJoy(joyId: joy.joyId ?? 0) { isSuccess, isDuplicate in
            if isSuccess {
                print("DEBUG AlbumDetailView: 오플리에 추가 true")
                
                // 오플리 추가 안내 토스트 띄우기
                withAnimation {
                    appStatus.showAddPlaylistToast = true
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        appStatus.showAddPlaylistToast = false
                    }
                }
            } else if isDuplicate {
                withAnimation {
                    appStatus.isDuplicate = true
                }
                print("DEBUG AlbumDetailView playJoy: isSuccess false and isDuplicate true")

                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        appStatus.isDuplicate = false
                    }
                }
            } else {
                print("DEBUG AlbumDetailView: 오플리에 추가 false")
            }
        }
    }
}

extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
