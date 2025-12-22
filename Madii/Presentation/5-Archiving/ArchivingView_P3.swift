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
        VStack {
            HStack {
                Text("아카이브")
                    .madiiFont(.title1)
                    .foregroundStyle(.madiiAlternative)
                
                Spacer()
                
                Button {
                    viewModel.action(.showMyPage)
                } label: {
                    Image("myPage")
                        .resizable()
                        .frame(width: 28, height: 28)
                }
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 24)
            
            Spacer()
            
            Image("archivingClover")
                .resizable()
                .frame(width: 120, height: 120)
            
            Text("새로운 기능이 곧\n업데이트될 예정이에요!")
                .madiiFont(font: .madiiSubTitle, color: .madiiNeutral)
                .multilineTextAlignment(.center)
            
            Spacer()
        }
        .onAppear {
            AnalyticsManager.shared.logEvent(name: "아카이브 진입")
        }
    }
}
