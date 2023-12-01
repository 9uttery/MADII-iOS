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
    
    var leftButtonTitle: String = "취소"
    var leftButtonAction: () -> Void
    
    var rightButtonTitle: String
    var rightButtonColor: ButtonColor = .white
    var rightButtonAction: () -> Void
    
    var body: some View {
        PopUp(title: title,
              leftButtonTitle: leftButtonTitle, leftButtonAction: leftButtonAction, 
              rightButtonTitle: rightButtonTitle, rightButtonColor: rightButtonColor, rightButtonAction: rightButtonAction) {
            Text(description)
                .madiiFont(font: .madiiBody3, color: .white)
        }
    }
}
