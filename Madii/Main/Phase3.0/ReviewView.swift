//
//  ReviewView.swift
//  Madii
//
//  Created by 정태우 on 8/10/25.
//

import SwiftUI

struct ReviewView: View {
    @State var tabNum: Int = 0
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 8) {
                Rectangle()
                    .frame(maxWidth: .infinity)
                    .frame(height: 4)
                    .foregroundStyle(.madiiViolet)
                    .cornerRadius(8)
                
                Rectangle()
                    .frame(maxWidth: .infinity)
                    .frame(height: 4)
                    .foregroundStyle(tabNum > 0 ? .madiiViolet : .madiiAssistive)
                    .cornerRadius(8)
                
                Rectangle()
                    .frame(maxWidth: .infinity)
                    .frame(height: 4)
                    .foregroundStyle(tabNum > 1 ? .madiiViolet : .madiiAssistive)
                    .cornerRadius(8)
            }
            .padding(.vertical, 12)
        }
        .navigationTitle("\(Date().toKoreanString())")
        .padding(.horizontal, 20)
    }
}

#Preview {
    ReviewView()
}
