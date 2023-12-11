//
//  AlbumSettingBottomSheetRow.swift
//  Madii
//
//  Created by 이안진 on 12/4/23.
//

import SwiftUI

struct AlbumSettingBottomSheetRow: View {
    let title: String
    
    var body: some View {
        HStack {
            Text(title)
                .madiiFont(font: .madiiBody2, color: .white)
            Spacer()
        }
        .padding(16)
        .background(Color.madiiOption)
        .cornerRadius(10)
    }
}

struct AlbumSettingBottomSheetToggleRow: View {
    let title: String
    @Binding var isToggleTrue: Bool
    
    var body: some View {
        HStack {
            Text(title)
                .madiiFont(font: .madiiBody2, color: .white)
            Spacer()
            Toggle("", isOn: $isToggleTrue)
                .tint(.madiiYellowGreen)
        }
        .padding(10)
        .background(Color.madiiOption)
        .cornerRadius(10)
    }
}
