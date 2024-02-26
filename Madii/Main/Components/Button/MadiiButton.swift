//
//  MadiiButton.swift
//  Madii
//
//  Created by 이안진 on 12/1/23.
//

import SwiftUI

enum ButtonColor {
    case gray, white, yellowGreen
}

enum ButtonSize {
    case small, big
}

struct MadiiButton: View {
    let title: String
    var color: ButtonColor = .white
    var size: ButtonSize = .big
    
    var body: some View {
        HStack {
            Spacer()
            Text(title)
                // 팝업의 버튼은 madiiBody2
                .madiiFont(font: size == .big ? .madiiBody1 : .madiiBody2, color: .black)
            Spacer()
        }
        .frame(height: size == .big ? 56 : 40)
        .background(backgroundColor())
        .cornerRadius(size == .big ? 12 : 6)
    }
    
    func backgroundColor() -> Color {
        switch color {
        case .gray: Color.white.opacity(0.4)
        case .white: Color.white
        case .yellowGreen: Color.madiiYellowGreen
        }
    }
}
