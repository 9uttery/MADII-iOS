//
//  SelectDateHeaderView.swift
//  Madii
//
//  Created by 이안진 on 12/6/23.
//

import SwiftUI

struct SelectDateHeaderView: View {
    @Binding var selectedDate: Date
    
    var body: some View {
        HStack {
            Button {
                changeMonth(add: -1)
            } label: {
                changeMonthButton(image: "arrow.left.circle.fill")
            }
            
            Spacer()
            
            VStack {
                Text("\(selectedDate.month)월")
                    .madiiFont(font: .madiiTitle, color: .white)
                Text("\(selectedDate.year)년")
                    .madiiFont(font: .madiiBody4, color: .gray500)
            }
            
            Spacer()
            
            Button {
                changeMonth(add: 1)
            } label: {
                changeMonthButton(image: "arrow.right.circle.fill")
            }
        }
        .padding(.horizontal, 38)
    }
    
    func changeMonth(add addAmount: Int) {
        let calendar = Calendar.current
        let changedDate = calendar.date(byAdding: .month, value: addAmount, to: selectedDate)
        selectedDate = changedDate ?? selectedDate
    }
    
    @ViewBuilder
    func changeMonthButton(image: String) -> some View {
        Image(systemName: image)
            .resizable()
            .frame(width: 28, height: 28)
            .foregroundStyle(Color.gray800)
    }
}
