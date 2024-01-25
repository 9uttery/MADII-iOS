//
//  JoyRow.swift
//  Madii
//
//  Created by 이안진 on 12/1/23.
//

import SwiftUI

struct JoyRow: View {
    let title: String
    
    var body: some View {
        HStack(spacing: 15) {
            // 소확행 커버 이미지
            Circle()
                .frame(width: 48, height: 48)
                .foregroundStyle(Color.black)
                .overlay {
                    Circle()
                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                }
            
            Text(title)                  
                .madiiFont(font: .madiiBody3, color: .white)
            
            Spacer()
        }
    }
}

struct JoyRowWithButton<Content>: View where Content: View {
    let title: String
    var buttonAction: () -> Void
    
    @ViewBuilder var buttonLabel: Content
    
    var body: some View {
        HStack(spacing: 15) {
            // 소확행 커버 이미지
            Circle()
                .frame(width: 48, height: 48)
                .foregroundStyle(Color.black)
                .overlay { Circle().stroke(Color.white.opacity(0.2), lineWidth: 1) }
            
            Text(title)
                .madiiFont(font: .madiiBody3, color: .white)
            
            Spacer()
            
            Button { buttonAction() } label: { buttonLabel }
        }
    }
}
