//
//  ChangeAlbumInfoPopUpView.swift
//  Madii
//
//  Created by 이안진 on 12/11/23.
//

import SwiftUI

struct ChangeAlbumInfoPopUpView: View {
    @State private var name: String = ""
    @State private var description: String = ""
    
    var body: some View {
        ZStack(alignment: .center) {
            Color.black.opacity(0.8).ignoresSafeArea()
                .onTapGesture { dismissPopUp() }
            
            PopUpWithNameDescription(title: "앨범 이름・설명 수정",
                                     name: $name, description: $description,
                                     leftButtonAction: dismissPopUp, rightButtonAction: changeInfo)
        }
    }
    
    private func dismissPopUp() {
        
    }
    
    private func changeInfo() {
        // 정보 수정 서버 업데이트
        dismissPopUp()
    }
}

#Preview {
    ChangeAlbumInfoPopUpView()
}
