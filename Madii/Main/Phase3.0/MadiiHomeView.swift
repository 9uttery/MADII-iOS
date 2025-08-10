//
//  MadiiHomeView.swift
//  Madii
//
//  Created by 정태우 on 8/7/25.
//

import MadiiDesignSystem
import SwiftUI

struct MadiiHomeView: View {
    @State var isClicked: Bool = false
    @State var isMonthly: Bool = false
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0) {
                MadiiHomeNavigation() {
                    
                }
                .padding(.bottom, 12)
                
                VStack(spacing: 6) {
                    Image("todayClover")
                    
                    Button {
                        
                    } label: {
                        Text("클릭해 보세요!")
                            .madiiFont(font: .madiiSubTitle, color: .madiiStrong)
                            .padding(.vertical, 16)
                            .frame(width: UIScreen.main.bounds.width - 80)
                            .background(.gray100.opacity(0.52))
                            .cornerRadius(20)
                    }
                }
                .padding(20)
                .background(
                    Image("todayJoy")
                        .resizable()
                        .scaledToFill()
                        .cornerRadius(40)
                )
                .padding(.bottom, 24)
                
                Button {
                    
                } label: {
                    Text("오늘 하루 돌아보기")
                        .madiiFont(font: .madiiSubTitle, color: .madiiContrast)
                        .padding(.vertical, 16)
                        .frame(maxWidth: .infinity)
                        .background(.madiiGreen100)
                        .cornerRadius(20)
                        .padding(.horizontal, 20)
                }
                .padding(.bottom, 16)
                
                HomeCalendar(isMonthly: $isMonthly)
                    .padding(.horizontal, 20)
            }
        }
        .animation(.easeInOut, value: isMonthly)
    }
}

#Preview {
    MadiiHomeView()
}
