//
//  RenameJoyBottomSheet.swift
//  Madii
//
//  Created by 정태우 on 9/27/25.
//

import MadiiDesignSystem
import SwiftUI

struct RenameJoyBottomSheet: View {
    @Binding var showRenameJoyBottomSheet: Bool
    @Binding var newJoyTitle: String
    @Binding var isSuccessEditJoy: Bool
    @Binding var joyId: Int
    
    var body: some View {
        VStack {
            Rectangle()
                .frame(width: 100, height: 5)
                .foregroundStyle(.madiiContrast)
                .cornerRadius(2.5)
                .padding(.top, 16)

            Text("수정하기")
                .madiiFont(font: .madiiTitle, color: .madiiStrong)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 40)
                .padding(.bottom, 24)
            
            TextField("새로운 소확행 이름", text: $newJoyTitle)
                .padding(12)
                .background(.madiiGray30)
                .cornerRadius(12)
                .padding(.bottom, 40)
                
            MadiiDesignSystem.MadiiButton(title: "완료", color: .mainColor) {
                editJoyTitle()
            }
                .padding(.bottom, 40)
        }
        .padding(.horizontal, 20)
        .background(.madiiElevated)
        .cornerRadius(40)
        .padding(.horizontal, 20)
        .background(.clear)
        .dismissKeyboardOnTap() 
    }
    
    func editJoyTitle() {
        RecordAPI.shared.editJoy(joyId: joyId, contents: newJoyTitle) { isSuccess in
            if isSuccess {
                print("debug editJoy: isSuccess true")
                showRenameJoyBottomSheet = false
                isSuccessEditJoy = true
            } else {
                print("debug editJoy: isSuccess false")
            }
        }
    }
}
