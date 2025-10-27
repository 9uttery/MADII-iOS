//
//  NoticeView_P3.swift
//  Madii
//
//  Created by Anjin on 10/27/25.
//

import SwiftUI

struct NoticeView_P3: View {
    var body: some View {
        ZStack {
            Color.madiiDefault.ignoresSafeArea()
            
            VStack(spacing: 240) {
                MyPageNavigationBar(title: "공지사항")
                
                Image(.noticeBackground)
                    .resizable()
                    .frame(width: 120, height: 120)
                
                Spacer()
            }
        }
    }
}

#Preview {
    NoticeView_P3()
}
