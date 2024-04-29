//
//  SelectAlbumRow.swift
//  Madii
//
//  Created by 이안진 on 12/1/23.
//

import SwiftUI

struct SelectAlbumRow: View {
    let title: String
    let isSelected: Bool

    var body: some View {
        HStack {
            Text(title)
                .madiiFont(font: .madiiBody3, color: isSelected ? .white : .gray500)
                .multilineTextAlignment(.leading)
            
            Spacer()
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 16)
        .background(Color.madiiOption)
        .cornerRadius(4)
        .overlay(
            RoundedRectangle(cornerRadius: 4)
                .inset(by: 0.5)
                .stroke(Color.madiiYellowGreen.opacity(isSelected ? 1.0 : 0.0), lineWidth: 1)
        )
    }
}
