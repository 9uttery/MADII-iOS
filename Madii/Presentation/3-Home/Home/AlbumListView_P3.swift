//
//  AlbumListView_P3.swift
//  Madii
//
//  Created by 정태우 on 7/21/25.
//

import MadiiDesignSystem
import SwiftUI

struct AlbumListView_P3: View {
    @State private var viewModel: AlbumListViewModel_P3
    @State var showDeleteAlbumsBottomSheet: Bool = false
    @State var isDismiss: Bool = false
    @State var showSuccessToast: Bool = false
    
    init(viewModel: AlbumListViewModel_P3) {
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                ZStack {
                    HStack {
                        Button {
                            viewModel.action(viewModel.isSelect ? .toggleSelect : .popView)
                        } label: {
                            if viewModel.isSelect {
                                Text("취소")
                                    .madiiFont(.body3)
                                    .foregroundStyle(.madiiNormal)
                                    .padding(.vertical, 4)
                                    .padding(.horizontal, 12)
                                    .background(.madiiContrast)
                                    .cornerRadius(10)
                            } else {
                                Image("arrowBack")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .opacity(0.43)
                            }
                        }

                        Spacer()

                        Button {
                            viewModel.isSelect
                            ? showDeleteAlbumsBottomSheet = true
                            : viewModel.action(.toggleSelect)
                        } label: {
                            if viewModel.isSelect {
                                Text("삭제")
                                    .madiiFont(.body3)
                                    .foregroundStyle(.madiiStrong)
                                    .padding(.vertical, 4)
                                    .padding(.horizontal, 12)
                                    .background(viewModel.selectedAlbums.isEmpty ? .madiiContrast : .madiiNegative)
                                    .cornerRadius(10)
                            } else {
                                Text("편집")
                                    .madiiFont(.body3)
                                    .foregroundStyle(.madiiNormal)
                                    .padding(.vertical, 4)
                                    .padding(.horizontal, 12)
                                    .background(.madiiBox)
                                    .cornerRadius(10)
                            }
                        }
                    }

                    Text("행복 앨범")
                        .madiiFont(.subTitle)
                        .foregroundStyle(.white.opacity(0.97))
                }
                .padding(.horizontal, 20)
                .frame(height: 64)
                ScrollView {
                    LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 0, alignment: .top), count: 2), spacing: 24) {
                        VStack(alignment: .leading, spacing: 12) {
                            Button {
                                viewModel.action(.createAlbum)
                            } label: {
                                Image("plusStroke")
                                    .resizable()
                                    .foregroundStyle(.madiiGreen100)
                                    .frame(width: 48, height: 48)
                                    .padding(UIScreen.main.bounds.width / 4 - 37)
                                    .background(.gray100.opacity(0.08))
                                    .cornerRadius(32)
                            }
                            
                            Text("새로운 앨범")
                                .madiiFont(.caption)
                                .foregroundStyle(.madiiGreen100)
                                .frame(height: 22, alignment: .center)
                                .padding(.horizontal, 8)
                        }
                        .frame(height: UIScreen.main.bounds.width / 2 + 8)
                        
                        ForEach(viewModel.albums) { album in
                            Button {
                                if viewModel.isSelect {
                                    viewModel.action(.selectAlbum(album: album))
                                } else {
                                    viewModel.action(.showAlbumDetail(album: album))
                                }
                            } label: {
                                VStack(alignment: .leading, spacing: 12) {
                                    ZStack(alignment: .topTrailing) {
                                        Image("Cover\(album.backgroundColorNum)")
                                            .resizable()
                                            .frame(width: (UIScreen.main.bounds.width - 52) / 2, height: (UIScreen.main.bounds.width - 52) / 2)
                                            .cornerRadius(32)
                                        
                                        if viewModel.isSelect {
                                            if viewModel.selectedAlbums.contains(album) {
                                                Image(systemName: "checkmark.circle")
                                                    .resizable()
                                                    .frame(width: 24, height: 24)
                                                    .padding([.top, .trailing], 14)
                                            } else {
                                                Image(systemName: "circle")
                                                    .resizable()
                                                    .frame(width: 24, height: 24)
                                                    .padding([.top, .trailing], 14)
                                            }
                                        }
                                    }
                                    
                                    Text(album.title)
                                        .madiiFont(.body3)
                                        .foregroundStyle(.white)
                                        .multilineTextAlignment(.leading)
                                        .frame(maxWidth: 152, alignment: .leading)
                                        .padding(.horizontal, 8)
                                }
                                .opacity(!viewModel.isSelect || viewModel.selectedAlbums.contains(album) ? 1.0 : 0.4)
                            }
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .onChange(of: showDeleteAlbumsBottomSheet) {
                    viewModel.action(.loadAlbums)
                }
                .onChange(of: viewModel.showNewAlbumBottomSheet) {
                    viewModel.action(.loadAlbums)
                }
                .onChange(of: isDismiss) {
                    if isDismiss {
                        viewModel.isSelect = false
                    }
                }
                .onAppear {
                    viewModel.action(.loadAlbums)
                }
            }
            if showSuccessToast {
                MadiiDesignSystem.MadiiToast(title: "앨범에 저장되었어요", isShowToast: $showSuccessToast)
                    .padding(.bottom, 100)
            }
        }
        .opacity(showDeleteAlbumsBottomSheet || viewModel.showNewAlbumBottomSheet ? 0.8 : 1)
        .sheet(isPresented: $showDeleteAlbumsBottomSheet) {
            GeometryReader { geo in
                DeleteAlbumBottomSheet(showDeleteAlbumBottomSheet: $showDeleteAlbumsBottomSheet, isDismiss: $isDismiss, albums: $viewModel.selectedAlbums)
                    .presentationDetents([.height(306 + geo.safeAreaInsets.bottom)])
                    .presentationDragIndicator(.hidden)
                    .presentationBackground(.clear)
            }
        }
        .sheet(isPresented: $viewModel.showNewAlbumBottomSheet) {
            GeometryReader { geo in
                AddNewAlbumBottomSheet(showAddNewAlbumBottomSheet: $viewModel.showNewAlbumBottomSheet, showSuccessToast: $showSuccessToast, album: .constant(Album(id: 0, title: "")))
                    .presentationDetents([.height(503)])
                    .presentationDragIndicator(.hidden)
                    .presentationBackground(.clear)
            }
        }
    }
}
