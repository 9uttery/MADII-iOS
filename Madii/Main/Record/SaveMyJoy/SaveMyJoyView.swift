//
//  SaveMyJoyView.swift
//  Madii
//
//  Created by 이안진 on 12/1/23.
//

import SwiftUI

struct SaveMyJoyView: View {
    @State private var myNewJoy: String = ""
    @Binding var showSaveJoyToast: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("나만의 소확행을 기록해 보세요")
                .madiiFont(font: .madiiSubTitle, color: .white)
            
            HStack(spacing: 12) {
                TextField("누워서 빗소리 감상하기", text: $myNewJoy)
                    .madiiFont(font: .madiiBody3, color: .white, withHeight: true)
                    .onChange(of: myNewJoy, perform: { myNewJoy = String($0.prefix(30)) })
                
                Button {
                    saveJoy()
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
    
    private func saveJoy() {
        JoyAPI.shared.postJoy(contents: myNewJoy) { isSuccess, joyContent in
            if isSuccess {
                hideKeyboard()
                myNewJoy = ""
                
                withAnimation { showSaveJoyToast = true }
                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                    withAnimation { showSaveJoyToast = false }
                }
            } else {
                print("DEBUG SaveMyJoyView: isSuccess false")
            }
        }
    }
    
    // 키보드 내리기
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    MadiiTabView()
}
