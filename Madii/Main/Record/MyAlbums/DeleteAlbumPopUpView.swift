//
//  DeleteAlbumPopUpView.swift
//  Madii
//
//  Created by 이안진 on 12/11/23.
//

import SwiftUI

struct DeleteAlbumPopUpView: View {
    @EnvironmentObject private var popUpStatus: PopUpStatus
    
    var body: some View {
        ZStack(alignment: .center) {
            Color.black.opacity(0.8).ignoresSafeArea()
                .onTapGesture { dismissPopUp() }
            
            PopUpWithDescription(title: "앨범 삭제",
                                 description: "선택한 앨범을 삭제하시겠어요?\n한번 삭제된 내 앨범은 복구할 수 없어요.", 
                                 leftButtonAction: dismissPopUp,
                                 rightButtonTitle: "삭제", rightButtonAction: deleteAlbum)
                .padding(.horizontal, 36)
        }
    }
    
    private func dismissPopUp() {
        popUpStatus.showDeleteAlbum = false
    }
    
    private func deleteAlbum() {
        // 정보 수정 서버 업데이트
        dismissPopUp()
    }
}

#Preview {
    DeleteAlbumPopUpView()
}
