//
//  MadiiTabNavigation.swift
//  MadiiDesignSystem
//
//  Created by 정태우 on 7/1/25.
//

import SwiftUI

public struct MadiiTabNavigation: View {
    public let tabTitle: String
    
    public init(tabTitle: String) {
        self.tabTitle = tabTitle
    }
    
    public var body: some View {
        HStack {
            Text(tabTitle)
                .madiiFont(.title1)
                .foregroundStyle(.madiiAlternativeDS)
                .padding(.vertical, 10)
                .padding(.leading, 24)
            
            Spacer()
        }
    }
}
