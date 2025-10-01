//
//  AlbumListViewModel_P3.swift
//  Madii
//
//  Created by 정태우 on 9/30/25.
//

import Foundation
import SwiftUI

@Observable
class AlbumListViewModel_P3 {
    private let router: Router
    
    // 상태 관리
    var albums: [Album] = Album.dummy10
    var isSelect: Bool = false
    var showNewAlbumBottomSheet: Bool = false
    var selectedAlbums: [Album] = []
    
    init(router: Router) {
        self.router = router
        action(.loadAlbums)
    }
    
    enum Action {
        case toggleSelect
        case loadAlbums
        case createAlbum
        case showAlbumDetail(album: Album)
        case deleteAlbums
        case selectAlbum(album: Album)
        case popView
    }
    
    func action(_ action: Action) {
        switch action {
        case .toggleSelect:
            toggleSelect()
        case .loadAlbums:
            getAllAlbums()
        case .createAlbum:
            showCreateAlbum()
        case .showAlbumDetail(let album):
            showAlbumDetail(album)
        case .deleteAlbums:
            deleteSelectedAlbums()
        case .selectAlbum(let album):
            selectAlbum(album)
        case .popView:
            popView()
        }
    }
    
    private func toggleSelect() {
        isSelect.toggle()
    }
    
    private func getAllAlbums() {
        RecordAPI.shared.getAlbums() { isSuccess, albums in
            if isSuccess {
                print("Debug getAlbums: Success")
                DispatchQueue.main.async {
                    self.albums = albums.map { dto in
                        Album(
                            id: dto.albumId,
                            backgroundColorNum: dto.albumColorNum,
                            iconNum: dto.joyIconNum,
                            title: dto.name,
                            creator: dto.nickname ?? "",
                            description: "",
                            isPublic: false
                        )
                    }
                }
            } else {
                print("DEBUG getAllAlbums: fail")
            }
        }
    }
    
    private func showCreateAlbum() {
        showNewAlbumBottomSheet.toggle()
    }
    
    private func showAlbumDetail(_ album: Album) {
        router.push(.albumDetail(albumId: album.id))
    }
    
    private func popView() {
        router.pop()
    }
    
    private func deleteSelectedAlbums() {
        for album in selectedAlbums {
            AlbumAPI.shared.deleteAlbumsByAlbumId(albumId: album.id) { isSuccess in
                if isSuccess {
                    print("Debug deleteAlbumsByAlbumId: isSuccess true")
                    self.getAllAlbums()
                } else {
                    print("Debug deleteAlbumsByAlbumId: isSuccess false")
                }
            }
        }
    }
    
    private func selectAlbum(_ album: Album) {
        if selectedAlbums.contains(album) {
            selectedAlbums.removeAll { $0 == album }
        } else {
            selectedAlbums.append(album)
        }
    }
}
