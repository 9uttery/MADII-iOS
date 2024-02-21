//
//  HomeView.swift
//  Madii
//
//  Created by 이안진 on 11/29/23.
//

import SwiftUI

struct HomeView: View {
    @State private var showSaveJoyPopUp: Bool = false

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 0) {
                Image("madiiLogo")
                    .resizable()
                    .frame(width: 160, height: 22)
                    .padding(.horizontal, 22)
                    .padding(.vertical, 12)

                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        HomeTodayJoyView(showSaveJoyPopUp: $showSaveJoyPopUp)
                        HomeMyJoyView()
                        HomePlayJoyView()
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 40) // 하단 여백 40
                }
                .scrollIndicators(.never)
            }

            // 소확행 저장하기 팝업
            if showSaveJoyPopUp { SaveMyJoyPopUpView() }
        }
    }
}

#Preview {
    HomeView()
}
