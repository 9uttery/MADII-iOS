//
//  StyleJoyNextButton.swift
//  Madii
//
//  Created by 정태우 on 12/24/23.
//

import SwiftUI

struct StyleJoyNextButton: View {
    var label: String
    var isDisabled: Bool

    var body: some View {
        Text(label)
            .madiiFont(font: .madiiBody1, color: .black)
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(.vertical, 18)
            .background(isDisabled ? Color.white.opacity(0.5) : Color.madiiYellowGreen)
            .cornerRadius(12)
    }
}

