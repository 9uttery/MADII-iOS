//
//  AlbumDetailsView.swift
//  Madii
//
//  Created by 정태우 on 7/22/25.
//

import MadiiDesignSystem
import SwiftUI

struct AlbumDetailView_P3: View {
    @State private var viewModel: AlbumDetailViewModel_P3
    
    init(viewModel: AlbumDetailViewModel_P3) {
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 12) {
                Button {
                    viewModel.action(.popView)
                } label: {
                    Image("arrowBack")
                        .resizable()
                        .frame(width: 24, height: 24)
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image("ellipsis")
                        .resizable()
                        .frame(width: 40, height: 40)
                }
                
                if !viewModel.isMine {
                    Button {
                        
                    } label: {
                        Image("bookmark")
                            .resizable()
                            .frame(width: 40, height: 40)
                    }
                }
            }
            .padding(.horizontal, 20)
            
            ScrollView {
                VStack {
                    Image("Cover\(viewModel.albumCoverId)")
                        .resizable()
                        .frame(width: 200, height: 200)
                        .cornerRadius(40)
                        .padding(.bottom, 40)
                    
                    Text(viewModel.albumTitle)
                        .madiiFont(font: .madiiSubTitle, color: .madiiNormal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 4)
                    
                    Text(viewModel.albumDescription)
                        .madiiFont(font: .caption, color: .white.opacity(0.43))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 20)
                    
                    VStack(spacing: 0) {
                        ForEach(viewModel.joyResponses, id: \.joyId) { joy in
                            HStack(spacing: 12) {
                                Circle()
                                    .foregroundStyle(.madiiYellowGreen)
                                    .frame(width: 10, height: 10)
                                
                                Text(joy.contents)
                                    .madiiFont(font: .madiiBody2, color: .madiiNormal)
                                
                                Spacer()
                                
                                Image("ellipsis")
                                    .frame(width: 28, height: 28)
                                    .foregroundStyle(.madiiAlternative)
                            }
                        }
                        
                        HStack(spacing: 8) {
                            Button {
                                viewModel.action(.addJoy)
                            } label: {
                                Image("plusSquare")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .foregroundStyle(.madiiAlternative)
                            }
                            
                            TextField("행복 추가하기", text: $viewModel.joyTitle)
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
                        ForEach(viewModel.albums) { album in
                            HStack(spacing: 12) {
                                Image("Cover\(album.backgroundColorNum)")
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
        }
        .onAppear {
            viewModel.action(.loadAlbum)
        }
    }
}
