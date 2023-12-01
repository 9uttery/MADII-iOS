//
//  RecentAndManyAchievedJoyView.swift
//  Madii
//
//  Created by 이안진 on 12/1/23.
//

import SwiftUI

struct RecentAndManyAchievedJoyView: View {
    var body: some View {
        HStack(spacing: 12) {
            NavigationLink {
                ScrollView {
                    Text("최근 실천")
                }
                    .navigationTitle("최근 실천한 소확행")
                    .toolbarBackground(Color.gray700.opacity(0.7), for: .navigationBar)
//                    .toolbarBackground(.visible, for: .navigationBar)
            } label: {
                VStack(alignment: .leading, spacing: 12) {
                    Rectangle()
                        .fill(Color.gray400)
                        .frame(width: 36, height: 36)
                    
                    HStack {
                        Text("최근 실천한 소확행")
                            .madiiFont(font: .madiiBody2, color: .white)
                        Spacer()
                    }
                }
                .padding(16)
                .padding(.leading, 4)
                .roundBackground()
            }
            
            VStack(alignment: .leading, spacing: 12) {
                Rectangle()
                    .fill(Color.gray400)
                    .frame(width: 36, height: 36)
                
                HStack {
                    Text("많이 실천한 소확행")
                        .madiiFont(font: .madiiBody2, color: .white)
                    Spacer()
                }
            }
            .padding(16)
            .padding(.leading, 4)
            .roundBackground()
        }
    }
}

#Preview {
    MadiiTabView()
}
