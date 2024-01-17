//
//  JoySatisfactionBottomSheet.swift
//  Madii
//
//  Created by 이안진 on 1/17/24.
//

import SwiftUI

struct JoySatisfactionBottomSheet: View {
    let joy: Joy
    private let satisfactions: [Int] = [1, 2, 3, 4, 5]
    @State private var selectedSatisfaction: Int = 1
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 8) {
                Text(joy.title)
                    .madiiFont(font: .madiiSubTitle, color: .white)
                Text("얼마나 행복하셨나요?")
                    .madiiFont(font: .madiiBody3, color: .white)
            }
            
            Spacer()
            
            ZStack {
                Rectangle()
                    .foregroundStyle(Color.madiiPopUp)
                    .frame(height: 3)
                
                HStack(spacing: 0) {
                    ForEach(satisfactions, id: \.self) { satisfaction in
                        Button {
                            selectedSatisfaction = satisfaction
                        } label: {
                            ZStack {
                                Circle()
                                    .frame(width: 36, height: 36)
                                    .foregroundStyle(Color.madiiOption)
                                    .overlay {
                                        Circle()
                                            .stroke(satisfaction == selectedSatisfaction ? Color.madiiYellowGreen : Color.madiiPopUp, lineWidth: 2)
                                    }
                                
                                Circle()
                                    .frame(width: 24, height: 24)
                                    .foregroundStyle(satisfaction == selectedSatisfaction ? Color.madiiYellowGreen : Color.madiiPopUp)
                            }
                        }
                        
                        if satisfaction != satisfactions.last {
                            Spacer()
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
            .frame(height: 120)
            .background(Color.madiiOption)
            .cornerRadius(12)
            .padding(.bottom, 32)
        }
        .padding(.top, 36)
        .padding(.horizontal, 16)
        .background(Color.madiiPopUp)
    }
}
