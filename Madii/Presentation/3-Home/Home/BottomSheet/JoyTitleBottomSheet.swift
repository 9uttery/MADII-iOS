//
//  JoyTitleBottomSheet.swift
//  Madii
//
//  Created by 정태우 on 3/28/26.
//

import MadiiDesignSystem
import SwiftUI

struct JoyTitleBottomSheet: View {
    @Binding var joyTitle: String
    @Binding var showJoyTitleBottomSheet: Bool
    
    var body: some View {
        VStack {
            Rectangle()
                .frame(width: 100, height: 5)
                .foregroundStyle(.madiiContrast)
                .cornerRadius(2.5)
                .padding(.top, 16)
            
            Text(joyTitle)
                .madiiFont(.title2)
                .foregroundStyle(.madiiStrong)
                .padding(.vertical, 40)
            
            MadiiDesignSystem.MadiiButton(title: "닫기", color: .mainColor) {
                showJoyTitleBottomSheet = false
            }
            .padding(.bottom, 20)
        }
        .padding([.horizontal, .bottom], 20)
        .background(.madiiElevated)
        .cornerRadius(40)
        .padding(.horizontal, 20)
        .background(.clear)
    }
}
