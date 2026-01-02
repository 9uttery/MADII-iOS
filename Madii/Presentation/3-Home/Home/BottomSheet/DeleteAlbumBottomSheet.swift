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
    @Binding var isDismiss: Bool
    @Binding var albums: [Album]
    
    var body: some View {
        VStack {
            Rectangle()
                .frame(width: 100, height: 5)
                .foregroundStyle(.madiiContrast)
                .cornerRadius(2.5)
                .padding(.top, 16)
            
            Text("선택한 앨범을 삭제하시겠어요?")
                .madiiFont(.title1)
                .foregroundStyle(.madiiStrong)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 40)
                .padding(.bottom, 24)
            
            Text("앨범 속 행복 기록도 함께 삭제돼요\n삭제된 기록은 복원되지 않아요")
                .madiiFont(.body2)
                .foregroundStyle(.madiiStrong)
                .lineSpacing(9.6)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 40)
            
            HStack(spacing: 10) {
                MadiiDesignSystem.MadiiButton(title: "닫기", color: .neutral) {
                    showDeleteAlbumBottomSheet = false
                }
                .frame(width: 82)
                
                MadiiDesignSystem.MadiiButton(title: "삭제하기", color: .mainColor) {
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
                albums = []
                showDeleteAlbumBottomSheet = false
                isDismiss = true
            } else {
                print("Debug deleteAlbumsByAlbumId: isSuccess false")
            }
        }
    }
}
