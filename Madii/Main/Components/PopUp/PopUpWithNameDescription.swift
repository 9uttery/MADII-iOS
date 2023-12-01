//
//  PopUpWithNameDescription.swift
//  Madii
//
//  Created by 이안진 on 12/1/23.
//

import SwiftUI

struct PopUpWithNameDescription: View {
    let title: String = "앨범 이름 & 설명 수정"
    
    var leftButtonTitle: String = "취소"
    var leftButtonAction: () -> Void = {}
    
    var rightButtonTitle: String = "확인"
    var rightButtonAction: () -> Void = {}
    
    @State var name: String = ""
    @State var description: String = ""
    
    var body: some View {
        PopUp(title: title,
              leftButtonTitle: leftButtonTitle, leftButtonAction: leftButtonAction,
              rightButtonTitle: rightButtonTitle, rightButtonColor: rightButtonColor(),
              rightButtonAction: rightButtonAction) {
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("이름")
                        .madiiFont(font: .madiiBody2, color: .white)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 6)
                    
                    TextField("앨범 이름을 적어주세요.", text: $name, axis: .vertical)
                        .madiiFont(font: .madiiBody3, color: .white)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 6)
                        // FIXME: Color System에 없는 색상 -> 추후 추가해서 넣기
                        .background(Color(red: 0.21, green: 0.22, blue: 0.29))
                        .cornerRadius(4)
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("설명")
                        .madiiFont(font: .madiiBody2, color: .white)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 6)
                    
                    TextField("앨범에 대한 소개를 적어주세요.(30자 이내)", text: $description, axis: .vertical)
                        .madiiFont(font: .madiiBody3, color: .white)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 6)
                        // FIXME: Color System에 없는 색상 -> 추후 추가해서 넣기
                        .background(Color(red: 0.21, green: 0.22, blue: 0.29))
                        .cornerRadius(4)
                }
            }
        }
          .padding(20)
    }
    
    func rightButtonColor() -> ButtonColor {
        if name.isEmpty || description.isEmpty {
            return .gray
        } else {
            return .yellowGreen
        }
    }
}

#Preview {
    PopUpWithNameDescription()
}
