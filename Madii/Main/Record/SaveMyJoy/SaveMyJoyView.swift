//
//  SaveMyJoyView.swift
//  Madii
//
//  Created by 이안진 on 12/1/23.
//

import SwiftUI

struct SaveMyJoyView: View {
    @Binding var joy: Joy
    @State private var placeholder: String = ""
    @State private var myNewJoy: String = ""
    @Binding var showSaveJoyToast: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("나만의 소확행을 기록해보세요")
                .madiiFont(font: .madiiSubTitle, color: .white)
            
            HStack(spacing: 12) {
                TextField(placeholder, text: $myNewJoy)
                    .madiiFont(font: .madiiBody3, color: .white, withHeight: true)
                    .onChange(of: myNewJoy, perform: { myNewJoy = String($0.prefix(30)) })
                
                Button {
                    saveJoy()
                    AnalyticsManager.shared.logEvent(name: "레코드뷰_저장클릭")
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
        .onTapGesture { hideKeyboard() }
        .onAppear { getPlaceholder() }
    }
    
    private func getPlaceholder() {
        RecordAPI.shared.getPlaceholder { isSuccess, placeholder in
            if isSuccess {
                self.placeholder = placeholder
            } else {
                print("DEBUG SaveMyJoyView: isSuccess false")
            }
        }
    }
    
    private func saveJoy() {
        JoyAPI.shared.postJoy(contents: myNewJoy) { isSuccess, newJoy in
            if isSuccess {
                hideKeyboard()
                myNewJoy = ""
                joy = Joy(joyId: newJoy.joyId, icon: newJoy.joyIconNum, title: newJoy.contents)
                
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
