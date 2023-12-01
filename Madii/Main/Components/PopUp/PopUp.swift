//
//  PopUp.swift
//  Madii
//
//  Created by 이안진 on 12/1/23.
//

import SwiftUI

struct PopUp<Content>: View where Content: View {
    let title: String
    
    var leftButtonTitle: String
    var leftButtonAction: () -> Void
    
    var rightButtonTitle: String
    var rightButtonColor: ButtonColor
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
                    MadiiButton(title: leftButtonTitle, size: .small)
                }
                    
                Button {
                    rightButtonAction()
                } label: {
                    MadiiButton(title: rightButtonTitle, color: rightButtonColor, size: .small)
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
