//
//  DeleteJoyPopUp.swift
//  Madii
//
//  Created by 이안진 on 2/28/24.
//

import SwiftUI

struct DeleteJoyPopUp: View {
    let joy: Joy
    @Binding var showDeleteJoyPopUp: Bool
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.8).ignoresSafeArea()
                .onTapGesture { dismissPopUp() }
            
            PopUpWithDescription(title: "소확행 삭제", description: "선택한 소확행을 삭제하시겠어요?\n한번 삭제된 내 소확행은 복구할 수 없어요", leftButtonAction: dismissPopUp, rightButtonTitle: "삭제", rightButtonAction: deleteAlbum)
                .padding(.horizontal, 36)
        }
    }
    
    private func dismissPopUp() {
        withoutAnimation {
            showDeleteJoyPopUp = false
        }
    }
    
    private func deleteAlbum() {
        JoyAPI.shared.deleteJoy(joyId: joy.joyId) { isSuccess in
            if isSuccess {
                print("소확행 삭제 성공")
                dismissPopUp()
            } else {
                print("소확행 삭제 실패")
            }
        }
    }
}
