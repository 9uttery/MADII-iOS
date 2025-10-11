//
//  RenameJoyBottomSheet.swift
//  Madii
//
//  Created by 정태우 on 9/27/25.
//

import MadiiDesignSystem
import SwiftUI

struct RenameJoyBottomSheet: View {
    @State var newJoyTitle: String = ""
    @State var joyId: Int = 0
    
    var body: some View {
        VStack {
            Rectangle()
                .frame(width: 100, height: 5)
                .foregroundStyle(.madiiContrast)
                .cornerRadius(2.5)
                .padding(.top, 16)

            Text("수정하기")
                .madiiFont(font: .title2, color: .madiiStrong)
                .padding(.top, 40)
                .padding(.bottom, 24)
            
            TextField("새로운 소확행 이름", text: $newJoyTitle)
                .padding(.bottom, 40)
                
            MadiiDesignSystem.MadiiButton(title: "완료", color: .mainColor)
                .padding(.bottom, 40)
        }
        .padding(.horizontal, 20)
        .background(.madiiElevated)
    }
}

#Preview {
    RenameJoyBottomSheet(newJoyTitle: "", joyId: 0)
}
