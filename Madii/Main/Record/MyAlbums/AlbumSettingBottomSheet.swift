//
//  AlbumSettingBottomSheet.swift
//  Madii
//
//  Created by 이안진 on 12/4/23.
//

import SwiftUI

struct AlbumSettingBottomSheet: View {
    let album: Album
    @Binding var showAlbumSettingSheet: Bool
    
    @Binding var showChangeInfo: Bool
    @State private var isAlbumPublic: Bool = false
    @State private var showChangePublicPopUp: Bool = false
    @State private var showDeleteAlbumPopUp: Bool = false
    
    var dismiss: () -> Void
    
    var body: some View {
        ZStack {
            Color.madiiPopUp
            
            VStack(alignment: .leading, spacing: 12) {
                // 앨범 설명
                VStack(alignment: .leading, spacing: 12) {
                    Text(album.title)
                        .madiiFont(font: .madiiTitle, color: .white)
                        
                    Text(album.description)
                        .madiiFont(font: .madiiBody4, color: .white.opacity(0.6))
                    
                    HStack { Spacer() }
                }
                .padding(.horizontal, 16)
                .padding(.top, 28)
                .padding(.bottom, 32)
                .background(Color.madiiOption)
                
                // 앨범 설정 row
                VStack(alignment: .leading, spacing: 0) {
                    Button {
                        showAlbumSettingSheet = false
                        showChangeInfo = true
                    } label: {
                        albumRow(title: "앨범 이름・설명 수정")
                    }
                    
                    albumRow(title: "소확행 추가")
                    
                    toggleRow
                        .onChange(of: isAlbumPublic) { _ in
                            showChangePublicPopUp = true
                        }
                    
                    Button {
                        showDeleteAlbumPopUp = true
                    } label: {
                        albumRow(title: "삭제")
                    }
                }
                
                Spacer()
            }
        }
        .ignoresSafeArea()
        // 앨범 정보 수정
//        .transparentFullScreenCover(isPresented: $showChangeInfo) {
//            ChangeAlbumInfoPopUpView(showChangeInfo: $showChangeInfo) }
        // 앨범 전체 공개 여부
        .transparentFullScreenCover(isPresented: $showChangePublicPopUp) {
            ChangePublicPopUp(album: album, isAlbumPublic: $isAlbumPublic, showChangePublicPopUp: $showChangePublicPopUp) }
        // 앨범 삭제
        .transparentFullScreenCover(isPresented: $showDeleteAlbumPopUp) {
            DeleteAlbumPopUp(album: album, showDeleteAlbumPopUp: $showDeleteAlbumPopUp, dismiss: dismiss) }
        .onAppear { }
    }
    
    @ViewBuilder
    private func albumRow(title: String) -> some View {
        HStack {
            Text(title)
                .madiiFont(font: .madiiBody3, color: .white)
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .frame(height: 50)
    }
    
    private var toggleRow: some View {
        HStack {
            Text("전체 공개 여부 설정")
                .madiiFont(font: .madiiBody3, color: .white)
                
            Spacer()
            
            Toggle("", isOn: $isAlbumPublic)
                .tint(.madiiYellowGreen)
        }
        .padding(.horizontal, 16)
        .frame(height: 50)
    }
}
