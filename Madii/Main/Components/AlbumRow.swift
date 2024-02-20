//
//  AlbumRow.swift
//  Madii
//
//  Created by 이안진 on 11/30/23.
//

import SwiftUI

struct AlbumRow: View {
    private let colors: [Int: Color] = [1: Color.madiiOrange, 2: Color.madiiPurple, 3: Color.madiiSkyBlue, 4: Color.madiiPink]
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
    private let colors: [Int: Color] = [1: Color.madiiOrange, 2: Color.madiiPurple, 3: Color.madiiSkyBlue, 4: Color.madiiPink]
    let album: Album
    @ViewBuilder var rightView: Content
    
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

            rightView
        }
    }
}
