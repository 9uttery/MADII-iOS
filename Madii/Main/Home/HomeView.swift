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
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    HomeTodayJoyView(showSaveJoyPopUp: $showSaveJoyPopUp)
                    HomeMyJoyView()
                    HomePlayJoyView()
                }
                .padding(.horizontal, 16)
            }
            .scrollIndicators(.never)
            
            if showSaveJoyPopUp {
                SaveMyJoyPopUpView()
            }
        }
    }
}

#Preview {
    HomeView()
}
