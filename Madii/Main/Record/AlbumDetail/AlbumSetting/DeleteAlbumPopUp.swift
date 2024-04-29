//
//  DeleteAlbumPopUp.swift
//  Madii
//
//  Created by 이안진 on 2/24/24.
//

import SwiftUI

struct DeleteAlbumPopUp: View {
    let album: Album
    @Binding var showDeleteAlbumPopUp: Bool
    var dismiss: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.8).ignoresSafeArea()
                .onTapGesture { dismissDetailView() }
            
            PopUpWithDescription(title: "앨범 삭제", description: "선택한 앨범을 삭제하시겠어요?\n한번 삭제된 내 앨범은 복구할 수 없어요", leftButtonAction: dismissDetailView, rightButtonTitle: "삭제", rightButtonAction: deleteAlbum)
                .padding(.horizontal, 36)
        }
    }
    
    private func dismissDetailView() {
        withoutAnimation {
            showDeleteAlbumPopUp = false
        }
    }
    
    private func deleteAlbum() {
        AlbumAPI.shared.deleteAlbumsByAlbumId(albumId: album.id) { isSuccess in
            if isSuccess {
                print("앨범 삭제 성공")
                dismissDetailView()
                dismiss()
            } else {
                print("앨범 삭제 실패")
            }
        }
    }
}
