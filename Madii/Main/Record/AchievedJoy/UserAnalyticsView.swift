//
//  UserAnalyticsView.swift
//  Madii
//
//  Created by 이안진 on 12/1/23.
//

import SwiftUI

struct UserAnalyticsView: View {
    var body: some View {
        // 최근 본 앨범 & 많이 실천한 소확행 & 내가 기록한 소확행
        HStack(spacing: 12) {
            NavigationLink {
                RecentAchievedJoyView()
            } label: {
                analyticsBox(title: "최근 본 앨범")
            }
            
            NavigationLink {
                ManyAchievedJoyView()
            } label: {
                analyticsBox(title: "많이 실천한 소확행")
            }
            
            NavigationLink {
                ManyAchievedJoyView()
            } label: {
                analyticsBox(title: "내가 기록한 소확행")
            }
        }
    }
    
    @ViewBuilder
    func analyticsBox(title: String) -> some View {
        VStack(spacing: 8) {
            Rectangle()
                .fill(Color.madiiPurple)
                .frame(width: 28, height: 28)
            
            HStack {
                Spacer()
                Text(title)
                    .madiiFont(font: .madiiBody4, color: .white)
                Spacer()
            }
        }
        .padding(.vertical, 12)
        .padding(.bottom, 4)
        .background(Color.madiiBox)
        .cornerRadius(12)
    }
}

#Preview {
    MadiiTabView()
}
