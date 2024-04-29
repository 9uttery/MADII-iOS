//
//  SignOutView.swift
//  Madii
//
//  Created by 정태우 on 1/26/24.
//

import SwiftUI

struct SignOutView: View {
    @State var selectedIndex = 0 // 초기 인덱스 설정
    @State var offset: CGFloat = 0
    @State var dragOffset: CGFloat = 0
    @State var screenHeight: CGFloat = UIScreen.main.bounds.height / 2
    var body: some View {
        VStack(spacing: 0) {
            UserStatView()
                .offset(y: offset + screenHeight)
            
            ReallyLeaveView()
                .offset(y: offset + screenHeight)
        }
        .gesture(DragGesture()
            .onChanged { value in
                if value.translation.height < -100 {
                    withAnimation {
                        screenHeight =  -1 * UIScreen.main.bounds.height / 2
                    }
                } else if value.translation.height > 100 {
                    withAnimation {
                        screenHeight = UIScreen.main.bounds.height / 2
                    }
                }
            }
        )
        .navigationTitle("회원 탈퇴")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color.madiiBox, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

#Preview {
    SignOutView()
}
