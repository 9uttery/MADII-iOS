//
//  AlbumListView_P3.swift
//  Madii
//
//  Created by 정태우 on 7/21/25.
//

import SwiftUI

struct AlbumListView_P3: View {
    @State private var viewModel: AlbumListViewModel_P3
    @State var showDeleteAlbumsBottomSheet: Bool = false
    
    init(viewModel: AlbumListViewModel_P3) {
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    viewModel.action(viewModel.isSelect ? .toggleSelect : .popView)
                } label: {
                    if viewModel.isSelect {
                        Text("취소")
                            .madiiFont(font: .madiiBody3, color: .madiiNormal)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 12)
                            .background(.madiiContrast)
                            .cornerRadius(10)
                    } else {
                        Image("arrowBack")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                }
                
                Spacer()
                
                Text("소확행 앨범")
                    .madiiFont(font: .madiiSubTitle, color: .white.opacity(0.97))
                
                Spacer()
                
                Button {
                    viewModel.isSelect
                        ? showDeleteAlbumsBottomSheet = true
                        : viewModel.action(.toggleSelect)
                } label: {
                    if viewModel.isSelect {
                        Text("삭제")
                            .madiiFont(font: .madiiBody3, color: .madiiStrong)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 12)
                            .background(viewModel.selectedAlbums.isEmpty ? .madiiContrast : .madiiNegative)
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
                    
                    if !viewModel.isSelect {
                        VStack(alignment: .leading, spacing: 12) {
                            Button {
                                viewModel.action(.createAlbum)
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
                    }
                    
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
                                        .frame(width: 152, height: 152)
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
                                    .madiiFont(font: .madiiBody3, color: .white)
                                    .multilineTextAlignment(.leading)
                                    .frame(maxWidth: 152, alignment: .leading)
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
            .onAppear {
                viewModel.action(.loadAlbums)
            }
        }
        .sheet(isPresented: $showDeleteAlbumsBottomSheet) {
            GeometryReader { geo in
                DeleteAlbumBottomSheet(showDeleteAlbumBottomSheet: $showDeleteAlbumsBottomSheet, albums: $viewModel.selectedAlbums)
                    .presentationDetents([.height(306 + geo.safeAreaInsets.bottom)])
                    .presentationDragIndicator(.hidden)
                    .presentationBackground(.clear)
            }
        }
        .sheet(isPresented: $viewModel.showNewAlbumBottomSheet) {
            GeometryReader { geo in
                AddNewAlbumBottomSheet(showAddNewAlbumBottomSheet: $viewModel.showNewAlbumBottomSheet)
                    .presentationDetents([.height(503)])
                    .presentationDragIndicator(.hidden)
                    .presentationBackground(.clear)
            }
        }
    }
}
