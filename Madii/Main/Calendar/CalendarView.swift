//
//  CalendarView.swift
//  Madii
//
//  Created by 이안진 on 11/29/23.
//

import SwiftUI

struct CalendarView: View {
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    title
                    
                    Spacer()
                }
                // 하단 여백 40
                .padding(.bottom, 40)
            }
            .scrollIndicators(.hidden)
        }
        .navigationTitle("")
    }
    
    var title: some View {
        HStack(spacing: 0) {
            Text("캘린더")
                .madiiFont(font: .madiiTitle, color: .white)
                .padding(.vertical, 12)
            
            Spacer()
            
            NavigationLink {
                Text("프로필")
            } label: {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .frame(width: 22, height: 22)
                    .foregroundStyle(Color.gray500)
            }
        }
        .padding(.horizontal, 22)
        .padding(.bottom, 12)
    }
}

#Preview {
    CalendarView()
}
