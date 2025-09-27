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
        VStack(alignment: .leading) {
            Text("소확행 삭제")
                .madiiFont(font: .title2, color: .madiiStrong)
                .padding(.top, 40)
                .padding(.bottom, 24)
            
            Text("선택한 소확행을 삭제하시겠어요?\n한번 삭제된 내 소확행은 복구할 수 없어요")
                .madiiFont(font: .madiiBody2, color: .madiiStrong)
                .padding(.bottom, 40)
            
            HStack(spacing: 10) {
                MadiiDesignSystem.MadiiButton(title: "취소", color: .neutral) {
                    showDeleteJoyBottomSheet = false
                }
                .frame(width: 82)
                
                MadiiDesignSystem.MadiiButton(title: "삭제", color: .mainColor)
            }
        }
        .padding(.horizontal, 20)
    }
    
    func deleteJoy() {
        JoyAPI.shared.deleteJoy(joyId: joyId) { isSuccess in
            if isSuccess {
                print("소확행 삭제 성공")
            } else {
                print("소확행 삭제 실패")
            }
        }
    }
}

#Preview {
    DeleteJoyBottomSheet(showDeleteJoyBottomSheet: .constant(true), joyId: .constant(0))
}
