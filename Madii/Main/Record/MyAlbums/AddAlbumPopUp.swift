//
//  AddAlbumPopUp.swift
//  Madii
//
//  Created by 이안진 on 2/26/24.
//

import SwiftUI

struct AddAlbumPopUp: View {
    @Binding var showAddAlbumPopUp: Bool
    
    var body: some View {
        ZStack(alignment: .center) {
            Color.black.opacity(0.8).ignoresSafeArea()
                .onTapGesture { showAddAlbumPopUp = false }
            
            PopUp(title: "새로운 앨범", leftButtonTitle: "취소", leftButtonAction: { showAddAlbumPopUp = false }, rightButtonTitle: "생성", rightButtonColor: .gray, rightButtonAction: { }, content: {
                VStack {
                    Text("이름")
                }
            })
            .padding(.horizontal, 36)
        }
    }
}
