//
//  HomeView_P3.swift
//  Madii
//
//  Created by Anjin on 9/27/25.
//

import SwiftUI

struct HomeView_P3: View {
    private let viewModel: HomeViewModel_P3
    
    init(viewModel: HomeViewModel_P3) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 40) {
            Spacer()
            Text("HomeView_P3_홈화면")
            
            Button {
                viewModel.action(.showDailyReview)
            } label: {
                Text("오늘 하루 돌아보기")
                    .foregroundStyle(Color.blue)
            }
            
            Spacer()
        }
    }
}
