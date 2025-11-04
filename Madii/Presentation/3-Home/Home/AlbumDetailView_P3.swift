//
//  AlbumDetailsView.swift
//  Madii
//
//  Created by 정태우 on 7/22/25.
//

import MadiiDesignSystem
import SwiftUI

struct AlbumDetailView_P3: View {
    @Environment(Router.self) var router
    @State private var viewModel: AlbumDetailViewModel_P3
    @State private var selectedJoyId: Int = 0
    @State private var selectedJoyTitle: String = ""
    @State private var showJoyOptionBottomSheet = false
    @State private var showEditJoyBottomSheet = false
    @State private var showDeleteJoyBottomSheet = false
    @State private var isDuplicated = false
    @State private var isPlayJoy = false
    @State private var showJoyEllipsisBottomSheet = false
    @State private var showAlbumSavedBottomSheet = false
    @State private var showReportAlbumBottomSheet = false
    @State private var showReportReasonBottomSheet = false
    @State private var showReportToast = false
    @State private var showAlbumOptionBottomSheet = false
    @State private var showAlbumChangePublicBottomSheet = false
    @State private var showDeleteAlbumBottomSheet = false
    @State private var tempJoyIdCounter: Int = -1
    @State private var isDismiss: Bool = false

    init(viewModel: AlbumDetailViewModel_P3) {
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                header
                ScrollView { content }
                    .scrollIndicators(.hidden)
            }
            toastLayer
        }
        .dismissKeyboardOnTap() 
        .onAppear(perform: onAppear)
        .onAppear {
            print(viewModel.albumCoverId)
        }
        .onChange(of: showJoyOptionBottomSheet) { viewModel.action(.loadAlbum) }
        .onChange(of: showEditJoyBottomSheet) {
            viewModel.action(.loadAlbum)
            print("\(Date())안녕 \(showEditJoyBottomSheet)")
        }
        .onChange(of: isDismiss) {
            if isDismiss {
                router.pop()
            }
        }
        .onChange(of: viewModel.albumId) {
            viewModel.action(.loadAlbum)
        }
        .onChange(of: showDeleteJoyBottomSheet) { viewModel.action(.loadAlbum) }
        .onChange(of: showAlbumChangePublicBottomSheet) { viewModel.action(.loadAlbum) }
        .sheet(isPresented: $showJoyOptionBottomSheet) { joyOptionSheet }
        .sheet(isPresented: $showEditJoyBottomSheet) { editJoySheet }
        .sheet(isPresented: $showDeleteJoyBottomSheet) { deleteJoySheet }
        .sheet(isPresented: $showJoyEllipsisBottomSheet) { joyEllipsisSheet }
        .sheet(isPresented: $showReportAlbumBottomSheet) { reportAlbumSheet }
        .sheet(isPresented: $showAlbumSavedBottomSheet) { editJoySheet }
        .sheet(isPresented: $showReportReasonBottomSheet) { reportReasonSheet }
        .sheet(isPresented: $showAlbumOptionBottomSheet) { albumOptionSheet }
        .sheet(isPresented: $showAlbumChangePublicBottomSheet) { albumChangePublicSheet }
        .sheet(isPresented: $showDeleteAlbumBottomSheet) { deleteAlbumSheet }
    }
}

private extension AlbumDetailView_P3 {
    var header: some View {
        HStack(spacing: 12) {
            Button { router.pop(times: viewModel.popNum) } label: {
                Image("arrowBack")
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            
            Spacer()
            
            if viewModel.isEdit {
                Button(action: editAlbum) {
                    Text("완료")
                        .madiiFont(font: .madiiBody3, color: .madiiNormal)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 12)
                        .background(.madiiContrast)
                        .cornerRadius(10)
                }
            } else {
                Button {
                    if viewModel.isMine {
                        showAlbumOptionBottomSheet = true
                    } else {
                        showReportAlbumBottomSheet = true
                    }
                } label: {
                    Image("ellipsis")
                        .resizable()
                        .frame(width: 40, height: 40)
                }
                
                if !viewModel.isMine {
                    Button {
                        viewModel.isAlbumSaved.toggle()
                        viewModel.isAlbumSaved ? postBookmark() : deleteBookmark()
                    } label: {
                        Image(viewModel.isAlbumSaved ? "bookmark_active" : "bookmark")
                            .resizable()
                            .frame(width: 40, height: 40)
                    }
                }
            }
        }
        .padding(.horizontal, 20)
        .frame(height: 64)
    }
    
