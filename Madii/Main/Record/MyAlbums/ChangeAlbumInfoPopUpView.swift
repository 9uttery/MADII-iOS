//
//  ChangeAlbumInfoPopUpView.swift
//  Madii
//
//  Created by 이안진 on 12/11/23.
//

import SwiftUI

struct ChangeAlbumInfoPopUpView: View {
    var body: some View {
        ZStack(alignment: .center) {
            Color.black.opacity(0.8).ignoresSafeArea()
            
            PopUpWithNameDescription()
        }
    }
}

#Preview {
    ChangeAlbumInfoPopUpView()
}
