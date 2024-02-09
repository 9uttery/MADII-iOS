//
//  PlaylistBar.swift
//  Madii
//
//  Created by 이안진 on 2/9/24.
//

import SwiftUI

struct PlaylistBar: View {
    var body: some View {
        HStack(spacing: 22) {
            Text("소확행제목")
                .madiiFont(font: .madiiBody1, color: .white)
                .lineLimit(1)
            
            Spacer()
            
            HStack(spacing: 12) {
                Rectangle()
                    .frame(width: 14, height: 16)
                
                Image(systemName: "checkmark.circle.fill")
                    .frame(width: 24, height: 24)
                    .foregroundStyle(Color.madiiYellowGreen)
                    .padding()
                    .frame(width: 28, height: 28)
                
                Rectangle()
                    .frame(width: 14, height: 16)
            }
            
            Image(systemName: "line.3.horizontal")
                .frame(width: 18, height: 18)
                .foregroundStyle(Color.gray500)
                .padding()
                .frame(width: 22, height: 22)
        }
        .padding(16)
        .overlay(
            Rectangle()
                .frame(height: 1, alignment: .top)
                .foregroundColor(Color.madiiYellowGreen),
            alignment: .top
        )
    }
}

#Preview {
    PlaylistBar()
}
