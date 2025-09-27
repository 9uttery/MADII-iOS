//
//  ArchivingView_P3.swift
//  Madii
//
//  Created by Anjin on 9/27/25.
//

import SwiftUI

struct ArchivingView_P3: View {
    private let viewModel: ArchivingViewModel_P3
    
    init(viewModel: ArchivingViewModel_P3) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 40) {
            Spacer()
            Text("ArchivingView_P3_아카이브화면")
            
            Button {
                viewModel.action(.showMyPage)
            } label: {
                Text("마이페이지 이동")
                    .foregroundStyle(Color.blue)
            }
            
            Spacer()
        }
    }
}
