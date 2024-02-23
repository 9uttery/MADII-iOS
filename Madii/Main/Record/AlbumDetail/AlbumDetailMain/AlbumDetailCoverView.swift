//
//  AlbumDetailCoverView.swift
//  Madii
//
//  Created by 이안진 on 2/21/24.
//

import SwiftUI

struct AlbumDetailCoverView: View {
    private let colors: [Int: Color] = [1: Color.madiiOrange, 2: Color.madiiPurple, 3: Color.madiiSkyBlue, 4: Color.madiiPink]
    let album: Album
    
    var body: some View {
        ZStack {
            colors[album.backgroundColorNum]
                .frame(maxWidth: .infinity)
                .frame(height: 180)
            
            HStack(spacing: 0) {
                ForEach(0 ..< 3, id: \.self) { index in
                    Image("icon_\(album.iconNum)")
                        .resizable()
                        .frame(width: 100, height: 100)
                    
                    if index != 2 { Spacer() }
                }
            }
            .padding(.horizontal, 12)
        }
    }
}
