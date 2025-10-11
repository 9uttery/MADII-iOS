//
//  JoyRowView.swift
//  Madii
//
//  Created by 정태우 on 10/8/25.
//

import SwiftUI

struct JoyRowView: View {
    let joy: Joy
    let selectedDate: Date
    let onDelete: () -> Void
    let onEdit: () -> Void
    let onPlayToggle: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            Circle()
                .frame(width: 7, height: 7)
                .foregroundStyle(.madiiCyan)
                .padding(.leading, 4)

            Text(joy.title)
                .madiiFont(font: .madiiBody2, color: .madiiNormal)
                .lineLimit(1)

            Spacer()

            if joy.selectedEmotions.isEmpty {
                if selectedDate.isSameDay(as: Date()) {
                    Button(action: onPlayToggle) {
                        Image(systemName: "checkmark.circle")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundStyle(joy.isAchieved ? .madiiLime : .madiiAlternative)
                            .padding(4)
                    }
                }
            } else {
                ForEach(joy.selectedEmotions) { emotion in
                    Text(emotion.title)
                        .madiiFont(font: .madiiCaption, color: emotion.color)
                        .padding(.vertical, 4.5)
                        .padding(.horizontal, 8)
                        .background(emotion.color.opacity(0.08))
                        .cornerRadius(8)
                        .padding(.leading, 4)
                }
            }
        }
        .frame(height: 40)
        .listRowBackground(Color.madiiElevated)
        .listRowSeparator(.hidden)
        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
            Button(action: onDelete) {
                SwipeButton(title: "삭제", color: .madiiNegative)
                    .frame(width: 50, height: 30)
            }
            .tint(.clear)
            
            Button(action: onEdit) {
                SwipeButton(title: "수정", color: .madiiGray35)
                    .frame(width: 50, height: 30)
            }
            .tint(.clear)
        }
        .listRowInsets(EdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 20))
    }
}
