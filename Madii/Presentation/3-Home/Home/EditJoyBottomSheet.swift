//
//  EditJoyBottomSheet.swift
//  Madii
//
//  Created by 정태우 on 9/22/25.
//

import MadiiDesignSystem
import SwiftUI

struct EditJoyBottomSheet: View {
    @Binding var showEditJoyBottomSheet: Bool
    @Binding var joyId: Int
    @Binding var joyTitle: String
    @Binding var showAddNewAlbumBottomSheet: Bool
    @State var albums: [Album] = []
    @State private var selectedAlbumIds: [Int] = []
    @State private var originalAlbumIds: [Int] = []
    @State private var newAlbumTitlte: String = ""
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 0) {
                Text("어떤 행복이었나요?")
                    .madiiFont(font: .madiiTitle, color: .madiiNormal)
                    .padding(.bottom, 16)
                
                Text(joyTitle)
                    .madiiFont(font: .madiiBody2, color: .madiiNormal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(12)
                    .background(.madiiGray30)
                    .cornerRadius(12)
                    .padding(.bottom, 40)
                
                Text("어떤 앨범에 저장할까요?")
                    .madiiFont(font: .madiiTitle, color: .madiiNormal)
                    .padding(.bottom, 16)
                
                ForEach(albums) { album in
                    Button {
                        if let index = selectedAlbumIds.firstIndex(of: album.id) {
                            selectedAlbumIds.remove(at: index)
                        } else {
                            selectedAlbumIds.append(album.id)
                        }
                    } label: {
                        Text(album.title)
                            .madiiFont(font: .madiiBody2, color: .madiiNormal)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(12)
                            .frame(height: 50)
                            .background(.madiiGray30)
                            .cornerRadius(12)
                            .roundedBorder(cornerRadius: 12, color: selectedAlbumIds.contains(album.id) ? .madiiGreen100 : Color.clear)
                    }
                }
                .padding(.bottom, 16)
                
                Button {
                    showEditJoyBottomSheet = false
                     showAddNewAlbumBottomSheet = true
                } label: {
                    MadiiDesignSystem.MadiiTextField(text: $newAlbumTitlte, isPlus: true, placeholder: "새로운 앨범")
                }
            }
            .padding(.vertical, 40)
            
            HStack(spacing: 10) {
                MadiiDesignSystem.MadiiButton(title: "취소", color: .neutral) {
                    showEditJoyBottomSheet = false
                }
                .frame(width: 82)
                
                MadiiDesignSystem.MadiiButton(title: "수정", color: .mainColor) {
                    editJoy()
                }
            }
            .padding(.bottom, 40)
        }
        .padding(.horizontal, 20)
        .background(.madiiElevated)
        .cornerRadius(40)
        .padding(.horizontal, 20)
        .background(.clear)
        .onAppear {
            getAllAlbums()
            getSavedAlbumsIdByJoy()
        }
    }
    
    func getAllAlbums() {
        RecordAPI.shared.getAlbums { isSuccess, albumList in
            if isSuccess {
                albums = []
                for album in albumList {
                    let newAlbum = Album(id: album.albumId, backgroundColorNum: album.albumColorNum, iconNum: album.joyIconNum, title: album.name)
                    albums.append(newAlbum)
                }
            } else {
                print("DEBUG MyAlbumsView: isSuccess false")
            }
        }
    }
    
    func getSavedAlbumsIdByJoy() {
        AlbumAPI.shared.getAlbumsWithJoySavedInfo(joyId: joyId) { isSuccess, albumList in
            if isSuccess {
                print("debug getAlbumsWithJoySavedInfo: isSuccess true")
                selectedAlbumIds = albumList.compactMap { dto in
                    dto.isSaved ? dto.albumId : nil
                }
                originalAlbumIds = albumList.compactMap { dto in
                    dto.isSaved ? dto.albumId : nil
                }
            } else {
                print("debug getAlbumsWithJoySavedInfo: isSuccess false")
            }
        }
    }
    
    func editJoy() {
        RecordAPI.shared.editJoy(joyId: joyId, contents: joyTitle, beforeAlbumIds: originalAlbumIds, afterAlbumIds: selectedAlbumIds) { isSuccess, joyResponse in
            if isSuccess {
                print("debug editJoy: isSuccess true")
                showEditJoyBottomSheet = false
            } else {
                print("debug editJoy: isSuccess false")
            }
        }
    }
}
