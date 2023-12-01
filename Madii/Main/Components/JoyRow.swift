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
                .fill(Color.madiiOrange)
                .frame(width: 40, height: 40)
            
            Text(title)
                .madiiFont(font: .madiiBody3, color: .white)
            
            Spacer()
        }
    }
}
