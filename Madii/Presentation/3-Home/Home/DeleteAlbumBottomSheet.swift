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
    @Binding var albumId: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("앨범 삭제")
                .madiiFont(font: .title2, color: .madiiStrong)
                .padding(.top, 40)
                .padding(.bottom, 24)
            
            Text("선택한 앨범을 삭제하시겠어요?\n한번 삭제된 내 앨범은 복구할 수 없어요")
                .madiiFont(font: .madiiBody2, color: .madiiStrong)
                .padding(.bottom, 40)
            
            HStack(spacing: 10) {
                MadiiDesignSystem.MadiiButton(title: "취소", color: .neutral) {
                    showDeleteAlbumBottomSheet = false
                }
                .frame(width: 82)
                
                MadiiDesignSystem.MadiiButton(title: "삭제", color: .mainColor)
            }
        }
        .padding(.horizontal, 20)
    }
    
    func deleteAlbum() {
        AlbumAPI.shared.deleteAlbumsByAlbumId(albumId: albumId) { isSuccess in
            if isSuccess {
                print("Debug deleteAlbumsByAlbumId: isSuccess true")
            } else {
                print("Debug deleteAlbumsByAlbumId: isSuccess false")
            }
        }
    }

}

#Preview {
    DeleteAlbumBottomSheet(showDeleteAlbumBottomSheet: .constant(true), albumId: .constant(1))
}
