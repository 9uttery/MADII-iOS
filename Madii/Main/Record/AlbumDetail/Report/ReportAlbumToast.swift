//
//  ReportAlbumToast.swift
//  Madii
//
//  Created by 이안진 on 3/4/24.
//

import SwiftUI

struct ReportAlbumToast: View {
    var transitionEdge: Edge = .bottom
    
    var body: some View {
        HStack {
            Text("신고 완료. 2~3일 내로 알림함에서 신고 결과를 확인할 수 있어요.")
                .madiiFont(font: .madiiBody4, color: .black)
            Spacer()
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(Color.white)
        .cornerRadius(6)
        .padding(.horizontal, 16)
        .offset(y: -20)
        .transition(.move(edge: transitionEdge))
    }
}
