//
//  SaveJoyToast.swift
//  Madii
//
//  Created by 이안진 on 12/11/23.
//

import SwiftUI

struct SaveJoyToast: View {
    var body: some View {
        HStack {
            Text("기본 앨범에 저장되었습니다.")
                .madiiFont(font: .madiiBody4, color: .black)
            Spacer()
            Image(systemName: "chevron.right")
                .resizable()
                .frame(width: 8, height: 12)
                .foregroundStyle(Color.gray400)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(Color.white)
        .cornerRadius(6)
        .padding(.horizontal, 16)
        .offset(y: -24)
    }
}
