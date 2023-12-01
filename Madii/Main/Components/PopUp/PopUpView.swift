//
//  PopUpView.swift
//  Madii
//
//  Created by 이안진 on 12/1/23.
//

import SwiftUI

struct PopUpView<Content>: View where Content: View {
    let title: String
    var leftButtonAction: () -> Void
    var rightButtonAction: () -> Void
    
    @ViewBuilder var content: Content
    
    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            VStack(alignment: .leading, spacing: 24) {
                Text(title)
                    .madiiFont(font: .madiiSubTitle, color: .white)
                
                content
            }
            
            HStack(spacing: 8) {
                Button {
                    leftButtonAction()
                } label: {
                    // FIXME: 버튼 컴포넌트로 변경
                    Rectangle()
                        .fill(Color.white)
                        .frame(height: 40)
                        .cornerRadius(6)
                }
                    
                Button {
                    rightButtonAction()
                } label: {
                    Rectangle()
                        .fill(Color.white)
                        .frame(height: 40)
                        .cornerRadius(6)
                }
            }
        }
        .padding(.vertical, 24)
        .padding(.horizontal, 20)
        // FIXME: 색상 이름 추가
        .background(Color(red: 0.17, green: 0.18, blue: 0.23))
        .cornerRadius(14)
    }
}
