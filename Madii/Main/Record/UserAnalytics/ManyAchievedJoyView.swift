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
                VStack(spacing: 0) {
                    Circle()
                        .foregroundStyle(Color.madiiOrange)
                        .frame(width: 208, height: 208)
                        .padding(.bottom, 12)
                    
                    Text(joys[0].title)
                        .madiiFont(font: .madiiTitle, color: .white)
                        .padding(.bottom, 6)
                    
                    Text("\(joys[0].counts) 회")
                        .madiiFont(font: .madiiTitle, color: .madiiYellowGreen)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 6)
                        .background(Color.madiiOption)
                        .cornerRadius(90)
                }
                
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
            .padding(.top, 32)
            .padding(.horizontal, 16)
            .padding(.bottom, 40)
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
