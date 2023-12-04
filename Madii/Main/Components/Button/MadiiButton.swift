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
                .madiiFont(font: size == .big ? .madiiBody1 : .madiiBody2, color: fontColor())
            Spacer()
        }
        .frame(height: size == .big ? 56 : 40)
        .background(backgroundColor())
        .cornerRadius(size == .big ? 12 : 6)
    }
    
    func backgroundColor() -> Color {
        switch color {
        case .gray: Color(red: 0.84, green: 0.84, blue: 0.84)
        case .white: Color.white
        case .yellowGreen: Color.madiiYellowGreen
        }
    }
    
    func fontColor() -> Color {
        if color == .gray {
            return Color(red: 0.44, green: 0.44, blue: 0.44)
        } else {
            return .black
        }
    }
}
