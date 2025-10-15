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
                .lineSpacing(9.6)
                .lineLimit(1)

            Spacer()

            if joy.selectedEmotions.isEmpty {
                if selectedDate.isSameDay(as: Date()) {
                    Button {
                        onPlayToggle()
                    } label: {
                        Image(systemName: "checkmark.circle")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundStyle(joy.isAchieved ? .madiiLime : .madiiAlternative)
                            .padding(4)
                    }
                    .buttonStyle(.borderless) 
                }
            } else {
                ForEach(joy.selectedEmotions) { emotion in
                    Text(emotion.title)
                        .madiiFont(font: .caption, color: emotion.color)
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

struct MadiiBorderContainerModifier: ViewModifier {
    let cornerRadius: CGFloat
    let paddingVertical: CGFloat
    let paddingHorizontal: CGFloat

    init(cornerRadius: CGFloat = 40, paddingVertical: CGFloat = 20, paddingHorizontal: CGFloat = 18) {
        self.cornerRadius = cornerRadius
        self.paddingVertical = paddingVertical
        self.paddingHorizontal = paddingHorizontal
    }

    func body(content: Content) -> some View {
        content
            .padding(.vertical, paddingVertical)
            .padding(.horizontal, paddingHorizontal)
            .background(Color.madiiElevated)
            .cornerRadius(cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(
                        LinearGradient(
                            gradient: Gradient(stops: [
                                .init(color: Color.white.opacity(0.1), location: 0.0),
                                .init(color: Color(red: 0x3D/255, green: 0xC2/255, blue: 0xFF/255).opacity(0.1), location: 0.33),
                                .init(color: Color(red: 0xD4/255, green: 0x78/255, blue: 0xFF/255).opacity(0.1), location: 0.68),
                                .init(color: Color.white.opacity(0.1), location: 1.0)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1
                    )
            )
    }
}

extension View {
    func madiiBorderContainerStyle(
        cornerRadius: CGFloat = 40,
        paddingVertical: CGFloat = 20,
        paddingHorizontal: CGFloat = 18
    ) -> some View {
        modifier(MadiiBorderContainerModifier(
            cornerRadius: cornerRadius,
            paddingVertical: paddingVertical,
            paddingHorizontal: paddingHorizontal
        ))
    }
}
