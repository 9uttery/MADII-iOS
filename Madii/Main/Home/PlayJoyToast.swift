//
//  PlayJoyToast.swift
//  Madii
//
//  Created by 정태우 on 12/24/23.
//

import SwiftUI

struct PlayJoyToast: View {
    var body: some View {
        NavigationLink {
            
        } label: {
            HStack {
                Text("오늘의 플레이리스트에서 확인할 수 있어요!")
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
}

#Preview {
    PlayJoyToast()
}
