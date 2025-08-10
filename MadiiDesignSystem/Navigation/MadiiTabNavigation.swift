//
//  MadiiTabNavigation.swift
//  MadiiDesignSystem
//
//  Created by 정태우 on 7/1/25.
//

import SwiftUI

public struct MadiiTabNavigation: View {
    public let tabTitle: String = "탐색"
    
    public var body: some View {
        HStack {
            Text(tabTitle)
                .madiiFont(.title1)
                .foregroundStyle(.madiiAlternative)
                .padding(.vertical, 10)
                .padding(.leading, 24)
            
            Spacer()
        }
    }
}

#Preview {
    MadiiTabNavigation()
}
