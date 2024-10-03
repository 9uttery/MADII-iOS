//
//  CloseEditAlbumPopUp.swift
//  Madii
//
//  Created by 정태우 on 9/3/24.
//

import SwiftUI

struct CloseEditAlbumPopUp: View {
    @Binding var showCloseEditAlbumPopUp: Bool
    @Binding var isClose: Bool
    var body: some View {
        ZStack {
            Color.black.opacity(0.8).ignoresSafeArea()
                .onTapGesture { dismiss() }
            
            PopUp(title: "앨범 편집 종료",
                  leftButtonTitle: "취소", leftButtonAction: dismiss,
                  rightButtonTitle: "종료", rightButtonColor: .white, rightButtonAction: rightButtonAction) {
                
            }
                  .padding(36)
        }
    }
    
    private func dismiss() {
        withoutAnimation {
            showCloseEditAlbumPopUp = false
        }
        AnalyticsManager.shared.logEvent(name: "앨범편집종료팝업_취소클릭")
    }
    
    private func rightButtonAction() {
        withoutAnimation {
            isClose = true
        }
        AnalyticsManager.shared.logEvent(name: "앨범편집종료팝업_종료클릭")
    }
}
