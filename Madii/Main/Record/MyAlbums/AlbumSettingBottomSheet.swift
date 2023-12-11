//
//  AlbumSettingBottomSheet.swift
//  Madii
//
//  Created by 이안진 on 12/4/23.
//

import SwiftUI

struct AlbumSettingBottomSheet: View {
    @EnvironmentObject private var tabBarManager: TabBarManager
    @EnvironmentObject private var popUpStatus: PopUpStatus
    
    @Binding var showAlbumSettingSheet: Bool
    
    let title: String = "소확행 앨범 제목"
    let description: String = "설명 어쩌고 저쩌고"
    
    @State private var isAlbumPublic: Bool = false
    
    var body: some View {
        ZStack {
            Color.madiiPopUp
            
            VStack(alignment: .leading, spacing: 0) {
                // 앨범 설명
                HStack(spacing: 16) {
                    // 앨범 이미지
                    Rectangle()
                        .frame(width: 60, height: 60)
                        .foregroundStyle(Color.gray400)
                        .cornerRadius(8)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text(title)
                            .madiiFont(font: .madiiBody3, color: .white)
                        
                        Text(description)
                            .madiiFont(font: .madiiBody4, color: .gray500)
                    }
                }
                .padding(.vertical, 22)
                
                // 앨범 설정 row
                VStack(alignment: .leading, spacing: 10) {
                    Button {
                        tabBarManager.isTabBarShown = false
                        showAlbumSettingSheet = false
                        popUpStatus.showChangeAlbumInfo = true
                    } label: {
                        AlbumSettingBottomSheetRow(title: "앨범 이름・설명 수정")
                    }
                    
                    AlbumSettingBottomSheetRow(title: "소확행 추가")
                    
                    AlbumSettingBottomSheetToggleRow(title: "전체 공개 여부 설정", isToggleTrue: $isAlbumPublic)
                    
                    AlbumSettingBottomSheetRow(title: "삭제")
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 40)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    MadiiTabView()
}
