//
//  MyProfileView.swift
//  Madii
//
//  Created by 정태우 on 1/25/24.
//

import SwiftUI

struct MyProfileView: View {
    @State var nickName: String = ""
    var body: some View {
        VStack() {
            Image("defaultProfile")
                .resizable()
                .frame(width: 116, height: 116)
            
            HStack() {
                TextField("닉네임을 입력해주세요", text: $nickName, axis: .vertical)
                    .madiiFont(font: .madiiBody3, color: .white)
                    .onChange(of: nickName) { newValue in
                        // 입력값이 변경될 때 호출되는 블록
                        // 여기서 원하는 동작을 수행하면 됩니다.
                        let limitedInput = String(newValue.prefix(10)) // 최대 10글자로 제한
                        nickName = limitedInput
                    }
                
                Text("\(nickName.count)/10")
                    .madiiFont(font: .madiiBody3, color: .gray500)
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 12)
            .background(Color.madiiOption)
            .cornerRadius(8)
            HStack {
                Text("특수문자는 사용하실 수 없어요.")
                    .madiiFont(font: .madiiBody4, color: .gray500)
                Spacer()
            }
            Spacer()
            StyleJoyNextButton(label: "저장", isDisabled: nickName.isEmpty)
        }
        .padding(.horizontal, 16)
        .navigationTitle("프로필")
        .toolbarBackground(Color.madiiBox, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

#Preview {
    MyProfileView()
}
