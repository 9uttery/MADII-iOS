//
//  SaveMyJoyView.swift
//  Madii
//
//  Created by 이안진 on 12/1/23.
//

import SwiftUI

struct SaveMyJoyView: View {
    @Binding var isTabBarShown: Bool
    
    @State private var myNewJoy: String = "샤브샤브 먹고 싶어"
    @Binding var showSaveJoyPopUp: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("나만의 소확행을 수집해보세요")
                .madiiFont(font: .madiiSubTitle, color: .white)
            
            HStack(spacing: 0) {
                TextField("누워서 빗소리 감상하기", text: $myNewJoy)
                    .madiiFont(font: .madiiBody3, color: .white, withHeight: true)
                
                Button {
                    isTabBarShown = false
                    showSaveJoyPopUp = true
                } label: {
                    Image(myNewJoy.isEmpty ? "inactiveSave" : "activeSave")
                        .resizable()
                        .frame(width: 36, height: 36)
                }
                .disabled(myNewJoy.isEmpty)
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 16)
            .background(Color.madiiOption)
            .cornerRadius(6)
        }
        .roundBackground()
    }
}

#Preview {
    MadiiTabView()
}