    var content: some View {
        VStack(spacing: 0) {
            albumImage
            albumInfo.padding(.horizontal, 4)
            joysSection
            otherAlbumsSection
        }
        .padding(.horizontal, 20)
    }
    
    var albumImage: some View {
        Image("Cover\(viewModel.albumCoverId)")
            .resizable()
            .frame(width: 200, height: 200)
            .cornerRadius(40)
            .padding(.bottom, 40)
    }
    
    @ViewBuilder
    var albumInfo: some View {
        if viewModel.isEdit {
            Text("앨범 제목")
                .madiiFont(font: .madiiBody2, color: .madiiNeutral)
                .lineSpacing(9.6)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 4)
            
            MadiiDesignSystem.MadiiTextField(
                text: $viewModel.newAlbumTitle,
                placeholder: "앨범명을 작성해주세요"
            )
            .madiiFont(font: .madiiSubTitle, color: .madiiNormal)
            .padding(.bottom, 20)
            
            Text("앨범 설명")
                .madiiFont(font: .madiiBody2, color: .madiiNeutral)
                .lineSpacing(9.6)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 4)
            
            MadiiDesignSystem.MadiiTextField(
                text: $viewModel.newAlbumDescription,
                placeholder: "앨범 소개글을 작성해주세요"
            )
            .madiiFont(font: .caption, color: .white.opacity(0.43))
            .padding(.bottom, 20)
        } else {
            Text(viewModel.albumTitle)
                .madiiFont(font: .madiiSubTitle, color: .madiiNormal)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 4)
            
            Text(viewModel.albumDescription)
                .madiiFont(font: .caption, color: .white.opacity(0.43))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 20)
        }
    }
    
    @ViewBuilder
    var joysSection: some View {
        if viewModel.isEdit {
            VStack {
                List {
                    ForEach(viewModel.newJoys, id: \.joyId) { joy in
                        AlbumDetailJoyRowView(
                            joys: $viewModel.newJoys,
                            joy: .constant(joy),
                            selectedJoy: $viewModel.selectedJoy,
                            deleteIds: $viewModel.deleteIds
                        )
                        .padding(.horizontal, 8)
                        .frame(height: 40)
                    }
                }
                .listStyle(.plain)
                .frame(height: 56 * CGFloat(viewModel.newJoys.count))
                .environment(\.defaultMinListRowHeight, 40)
                .background(.madiiElevated)
                
                addJoyField
                    .padding(.horizontal, 16)
                    .frame(height: 50)
                    .padding(.bottom, 12)
            }
            .padding(.vertical, 16)
            .background(.madiiElevated)
            .cornerRadius(40)
        } else {
            VStack(spacing: 16) {
                ForEach(viewModel.joyResponses, id: \.joyId) { joy in
                    joyRow(joy)
                }
                
                if viewModel.isMine {
                    addJoyField
                }
            }
            .padding(.vertical, 28)
            .padding(.horizontal, 16)
            .background(.madiiElevated)
            .cornerRadius(32)
        }
    }
    
    func joyRow(_ joy: GetAlbumByIdResponseJoyInfo) -> some View {
        HStack(spacing: 12) {
            Circle()
                .foregroundStyle(joy.joyIconNum.intToColor)
                .frame(width: 12, height: 12)
            
            Text(joy.contents)
                .madiiFont(font: .madiiBody2, color: .madiiNormal)
                .lineSpacing(9.6)
            
            Spacer()
            
            Button {
                selectedJoyId = joy.joyId
                selectedJoyTitle = joy.contents
                if viewModel.isMine {
                    showJoyOptionBottomSheet = true
                } else {
                    showJoyEllipsisBottomSheet = true
                }
            } label: {
                Image("ellipsis")
                    .resizable()
                    .frame(width: 28, height: 28)
                    .foregroundStyle(.madiiAlternative)
            }
        }
        .padding(.horizontal, 8)
        .frame(height: 40)
    }
    
    var addJoyField: some View {
        HStack(spacing: 8) {
            Button {
                addJoy()
            } label: {
                Image("plusSquare")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(.madiiAlternative)
            }
            
            TextField("행복 추가하기", text: $viewModel.joyTitle)
                .madiiFont(font: .madiiBody2, color: .madiiNormal)
                .lineSpacing(9.6)
                .onSubmit {
                    addJoy()
                }
        }
        .padding(12)
        .background(.madiiGray30)
        .cornerRadius(12)
    }
    
    var otherAlbumsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("나를 위한 행복 앨범 모음")
                .madiiFont(font: .madiiSubTitle, color: .madiiNormal)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 4)
            
            VStack(alignment: .leading, spacing: 16) {
                ForEach(viewModel.albums) { album in
                    Button {
                        router.push(.albumDetail(albumId: album.id, popNum: viewModel.popNum + 1))
                    } label: {
                        HStack(spacing: 12) {
                            Image("Cover\(album.backgroundColorNum)")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .cornerRadius(12)
                            
                            Text(album.title)
                                .madiiFont(font: .madiiBody2, color: .madiiNormal)
                                .lineSpacing(9.6)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
            }
            .padding(.vertical, 28)
            .padding(.horizontal, 20)
            .background(.madiiBox)
            .cornerRadius(40)
        }
        .padding(.top, 40)
    }
}

