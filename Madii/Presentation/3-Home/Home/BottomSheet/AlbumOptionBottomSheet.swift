//
//  AlbumOptionBottomSheet.swift
//  Madii
//
//  Created by 정태우 on 9/26/25.
//

import SwiftUI

struct AlbumOptionBottomSheet: View {
    @Binding var isPublic: Bool
    @Binding var albumTitle: String
    @Binding var albumDescription: String
    @Binding var showAlbumOptionBottomSheet: Bool
    @Binding var isEdit: Bool
    @Binding var joyTitle: String
    @Binding var showDeleteAlbumBottomSheet: Bool
    @Binding var showAlbumChangePublicBottomSheet: Bool
    
    var body: some View {
        VStack {
            Rectangle()
                .frame(width: 100, height: 5)
                .foregroundStyle(.madiiContrast)
                .cornerRadius(2.5)
                .padding(.top, 16)
            
            VStack(alignment: .leading, spacing: 0) {
                Text(albumTitle)
                    .madiiFont(.title1)
                    .foregroundStyle(.madiiNormal)
                    .padding(.top, 40)
                    .padding(.bottom, 10)
                
                Text(albumDescription)
                    .madiiFont(.body3)
                    .foregroundStyle(.madiiAlternative)
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, 40)
                
                Button {
                    isEdit = true
                    showAlbumOptionBottomSheet = false
                    joyTitle = ""
                } label: {
                    Text("앨범 편집")
                        .madiiFont(.body1)
                        .foregroundStyle(.madiiNormal)
                }
                .padding(.bottom, 28)
                
                Button {
                    showAlbumOptionBottomSheet = false
                    showDeleteAlbumBottomSheet = true
                } label: {
                    Text("삭제하기")
                        .madiiFont(.body1)
                        .foregroundStyle(.madiiNormal)
                }
                .padding(.bottom, 28)
                
                HStack {
                    Text("전체 공개")
                        .madiiFont(.body1)
                        .foregroundStyle(.madiiNormal)
                    
                    Spacer()
                    
                    Button {
                        if !isPublic {
                            showAlbumOptionBottomSheet = false
                            showAlbumChangePublicBottomSheet = true
                        }
                    } label: {
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundStyle(isPublic ? .madiiLime : .madiiAlternative)
                    }
                }
            }
            .padding(.bottom, 40)
        }
        .padding(.horizontal, 20)
        .background(.madiiElevated)
        .cornerRadius(40)
        .padding(.horizontal, 20)
        .background(.clear)
    }
}
