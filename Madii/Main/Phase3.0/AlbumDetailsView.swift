//
//  AlbumDetailsView.swift
//  Madii
//
//  Created by 정태우 on 7/22/25.
//

import SwiftUI

struct AlbumDetailsView: View {
    @State var album: Album = Album.dummy1
    @State var joyTitle: String = ""
    @State var albums: [Album] = Album.dummy3
    @State var isMine: Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                Image("CoverA")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .cornerRadius(40)
                    .padding(.bottom, 40)
                
                Text(album.title)
                    .madiiFont(font: .madiiSubTitle, color: .madiiNormal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 4)
                
                Text(album.description)
                    .madiiFont(font: .caption, color: .white.opacity(0.43))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 20)
                
                HStack(spacing: 8) {
                    Button {
                        
                    } label: {
                        Image("plusSquare")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundStyle(.madiiAlternative)
                    }
                    
                    TextField("소확행 추가하기", text: $joyTitle)
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
                    ForEach(albums) { album in
                        HStack(spacing: 12) {
                            Image("CoverB")
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
                .padding(.horizontal, 16)
                .background(.madiiBox)
                .cornerRadius(40)
            }
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    AlbumDetailsView()
}
