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
    
    @State private var isAlbumPublic: Bool = false
    @State private var showDeleteAlbumPopUp: Bool = false
    
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
                        
                    } label: {
                        albumRow(title: "앨범 이름・설명 수정")
                    }
                    
                    albumRow(title: "소확행 추가")
                    
                    toggleRow
                        .onChange(of: isAlbumPublic) { _ in
                            print("wow")
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
        .transparentFullScreenCover(isPresented: $showDeleteAlbumPopUp) {
            ZStack {
                Color.black.opacity(0.8).ignoresSafeArea()
                    .onTapGesture { withoutAnimation { showDeleteAlbumPopUp = false } }
                
                PopUpWithDescription(title: "앨범 삭제", description: "선택한 앨범을 삭제하시겠어요?\n한번 삭제된 내 앨범은 복구할 수 없어요", leftButtonAction: { showDeleteAlbumPopUp = false } , rightButtonTitle: "삭제", rightButtonAction: {})
                    .padding(.horizontal, 36)
            }
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
