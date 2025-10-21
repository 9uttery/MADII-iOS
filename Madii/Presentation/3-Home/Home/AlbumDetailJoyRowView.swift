//
//  AlbumDetailJoyRowView.swift
//  Madii
//
//  Created by 정태우 on 10/15/25.
//

import SwiftUI

struct AlbumDetailJoyRowView: View {
    @Binding var joys: [GetAlbumByIdResponseJoyInfo]
    @Binding var joy: GetAlbumByIdResponseJoyInfo
    @Binding var selectedJoy: GetAlbumByIdResponseJoyInfo
    @Binding var deleteIds: [Int]

    var body: some View {
        HStack(spacing: 12) {
            Circle()
                .frame(width: 12, height: 12)
                .foregroundStyle(.madiiCyan)
                .padding(.leading, 4)

            Text(joy.contents)
                .madiiFont(font: .madiiBody2, color: .madiiNormal)
                .lineSpacing(9.6)
                .lineLimit(1)

            Spacer()

            Image("lineMenu")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundStyle(.madiiAlternative)
                .padding(4)
        }
        .frame(height: 40)
        .listRowBackground(Color.madiiElevated)
        .listRowSeparator(.hidden)
        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
            Button {
                joys.removeAll { $0.joyId == joy.joyId }
                if joy.joyId != -1 {
                    deleteIds.append(joy.joyId)
                }
            } label: {
                SwipeButton(title: "삭제", color: .madiiNegative)
                    .frame(width: 50, height: 30)
            }
            .tint(.clear)
            
            Button {
                selectedJoy = joy
            } label: {
                SwipeButton(title: "수정", color: .madiiGray35)
                    .frame(width: 50, height: 30)
            }
            .tint(.clear)
        }
        .listRowInsets(EdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 20))
    }
}
