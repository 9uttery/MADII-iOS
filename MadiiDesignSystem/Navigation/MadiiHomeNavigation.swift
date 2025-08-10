//
//  MadiiHomeNavigation.swift
//  MadiiDesignSystem
//
//  Created by 정태우 on 7/1/25.
//

import SwiftUI

public struct MadiiHomeNavigation: View {
    public let action: () -> Void
    
    public init(action: @escaping () -> Void) {
        self.action = action
    }
    public var body: some View {
        HStack {
            Image("madii")
                .resizable()
                .frame(width: 104, height: 22)
            
            Spacer()
            
            Button {
                action()
            } label: {
                Image("menu")
                    .resizable()
                    .frame(width: 28, height: 28)
            }
        }
        .padding(.vertical, 14)
        .padding(.horizontal, 20)
    }
}

#Preview {
    MadiiHomeNavigation(action: {})
}
