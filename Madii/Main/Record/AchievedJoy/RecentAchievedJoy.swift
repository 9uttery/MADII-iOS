//
//  RecentAchievedJoy.swift
//  Madii
//
//  Created by 이안진 on 12/1/23.
//

import SwiftUI

struct RecentAchievedJoy: View {
    var body: some View {
        ScrollView {
            Text("최근 실천")
        }
        .navigationTitle("최근 실천한 소확행")
        .toolbarBackground(Color.madiiBox, for: .navigationBar)
//              .toolbarBackground(.visible, for: .navigationBar)
    }
}

#Preview {
    RecentAchievedJoy()
}
