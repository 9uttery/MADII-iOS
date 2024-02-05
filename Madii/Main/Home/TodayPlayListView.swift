//
//  TodayPlayListView.swift
//  Madii
//
//  Created by 정태우 on 1/31/24.
//

import SwiftUI

struct TodayPlayListView: View {
    var body: some View {
        ScrollView {
            TodayPlayListJoyView()
            YesterdayPlayListJoyView()
        }
        .navigationTitle("오늘의 플레이리스트")
        .toolbarBackground(Color.madiiBox, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

#Preview {
    TodayPlayListView()
}
