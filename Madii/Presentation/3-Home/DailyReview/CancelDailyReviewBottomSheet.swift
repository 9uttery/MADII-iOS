//
//  CancelDailyReviewBottomSheet.swift
//  Madii
//
//  Created by 정태우 on 10/21/25.
//

import MadiiDesignSystem
import SwiftUI

struct CancelDailyReviewBottomSheet: View {
    @Binding var showCancelDailyReviewBottomSheet: Bool
    @Binding var cancelDailyReview: Bool
    
    var body: some View {
        VStack {
            Rectangle()
                .frame(width: 100, height: 5)
                .foregroundStyle(.madiiContrast)
                .cornerRadius(2.5)
                .padding(.top, 16)
            
            Text("기록을 그만두시겠어요?")
                .madiiFont(.title1)
                .foregroundStyle(.madiiStrong)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 40)
                .padding(.bottom, 24)
            
            Text("오늘 하루 돌아보기 기록을 그만두시겠어요?\n현재까지 작성된 내용은 저장되지 않아요")
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(.madiiStrong)
                .multilineTextAlignment(.leading)
                .lineLimit(nil)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 40)
            
            HStack(spacing: 10) {
                MadiiDesignSystem.MadiiButton(title: "닫기", color: .neutral) {
                    showCancelDailyReviewBottomSheet = false
                }
                .frame(width: 82)
                
                MadiiDesignSystem.MadiiButton(title: "종료하기", color: .mainColor) {
                    showCancelDailyReviewBottomSheet = false
                    cancelDailyReview = true
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
}
