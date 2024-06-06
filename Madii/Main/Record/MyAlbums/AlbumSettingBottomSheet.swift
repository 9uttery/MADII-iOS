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
                        AnalyticsManager.shared.logEvent(name: "앨범설정바텀시트_앨범이름・설명수정클릭")
                    } label: {
                        albumRow(title: "앨범 이름・설명 수정")
                    }
                    
                    Button {
                        showAddJoyPopUp = true
                        AnalyticsManager.shared.logEvent(name: "앨범설정바텀시트_소확행추가클릭")
                    } label: {
                        albumRow(title: "소확행 추가")
                    }
                    
                    toggleRow
                    
                    Button {
                        withoutAnimation { showDeleteAlbumPopUp = true }
                        AnalyticsManager.shared.logEvent(name: "앨범설정바텀시트_삭제클릭")
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
            ChangePublicPopUp(album: album, isAlbumPublic: $isAlbumPublic, showChangePublicPopUp: $showChangePublicPopUp) }
        // 앨범 삭제
        .transparentFullScreenCover(isPresented: $showDeleteAlbumPopUp) {
            DeleteAlbumPopUp(album: album, showDeleteAlbumPopUp: $showDeleteAlbumPopUp, dismiss: dismiss) }
        // 앨범 공개 여부 가져오기
        .onAppear {
            isAlbumPublic = album.isPublic
            canShowChangePublicPopUp = true
            showChangePublicPopUp = false
        }
        .analyticsScreen(name: "앨범설정바텀시트")
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
            
            Button {
                withoutAnimation {
                    showChangePublicPopUp = true
                    AnalyticsManager.shared.logEvent(name: "앨범설정바텀시트_전체공개여부설정클릭")
                }
            } label: {
                if isAlbumPublic {
                    Image(systemName: "checkmark.square.fill")
                        .frame(width: 22, height: 22)
                        .foregroundStyle(Color.madiiYellowGreen)
                        .padding()
                        .frame(width: 28, height: 28)
                } else {
                    Image(systemName: "checkmark.square")
                        .frame(width: 22, height: 22)
                        .foregroundStyle(Color.gray500)
                        .padding()
                        .frame(width: 28, height: 28)
                }
            }
        }
        .padding(.horizontal, 16)
        .frame(height: 50)
    }
}
