//
//  AlbumRow.swift
//  Madii
//
//  Created by 이안진 on 11/30/23.
//

import SwiftUI

// FIXME: 이 두개를 합칠 수 있는 방법을 찾아보자

enum AlbumCoverImage {
    case orange, purple, blue, pink
    
    var backgroundColor: Color {
        switch self {
        case .orange: Color.madiiOrange
        case .purple: Color.madiiPurple
        case .blue: Color.madiiSkyBlue
        case .pink: Color.madiiPink
        }
    }
}

struct AlbumRow: View {
    private let colors: [Int: Color] = [1: Color.orange, 2: Color.madiiPurple, 3: Color.madiiSkyBlue, 4: Color.madiiPink]
    let album: Album
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Rectangle()
                    .frame(width: 56, height: 56)
                    .foregroundStyle(colors[album.backgroundColorNum] ?? Color.orange)
                    .cornerRadius(4)
                
                Image("icon_\(album.iconNum)")
                    .resizable()
                    .frame(width: 36, height: 36)
            }
            
            Text(album.title)
                .madiiFont(font: .madiiBody3, color: .white, withHeight: true)

            Spacer()
        }
    }
}

struct AlbumRowWithRightView<Content>: View where Content: View {
    @ViewBuilder var rightView: Content
    
    var body: some View {
        HStack(spacing: 15) {
            Rectangle()
                .frame(width: 56, height: 56)
                .foregroundStyle(Color.madiiPurple)
                .cornerRadius(4)

            Text("내가 찾은 소확행들의 앨범")
                .madiiFont(font: .madiiBody3, color: .white, withHeight: true)

            Spacer()

            rightView
        }
    }
}
