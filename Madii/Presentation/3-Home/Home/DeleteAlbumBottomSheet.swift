//
//  DeleteAlbumBottomSheet.swift
//  Madii
//
//  Created by 정태우 on 9/26/25.
//

import MadiiDesignSystem
import SwiftUI

struct DeleteAlbumBottomSheet: View {
    @Binding var showDeleteAlbumBottomSheet: Bool
    @Binding var albums: [Album]
    
    var body: some View {
        VStack {
            Rectangle()
                .frame(width: 100, height: 5)
                .foregroundStyle(.madiiContrast)
                .cornerRadius(2.5)
                .padding(.top, 16)
            
            Text("앨범 삭제")
                .madiiFont(font: .madiiTitle, color: .madiiStrong)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 40)
                .padding(.bottom, 24)
            
            Text("선택한 앨범을 삭제하시겠어요?\n한번 삭제된 내 앨범은 복구할 수 없어요")
                .madiiFont(font: .madiiBody2, color: .madiiStrong)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 40)
            
            HStack(spacing: 10) {
                MadiiDesignSystem.MadiiButton(title: "취소", color: .neutral) {
                    showDeleteAlbumBottomSheet = false
                }
                .frame(width: 82)
                
                MadiiDesignSystem.MadiiButton(title: "삭제", color: .mainColor) {
                    deleteAlbums()
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
    
    func deleteAlbums() {
        let albumIds = albums.map { $0.id }
        AlbumAPI.shared.deleteAlbums(albumId: albumIds) { isSuccess in
            if isSuccess {
                print("Debug deleteAlbumsByAlbumId: isSuccess true")
                showDeleteAlbumBottomSheet = false
            } else {
                print("Debug deleteAlbumsByAlbumId: isSuccess false")
            }
        }
    }
}

#Preview {
    DeleteAlbumBottomSheet(showDeleteAlbumBottomSheet: .constant(true), albums: .constant([]))
}
