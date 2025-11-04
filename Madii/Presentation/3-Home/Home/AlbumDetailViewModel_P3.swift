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
    var popNum: Int = 1
    var albumTitle: String = ""
    var albumDescription: String = ""
    var albumCoverId: Int = 1
    var joyResponses: [GetAlbumByIdResponseJoyInfo] = []
    var joyTitle: String = ""
    var nickname: String = ""
    var isAlbumSaved: Bool = false
    var albums: [Album] = Album.dummy3
    var isPublic: Bool = true
    var isMine: Bool = false
    var isEdit: Bool = false
    var newAlbumTitle: String = ""
    var newAlbumDescription: String = ""
    var selectedJoy: GetAlbumByIdResponseJoyInfo = GetAlbumByIdResponseJoyInfo(joyId: 0, joyIconNum: 0, contents: "", isJoySaved: false)
    var newJoys: [GetAlbumByIdResponseJoyInfo] = []
    var deleteIds: [Int] = []
    var newJoyId: Int = 0
    
    init(router: Router, albumId: Int, popNum: Int = 1) {
        self.router = router
        self.albumId = albumId
        self.popNum = popNum
    }
    
    enum Action {
        case loadAlbum
        case addJoy
        case popView
        case randomAlbums
    }
    
    func action(_ action: Action) {
        switch action {
        case .loadAlbum:
            getAlbumByAlbumId()
        case .addJoy:
            addJoyToAlbum()
        case .popView:
            popView()
        case .randomAlbums:
            getAnotherAlbums()
        }
    }
    
    private func getAlbumByAlbumId() {
        AlbumAPI.shared.getAlbumByAlbumId(albumId: self.albumId) { isSuccess, albumInfo in
            if isSuccess {
                print("DEBUG AlbumDetailView: albumInfo \(albumInfo)")
                
                if let creator = albumInfo.nickname {
                    // 다른 사람의 앨범
                    self.isMine = false
                    self.isAlbumSaved = albumInfo.isAlbumSaved ?? false
                    self.nickname = creator
                } else {
                    // 나의 앨범
                    self.isMine = true
                    self.isPublic = albumInfo.isAlbumOfficial
                }
                
                // 앨범 설명
                self.albumTitle = albumInfo.name
                self.albumDescription = albumInfo.description
                self.newAlbumTitle = albumInfo.name
                self.albumDescription = albumInfo.description
                self.albumCoverId = albumInfo.albumColorNum
                
                // 소확행 리스트
                self.joyResponses = albumInfo.joyInfoList
                self.newJoys = albumInfo.joyInfoList
            } else {
                print("DEBUG AlbumDetailView getAlbumInfos: isSuccess false")
            }
        }
    }
    
    private func popView() {
        router.pop()
    }
    
    private func addJoyToAlbum() {
        JoyAPI.shared.postJoy(contents: self.joyTitle, joyColorNum: Int.random(in: 1...8)) { isSuccess, joyResponse in
            if isSuccess {
                RecordAPI.shared.editJoy(joyId: joyResponse.joyId, contents: self.joyTitle, beforeAlbumIds: [], afterAlbumIds: [self.albumId]) { isSuccess, _ in
                    if isSuccess {
                        self.getAlbumByAlbumId()
                    } else {
                        print("debug editJoy: isSuccess false")
                    }
                }
            } else {
                print("debug postJoy: isSuccess false")
            }
        }
    }
    
    private func getAnotherAlbums() {
        RecordAPI.shared.getRandomAlbumsById(albumId: albumId) { isSuccess, responseAlbums in
            if isSuccess {
                self.albums = responseAlbums.map { response in
                    Album(
                        id: response.albumId,
                        backgroundColorNum: response.albumColorNum,
                        iconNum: response.joyIconNum,
                        title: response.name
                    )
                }
            } else {
                
            }
        }
    }
}
