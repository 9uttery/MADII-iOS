//
//  MadiiAlbumListView.swift
//  Madii
//
//  Created by 정태우 on 7/21/25.
//

import SwiftUI

struct MadiiAlbumListView: View {
    @State private var albums: [Album] = Album.dummy10
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "arrow.left")
                
                Spacer()
                
                Text("소확행 앨범")
                    .madiiFont(font: .madiiSubTitle, color: .white.opacity(0.97))
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("선택")
                        .madiiFont(font: .madiiBody3, color: .white)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 12)
                        .background(.madiiBox)
                        .cornerRadius(10)
                }
            }
            
            ScrollView {
                LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 0, alignment: .top), count: 2), spacing: 24) {
                    VStack(alignment: .leading, spacing: 12) {
                        Button {
                            // 라우터 처리
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
                    
                    ForEach(albums) { album in
                        Button {
                            // 라우터 처리
                        } label: {
                            VStack(alignment: .leading, spacing: 12) {
                                Image("CoverA")
                                //                            Image("\(album.iconNum)")
                                    .frame(width: 152, height: 152)
                                    .cornerRadius(32)
                                
                                Text(album.title)
                                    .madiiFont(font: .madiiBody3, color: .white)
                                    .multilineTextAlignment(.leading)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    MadiiAlbumListView()
}
