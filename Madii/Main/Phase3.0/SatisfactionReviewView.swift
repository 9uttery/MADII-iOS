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
    
    var body: some View {
        VStack {
            Text("오늘 하루 얼마나 만족하셨나요?")
                .madiiFont(font: .madiiSubTitle, color: .madiiNormal)
            
            Image("")
            
            Spacer()
            
            MadiiDesignSystem.MadiiButton(title: "다음", color: .violet) {
                tabNum = 2
            }
        }
    }
}

#Preview {
    SatisfactionReviewView(tabNum: .constant(0))
}
