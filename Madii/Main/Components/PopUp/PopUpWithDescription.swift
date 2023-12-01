//
//  PopUpWithDescription.swift
//  Madii
//
//  Created by 이안진 on 12/1/23.
//

import SwiftUI

struct PopUpWithDescription: View {
    let title: String
    let description: String
    
    var leftButtonAction: () -> Void
    var rightButtonAction: () -> Void
    
    var body: some View {
        PopUp(title: title,
                  leftButtonAction: leftButtonAction,
                  rightButtonAction: rightButtonAction) {
            Text(description)
                .madiiFont(font: .madiiBody3, color: .white)
        }
    }
}
