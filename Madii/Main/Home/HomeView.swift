//
//  HomeView.swift
//  Madii
//
//  Created by 이안진 on 11/29/23.
//

import SwiftUI

struct HomeView: View {
    @State private var showSaveJoyPopUp: Bool = false
    @State private var showSaveJoyToast: Bool = false
    @State private var showNewAlbumPopUp: Bool = false
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 0) {
                HomeTodayJoyView(showSaveJoyPopUp: $showSaveJoyPopUp)
                HomeMyJoyView()
                HomePlayJoyView()
                Spacer()
            }
            .padding(.horizontal, 16)
            if showSaveJoyPopUp {
                SaveMyJoyPopUpView(showSaveJoyPopUp: $showSaveJoyPopUp, showSaveJoyToast: $showSaveJoyToast)
            }
        }
    }
}

#Preview {
    HomeView()
}
