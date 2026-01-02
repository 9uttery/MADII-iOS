//
//  SatisfactionReviewView.swift
//  Madii
//
//  Created by 정태우 on 9/19/25.
//

import MadiiDesignSystem
import SwiftUI

struct SatisfactionReviewView: View {
    @Binding var tabNum: Int
    @Binding var satisfaction: Int
    
    var body: some View {
        VStack {
            Text("오늘 하루 얼마나 만족하셨나요?")
                .madiiFont(.subTitle)
                .foregroundStyle(.madiiNormal)
            
            Image("satisfaction\(satisfaction.intToSatisfaction)")
                .resizable()
                .frame(width: 60, height: 60)
                .padding(.vertical, 40)
            
            SatisfactionSlider(value: $satisfaction)
                .padding(.bottom, 12)
            
            HStack {
                Text("힘든 하루였어요")
                    .madiiFont(.caption)
                    .foregroundStyle(.madiiAlternative)
                
                Spacer()
                
                Text("행복이 가득했어요")
                    .madiiFont(.caption)
                    .foregroundStyle(.madiiAlternative)
            }
            
            Spacer()
            
            MadiiDesignSystem.MadiiButton(title: "다음", color: .violet) {
                tabNum = 2
            }
        }
        .animation(.easeIn, value: satisfaction)
    }
}

#Preview {
    SatisfactionReviewView(tabNum: .constant(0), satisfaction: .constant(0))
}
