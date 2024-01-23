//
//  MyJoyView.swift
//  Madii
//
//  Created by 이안진 on 12/1/23.
//

import SwiftUI

struct MyJoyView: View {
    @State private var allJoys: [MyJoy] = MyJoy.dummys
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // (박스) 모든 날짜
                ForEach(allJoys) { eachDayJoy in
                    VStack(spacing: 8) {
                        // 각 날짜의 모든 소확행
                        ForEach(eachDayJoy.joys) { joy in
                            JoyRow(title: joy.title)
                        }
                    }
                    .roundBackground(eachDayJoy.date, bottomPadding: 32)
                }
            }
            .padding(.top, 28)
            .padding(.horizontal, 16)
            .padding(.bottom, 40)
        }
        .scrollIndicators(.hidden)
        .navigationTitle("내가 기록한 소확행")
        .toolbarBackground(Color.madiiBox, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

#Preview {
    MyJoyView()
}
