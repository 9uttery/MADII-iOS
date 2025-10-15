//
//  CloseEditAlbumBottomSheet.swift
//  Madii
//
//  Created by 정태우 on 9/26/25.
//

import MadiiDesignSystem
import SwiftUI

struct CloseEditAlbumBottomSheet: View {
    @Binding var isEdit: Bool
    @Binding var isShowCloseEditAlbumBottomSheet: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Rectangle()
                .frame(width: 100, height: 5)
                .foregroundStyle(.madiiContrast)
                .cornerRadius(2.5)
                .padding(.top, 16)
            
            Text("앨범 편집 종료")
                .madiiFont(font: .madiiTitle, color: .madiiStrong)
                .padding(.top, 40)
                .padding(.bottom, 24)
            
            Text("지금 돌아가면 앨범 수정 내용이 삭제됩니다.")
                .madiiFont(font: .madiiBody2, color: .madiiStrong)
                .lineSpacing(9.6)
                .padding(.bottom, 40)
            
            HStack(spacing: 10) {
                MadiiDesignSystem.MadiiButton(title: "취소", color: .neutral) {
                    isShowCloseEditAlbumBottomSheet = false
                }
                .frame(width: 82)
                
                MadiiDesignSystem.MadiiButton(title: "종료", color: .mainColor) {
                    isEdit = false
                }
            }
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    CloseEditAlbumBottomSheet(isEdit: .constant(true), isShowCloseEditAlbumBottomSheet: .constant(true))
}
