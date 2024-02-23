//
//  AlbumDetailBookmarkButton.swift
//  Madii
//
//  Created by 이안진 on 2/21/24.
//

import SwiftUI

struct AlbumDetailBookmarkButton: View {
    let albumId: Int
    @Binding var isAlbumSaved: Bool
    
    var body: some View {
        Button {
            bookmarkButtonAction()
        } label: {
            HStack(spacing: 4) {
                Image(systemName: "bookmark.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 18)
                    .foregroundStyle(isAlbumSaved ? Color.madiiYellowGreen : Color.white)
                
                Text(isAlbumSaved ? "저장 완료" : "앨범 저장")
                    .madiiFont(font: .madiiBody3, color: .white)
            }
            .padding(8)
            .padding(.trailing, 4)
            .frame(height: 40, alignment: .center)
            .background(.black.opacity(isAlbumSaved ? 0.6 : 1.0))
            .cornerRadius(6)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(.white, lineWidth: 1)
            )
            .opacity(isAlbumSaved ? 1.0 : 0.5)
        }
    }
    
    private func bookmarkButtonAction() {
        if isAlbumSaved {
            // 저장되어있음 -> 북마크 해제
            unsaveAlbum()
        } else {
            // 저장 X -> 북마크 O
            saveAlbum()
        }
    }
    
    private func saveAlbum() {
        AlbumAPI.shared.postBookmarksByAlbumId(albumId: albumId) { isSuccess in
            if isSuccess {
                print("DEBUG AlbumDetailBookmarkButton save: isSuccess true")
                isAlbumSaved = true
            } else {
                print("DEBUG AlbumDetailBookmarkButton save: isSuccess true")
            }
        }
    }
    
    private func unsaveAlbum() {
        AlbumAPI.shared.deleteBookmarksByAlbumId(albumId: albumId) { isSuccess in
            if isSuccess {
                print("DEBUG AlbumDetailBookmarkButton save: isSuccess true")
                isAlbumSaved = false
            } else {
                print("DEBUG AlbumDetailBookmarkButton save: isSuccess true")
            }
        }
    }
}
