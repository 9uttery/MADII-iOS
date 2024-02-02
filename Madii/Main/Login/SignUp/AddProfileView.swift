//
//  AddProfileView.swift
//  Madii
//
//  Created by 이안진 on 2/2/24.
//

import SwiftUI

struct AddProfileView: View {
    @State private var nickname: String = ""
    @State private var isNicknameVaild: Bool = false
    private var helperMessage: String {
        isNicknameVaild ? "사용할 수 있는 닉네임이에요." : "대소문자 영문 및 한글, 숫자만 사용 가능해요."
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("시작 전 프로필을 완성해보세요")
                .madiiFont(font: .madiiTitle, color: .white)
                .padding(.horizontal, 8)
                .padding(.vertical, 10)
                .padding(.bottom, 36)
                .padding(.horizontal, 18)
            
            VStack(spacing: 24) {
                Circle()
                    .frame(width: 140, height: 140)
                
                MadiiTextField(placeHolder: "닉네임을 입력해주세요", text: $nickname,
                               strokeColor: strokeColor(), limit: 10)
                    .textFieldHelperMessage(helperMessage, color: strokeColor())
                    .onChange(of: nickname) { checkValidNickname($0) }
            }
            .padding(.horizontal, 24)
            
            Spacer()
            
            Button {
                
            } label: {
                MadiiButton(title: "완료", size: .big)
                    .opacity(isNicknameVaild ? 1.0 : 0.4)
            }
            .disabled(isNicknameVaild == false)
            .padding(.horizontal, 18)
            .padding(.bottom, 24)
        }
    }
    
    private func checkValidNickname(_ nickname: String) {
        let nicknameRegEx = "^[가-힣a-zA-Z0-9]*$"
        let nicknamePred = NSPredicate(format: "SELF MATCHES %@", nicknameRegEx)
        isNicknameVaild = nicknamePred.evaluate(with: nickname)
        if nickname.isEmpty { isNicknameVaild = false }
    }
    
    private func strokeColor() -> Color {
        if nickname.isEmpty {
            return Color.gray500
        } else if isNicknameVaild {
            return Color.madiiYellowGreen
        } else {
            return Color.madiiOrange
        }
    }
}

#Preview {
    SignUpView()
}
