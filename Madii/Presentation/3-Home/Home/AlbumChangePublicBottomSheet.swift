//
//  AlbumChangePublicBottomSheet.swift
//  Madii
//
//  Created by 정태우 on 10/15/25.
//

import MadiiDesignSystem
import SwiftUI

struct AlbumChangePublicBottomSheet: View {
    @Binding var showAlbumChangePublicBottomSheet: Bool
    @Binding var albumId: Int
    
    var body: some View {
        VStack {
            Rectangle()
                .frame(width: 100, height: 5)
                .foregroundStyle(.madiiContrast)
                .cornerRadius(2.5)
                .padding(.top, 16)
            
            Text("앨범을 전체 공개하시겠어요?")
                .madiiFont(font: .madiiTitle, color: .madiiStrong)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 40)
                .padding(.bottom, 24)
            
            Text("공개 시 다시 비공개로 변경할 수 없어요")
                .madiiFont(font: .madiiBody2, color: .madiiStrong)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 40)
            
            HStack(spacing: 10) {
                MadiiDesignSystem.MadiiButton(title: "닫기", color: .neutral) {
                    showAlbumChangePublicBottomSheet = false
                }
                .frame(width: 82)
                
                MadiiDesignSystem.MadiiButton(title: "전체 공개하기", color: .mainColor) {
                    toggleIsPublic()
                }
            }
            .padding(.bottom, 40)
        }
        .padding(.horizontal, 20)
        .background(.madiiElevated)
        .cornerRadius(40)
        .padding(.horizontal, 20)
        .background(.clear)
    }
        
    func toggleIsPublic() {
        AlbumAPI.shared.changePublic(albumId: albumId) { isSuccess in
            if isSuccess {
                print("Debug changePublic: isSuccess true")
                showAlbumChangePublicBottomSheet = false
            } else {
                print("Debug changePublic: isSuccess false")
            }
        }
    }
}
