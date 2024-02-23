//
//  ChangePublicPopUp.swift
//  Madii
//
//  Created by 이안진 on 2/24/24.
//

import SwiftUI

struct ChangePublicPopUp: View {
    let album: Album
    @Binding var isAlbumPublic: Bool /// true이면 원래 비공개, false이면 원래 공개
    @Binding var showChangePublicPopUp: Bool
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.8).ignoresSafeArea()
                .onTapGesture { withoutAnimation { dismiss() } }
            
            PopUpWithDescription(title: "앨범 전체 공개", description: description(), leftButtonAction: dismiss, rightButtonTitle: isAlbumPublic ? "공개" : "확인", rightButtonAction: changePublic)
                .padding(.horizontal, 36)
        }
    }
    
    private func description() -> String {
        if isAlbumPublic {
            return "선택한 앨범을 공개하시겠어요?\n공개 시 다시 비공개로 변경할 수 없어요"
        } else {
            return "이미 공개된 앨범은 비공개로 변경할 수 없어요"
        }
    }
    
    private func dismiss() {
        if isAlbumPublic {
            
        } else {
            isAlbumPublic = true
        }
        showChangePublicPopUp = false
    }
    
    private func changePublic() {
        if isAlbumPublic {
            AlbumAPI.shared.changePublic(albumId: album.id) { isSuccess in
                if isSuccess {
                    print("앨범 공개 성공")
                    showChangePublicPopUp = false
                } else {
                    print("앨범 공개 실패")
                }
            }
        } else {
            dismiss()
        }
    }
}
