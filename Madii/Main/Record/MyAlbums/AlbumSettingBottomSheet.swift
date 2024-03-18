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
    @State private var showAddJoyPopUp: Bool = false
    @State private var isAlbumPublic: Bool = false
    @State private var canShowChangePublicPopUp: Bool = false
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
                    
                    Button {
                        showAddJoyPopUp = true
                    } label: {
                        albumRow(title: "소확행 추가")
                    }
                    
                    toggleRow
                        .onChange(of: isAlbumPublic) { _ in
                            if canShowChangePublicPopUp {
                                showChangePublicPopUp = true
                            }
                        }
                    
                    Button {
                        withoutAnimation { showDeleteAlbumPopUp = true }
                    } label: {
                        albumRow(title: "삭제")
                    }
                }
                
                Spacer()
            }
        }
        .ignoresSafeArea()
        // 소확행 추가
        .transparentFullScreenCover(isPresented: $showAddJoyPopUp) {
            AddJoyPopUp(album: album, showAddJoyPopUp: $showAddJoyPopUp) }
        // 앨범 전체 공개 여부
        .transparentFullScreenCover(isPresented: $showChangePublicPopUp) {
            ChangePublicPopUp(album: album, isAlbumPublic: $isAlbumPublic, canShowChangePublicPopUp: $canShowChangePublicPopUp, showChangePublicPopUp: $showChangePublicPopUp) }
        // 앨범 삭제
        .transparentFullScreenCover(isPresented: $showDeleteAlbumPopUp) {
            DeleteAlbumPopUp(album: album, showDeleteAlbumPopUp: $showDeleteAlbumPopUp, dismiss: dismiss) }
        // 앨범 공개 여부 가져오기
        .onAppear {
            isAlbumPublic = album.isPublic
            canShowChangePublicPopUp = true
            showChangePublicPopUp = false
        }
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
