//
//  ManyAchievedJoyView.swift
//  Madii
//
//  Created by 이안진 on 12/1/23.
//

import SwiftUI

struct ManyAchievedJoyView: View {
    @State private var joys: [Joy] = Joy.manyAchievedDummy
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 32) {
                // 1등
                VStack(spacing: 12) {
                    ZStack(alignment: .topLeading) {
                        Circle()
                            .frame(width: 100, height: 100)
                            .foregroundStyle(Color.black)
                            .overlay { Circle().stroke(Color.white.opacity(0.2), lineWidth: 1) }
                        
                        // FIXME: 이미지로 변경
                        Circle()
                            .frame(width: 28, height: 28)
                            .foregroundStyle(Color.madiiYellowGreen)
                    }
                    
                    Text(joys[0].title)
                        .madiiFont(font: .madiiBody1, color: .white)
                        .frame(width: 200)
                        .multilineTextAlignment(.center)
                    
                    Text("\(joys[0].counts) 회")
                        .madiiFont(font: .madiiBody1, color: .white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.madiiBox)
                        .cornerRadius(90)
                }
                .padding(.vertical, 32)
                .padding(.horizontal, 10)
                .frame(maxWidth: .infinity)
                .background(Color.madiiOption)
                .cornerRadius(20)
                
                // 2등 ~ 5등
                VStack(spacing: 16) {
                    let count = joys.count
                    ForEach(0 ..< count, id: \.self) { index in
                        if index > 0 {
                            HStack {
                                JoyRow(title: joys[index].title)
                                Spacer()
                                
                                Text("\(joys[index].counts) 회")
                                    .madiiFont(font: .madiiBody5, color: .gray400)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(Color.madiiOption)
                                    .cornerRadius(6)
                            }
                        }
                    }
                }
                .roundBackground(bottomPadding: 32)
            }
            .padding(.top, 28)
            .padding(.horizontal, 16)
            .padding(.bottom, 60)
        }
        .scrollIndicators(.hidden)
        .navigationTitle("많이 실천한 소확행")
        .toolbarBackground(Color.madiiBox, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

#Preview {
    ManyAchievedJoyView()
}
