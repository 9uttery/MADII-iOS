//
//  TodayJoyBeforeClickButton.swift
//  Madii
//
//  Created by 이안진 on 2/21/24.
//

import SwiftUI

struct TodayJoyBeforeClickButton: View {
    @Binding var isClickedToday: Bool
    @Binding var counter: Int
    
    var body: some View {
        Button {
            isClickedToday = true
            UserDefaults.standard.set(true, forKey: "isClickedToday")
            counter += 1
        } label: {
            ZStack {
                HStack {
                    Spacer()
                    Text("클릭해보세요!")
                        .madiiFont(font: .madiiBody1, color: .black)
                        .padding(.vertical, 18)
                    Spacer()
                }
                .background(Color.madiiYellowGreen)
                .cornerRadius(90)
            }
        }
    }
}