private extension AlbumDetailView_P3 {
    var toastLayer: some View {
        Group {
            if isPlayJoy {
                MadiiDesignSystem.MadiiToast(title: "오늘의 플레이리스트에 추가되었어요", isShowToast: $isPlayJoy)
            }
            if isDuplicated {
                MadiiDesignSystem.MadiiToast(type: .error, title: "이미 플레이리스트에 있어요", isShowToast: $isDuplicated)
            }
            if showReportToast {
                MadiiDesignSystem.MadiiToast(title: "신고가 완료되었어요. 신고 처리가 완료되면\n알림함에서 결과를 확인할 수 있어요", isShowToast: $showReportToast)
            }
        }
    }
    
    // 각 sheet의 content를 작게 분리
    var joyOptionSheet: some View {
        GeometryReader { geo in
            JoyOptionBottomSheet(
                joyId: $selectedJoyId,
                joyTitle: $selectedJoyTitle,
                showJoyOptionBottomSheet: $showJoyOptionBottomSheet,
                showEditJoyBottomSheeet: $showEditJoyBottomSheet,
                showDeleteJoyBottomSheet: $showDeleteJoyBottomSheet,
                isDuplicated: $isDuplicated,
                isPlayJoy: $isPlayJoy
            )
            .presentationDetents([.height(313 + geo.safeAreaInsets.bottom)])
            .presentationDragIndicator(.hidden)
            .presentationBackground(.clear)
        }
    }
    
    var editJoySheet: some View {
        GeometryReader { geo in
            EditJoyBottomSheet(
                showEditJoyBottomSheet: $showEditJoyBottomSheet,
                joyId: $selectedJoyId,
                joyTitle: $selectedJoyTitle
            )
            .presentationDetents([.height(564 + geo.safeAreaInsets.bottom)])
            .presentationDragIndicator(.hidden)
            .presentationBackground(.clear)
        }
    }
    
    var deleteJoySheet: some View {
        GeometryReader { geo in
            DeleteJoyBottomSheet(showDeleteJoyBottomSheet: $showDeleteJoyBottomSheet, joyId: $selectedJoyId)
                .presentationDetents([.height(280 + geo.safeAreaInsets.bottom)])
                .presentationDragIndicator(.hidden)
                .presentationBackground(.clear)
        }
    }
    
    var joyEllipsisSheet: some View {
        GeometryReader { geo in
            JoyEllipsisBottomSheet(
                joyId: $selectedJoyId,
                joyTitle: $selectedJoyTitle,
                showJoyEllipsisBottomSheet: $showJoyEllipsisBottomSheet,
                showAlbumSavedBottomSheet: $showAlbumSavedBottomSheet,
                isDuplicated: $isDuplicated,
                isPlayJoy: $isPlayJoy
            )
            .presentationDetents([.height(251 + geo.safeAreaInsets.bottom)])
            .presentationDragIndicator(.hidden)
            .presentationBackground(.clear)
        }
    }
    
    var reportAlbumSheet: some View {
        GeometryReader { geo in
            ReportAlbumBottomSheet(
                albumTitle: viewModel.albumTitle,
                showReportAlbumBottomSheet: $showReportAlbumBottomSheet,
                showReportReasonBottomSheet: $showReportReasonBottomSheet
            )
            .presentationDetents([.height(197 + geo.safeAreaInsets.bottom)])
            .presentationDragIndicator(.hidden)
            .presentationBackground(.clear)
        }
    }
    
