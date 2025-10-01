//
//  AlbumDetailViewModel_P3.swift
//  Madii
//
//  Created by 정태우 on 9/30/25.
//

import Foundation
import SwiftUI

@Observable
class AlbumDetailViewModel_P3 {
    private let router: Router
    
    // 상태
    var albumId: Int
    var albumTitle: String = ""
    var albumDescription: String = ""
    var albumCoverId: Int = 0
    var joyResponses: [GetAlbumByIdResponseJoyInfo] = []
    var joyTitle: String = ""
    var albums: [Album] = Album.dummy3
    var isMine: Bool = false
    
    init(router: Router, albumId: Int) {
        self.router = router
        self.albumId = albumId
    }
    
    enum Action {
        case loadAlbum
        case addJoy
        case popView
    }
    
    func action(_ action: Action) {
        switch action {
        case .loadAlbum:
            getAlbumByAlbumId()
        case .addJoy:
            addJoyToAlbum()
        case .popView:
            popView()
        }
    }
    
    private func getAlbumByAlbumId() {
        AlbumAPI.shared.getAlbumByAlbumId(albumId: albumId) { isSuccess, albumInfo in
            if isSuccess {
                print("DEBUG AlbumDetailViewModel getAlbumByAlbumId success")
                self.albumTitle = albumInfo.name
                self.albumDescription = albumInfo.description
                self.joyResponses = albumInfo.joyInfoList
                self.albumCoverId = albumInfo.albumColorNum
            } else {
                print("DEBUG AlbumDetailViewModel getAlbumByAlbumId fail")
            }
        }
    }
    
    private func popView() {
        router.pop()
    }
    
    private func addJoyToAlbum() {
        /// api 혹은 상태값 변경 처리
    }
}
