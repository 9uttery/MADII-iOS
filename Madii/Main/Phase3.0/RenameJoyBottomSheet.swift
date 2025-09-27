//
//  RenameJoyBottomSheet.swift
//  Madii
//
//  Created by 정태우 on 9/27/25.
//

import MadiiDesignSystem
import SwiftUI

struct RenameJoyBottomSheet: View {
    @State var newJoyTitle: String
    var body: some View {
        VStack {
            Text("수정하기")
                .madiiFont(font: .title2, color: .madiiStrong)
                .padding(.top, 40)
                .padding(.bottom, 24)
            
            TextField("새로운 소확행 이름", text: $newJoyTitle)
                .padding(.bottom, 40)
                
            MadiiDesignSystem.MadiiButton(title: "완료", color: .mainColor)
                .padding(.bottom, 40)
        }
    }
}

#Preview {
    RenameJoyBottomSheet(newJoyTitle: "")
}
