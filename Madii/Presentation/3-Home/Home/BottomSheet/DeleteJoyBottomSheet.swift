//
//  DeleteJoyBottomSheet.swift
//  Madii
//
//  Created by 정태우 on 9/22/25.
//

import MadiiDesignSystem
import SwiftUI

struct DeleteJoyBottomSheet: View {
    @Binding var showDeleteJoyBottomSheet: Bool
    @Binding var joyId: Int
    
    var body: some View {
        VStack {
            Rectangle()
                .frame(width: 100, height: 5)
                .foregroundStyle(.madiiContrast)
                .cornerRadius(2.5)
                .padding(.top, 16)
            
            Text("행복 기록을 삭제하시겠어요?")
                .madiiFont(font: .madiiTitle, color: .madiiStrong)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 40)
                .padding(.bottom, 24)
            
            Text("삭제된 기록은 복원되지 않아요")
                .madiiFont(font: .madiiBody2, color: .madiiStrong)
                .lineSpacing(9.6)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 40)
            
            HStack(spacing: 10) {
                MadiiDesignSystem.MadiiButton(title: "취소", color: .neutral) {
                    showDeleteJoyBottomSheet = false
                }
                .frame(width: 82)
                
                MadiiDesignSystem.MadiiButton(title: "삭제", color: .mainColor) {
                    deleteJoy()
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
    
    func deleteJoy() {
        JoyAPI.shared.deleteJoy(joyId: joyId) { isSuccess in
            if isSuccess {
                print("소확행 삭제 성공")
                showDeleteJoyBottomSheet = false
            } else {
                print("소확행 삭제 실패")
            }
        }
    }
}

#Preview {
    DeleteJoyBottomSheet(showDeleteJoyBottomSheet: .constant(true), joyId: .constant(0))
}
