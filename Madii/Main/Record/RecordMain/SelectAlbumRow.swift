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
            Spacer()
        }
        .padding(.horizontal, 6)
        .padding(.vertical, 8)
        .background(Color(red: 0.21, green: 0.22, blue: 0.29))
        .cornerRadius(4)
        .overlay(
            RoundedRectangle(cornerRadius: 4)
                .stroke(Color.madiiYellowGreen.opacity(isSelected ? 1.0 : 0.0), lineWidth: 1)
        )
    }
}
