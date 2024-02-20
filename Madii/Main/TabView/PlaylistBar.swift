//
//  PlaylistBar.swift
//  Madii
//
//  Created by 이안진 on 2/9/24.
//

import SwiftUI

struct PlaylistBar: View {
    @State private var draggedOffset = CGSize.zero
    @State private var showPlaylist: Bool = false
    
    var body: some View {
        Button {
            withAnimation { showPlaylist = true }
        } label: {
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
            .background(Color.black)
            .frame(height: 60)
        }
        .transparentFullScreenCover(isPresented: $showPlaylist) {
            VStack {
                HStack { Spacer() }
                Spacer()
                Text("haha")
                Spacer()
            }
            .background(Color.madiiPink)
            .offset(draggedOffset)
            .gesture(swipeDownToDismiss)
        }
    }
    
    var swipeDownToDismiss: some Gesture {
        DragGesture()
            .onChanged { gesture in
                // 아래로만 드래그 되도록 구현
                guard gesture.translation.height > 0 else { return }
                
                draggedOffset.height = gesture.translation.height
            }
            .onEnded { gesture in
                if checkIsDismissable(gesture: gesture) {
                    showPlaylist = false
                }
                
                withAnimation {
                    draggedOffset = .zero
                }
            }
    }

    func checkIsDismissable(gesture: _ChangedGesture<DragGesture>.Value) -> Bool {
        let dismissableLocation = gesture.translation.height > 100
        let dismissableVolocity = (gesture.predictedEndLocation - gesture.location).y > 100
        return dismissableLocation || dismissableVolocity
    }
}

extension CGPoint {
    static func - (lhs: Self, rhs: Self) -> Self {
        CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
}
