//
//  AchievedJoyView.swift
//  Madii
//
//  Created by 이안진 on 12/1/23.
//

import SwiftUI

struct AchievedJoyView: View {
    var body: some View {
        HStack(spacing: 12) {
            NavigationLink {
                RecentAchievedJoyView()
            } label: {
                achievedJoy(title: "최근 실천한 소확행")
            }
            
            achievedJoy(title: "많이 실천한 소확행")
        }
    }
    
    @ViewBuilder
    func achievedJoy(title: String) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Rectangle()
                .fill(Color.gray400)
                .frame(width: 36, height: 36)
            
            HStack {
                Text(title)
                    .madiiFont(font: .madiiBody2, color: .white)
                Spacer()
            }
        }
        .padding(16)
        .padding(.leading, 4)
        .roundBackground()
    }
}

#Preview {
    MadiiTabView()
}