    var reportReasonSheet: some View {
        GeometryReader { geo in
            ReportReasonBottomSheet(
                albumId: $viewModel.albumId,
                showReportReasonBottomSheet: $showReportReasonBottomSheet,
                showReportToast: $showReportToast
            )
            .presentationDetents([.height(560 + geo.safeAreaInsets.bottom)])
            .presentationDragIndicator(.hidden)
            .presentationBackground(.clear)
        }
    }
    
    var albumOptionSheet: some View {
        AlbumOptionBottomSheet(
            isPublic: $viewModel.isPublic,
            albumTitle: $viewModel.albumTitle,
            albumDescription: $viewModel.albumDescription,
            showAlbumOptionBottomSheet: $showAlbumOptionBottomSheet,
            isEdit: $viewModel.isEdit,
            joyTitle: $viewModel.joyTitle,
            showDeleteAlbumBottomSheet: $showDeleteAlbumBottomSheet,
            showAlbumChangePublicBottomSheet: $showAlbumChangePublicBottomSheet
        )
        .presentationDetents([.height(339)])
        .presentationDragIndicator(.hidden)
        .presentationBackground(.clear)
    }
    
    var albumChangePublicSheet: some View {
        GeometryReader { geo in
            AlbumChangePublicBottomSheet(showAlbumChangePublicBottomSheet: $showAlbumChangePublicBottomSheet, albumId: $viewModel.albumId)
                .presentationDetents([.height(280 + geo.safeAreaInsets.bottom)])
                .presentationDragIndicator(.hidden)
                .presentationBackground(.clear)
        }
    }
    
    var deleteAlbumSheet: some View {
        GeometryReader { geo in
            // DeleteAlbumBottomSheet이 albums: Binding<[Album]>를 원하면 .constant로 전달
            DeleteAlbumBottomSheet(
                showDeleteAlbumBottomSheet: $showDeleteAlbumBottomSheet, isDismiss: $isDismiss,
                albums: .constant([Album(id: viewModel.albumId, title: viewModel.albumTitle)])
            )
            .presentationDetents([.height(306 + geo.safeAreaInsets.bottom)])
            .presentationDragIndicator(.hidden)
            .presentationBackground(.clear)
        }
    }
}

private extension AlbumDetailView_P3 {
    func onAppear() {
        viewModel.action(.loadAlbum)
        viewModel.action(.randomAlbums)
        viewModel.newAlbumTitle = viewModel.albumTitle
        viewModel.newAlbumDescription = viewModel.albumDescription
    }
    
    func postBookmark() {
        AlbumAPI.shared.postBookmarksByAlbumId(albumId: viewModel.albumId) { isSuccess in
            if isSuccess {
                print("Debug PostBookmarksByAlbumId: isSuccess true")
            } else {
                print("Debug PostBookmarksByAlbumId: isSuccess false")
            }
        }
    }
    
    func deleteBookmark() {
        AlbumAPI.shared.deleteBookmarksByAlbumId(albumId: viewModel.albumId) { isSuccess in
            if isSuccess {
                print("Debug DeleteBookmarksByAlbumId: isSuccess true")
            } else {
                print("Debug DeleteBookmarksByAlbumId: isSuccess false")
            }
        }
    }
    
    func editAlbum() {
        let serverJoys = viewModel.newJoys.enumerated().map { index, joyInfo in
            JoyResponse(
                joyId: joyInfo.joyId < 0 ? nil : joyInfo.joyId,
                contents: joyInfo.contents,
                joyOrder: index + 1
            )
        }
        AlbumAPI.shared.putAlbumsAll(albumId: viewModel.albumId, name: viewModel.newAlbumTitle, description: viewModel.newAlbumDescription, joys: serverJoys, deletedJoyIds: viewModel.deleteIds) { isSuccess in
            if isSuccess {
                print("DEBUG AlbumDetailView: 앨범 편집하기 success")
                viewModel.action(.loadAlbum)
                viewModel.isEdit = false
            } else {
                print("DEBUG AlbumDetailView: 앨범 편집하기 fail")
                viewModel.action(.loadAlbum)
            }
        }
    }
    
    private func addJoy() {
        guard !viewModel.joyTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }

        if viewModel.isEdit {
            let newJoy = GetAlbumByIdResponseJoyInfo(
                joyId: tempJoyIdCounter,
                joyIconNum: Int.random(in: 1...8),
                contents: viewModel.joyTitle,
                isJoySaved: false
            )
            viewModel.newJoys.append(newJoy)
            tempJoyIdCounter -= 1
            viewModel.joyTitle = ""
        } else {
            viewModel.action(.addJoy)
        }
    }
}
