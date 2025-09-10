//
//  CompleteRecommendJoyView.swift
//  Madii
//
//  Created by 정태우 on 8/30/25.
//

import SwiftUI
import MadiiDesignSystem

struct CompleteRecommendJoyView: View {
    @State var nickname: String = "코코"
    @State var joyName: String = "소확행 이름"
    @State var isShowToast: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            Text("\(nickname)님을 위한\n소확행이에요!")
                .madiiFont(font: .title, color: .madiiNormal)
                .padding(.top, 96)
            
            VStack(spacing: 20) {
                Image("CoverA")
                    .resizable()
                    .frame(width: 265, height: 232)
                    .cornerRadius(28)
                
                Text(joyName)
                    .madiiFont(font: .madiiSubTitle, color: .madiiGray100)
            }
            .padding(.vertical, 28)
            .padding(.horizontal, 24)
            .background(
                LinearGradient(
                    gradient: Gradient(stops: [
                        .init(color: Color(red: 1.0, green: 1.0, blue: 1.0).opacity(0.08), location: 0.0),
                        .init(color: Color(red: 40/255, green: 208/255, blue: 237/255).opacity(0.08), location: 1.0)
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .cornerRadius(32)
            .gradientBorder(hexColors: ["FFFFFF", "3DC2FF", "FFFFFF"], lineWidth: 1, cornerRadius: 32, startPoint: .topLeading, endPoint: .bottomTrailing, opacity: 0.1)
            .padding(.vertical, 28)
            
            Text("소확행을 실천하러 가볼까요?")
                .madiiFont(font: .madiiBody3, color: .madiiNormal)
            
            Spacer()
            
            MadiiDesignSystem.MadiiToast(type: .complete, title: "오늘의 플레이리스트에 추가했어요", isShowToast: $isShowToast)
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    CompleteRecommendJoyView()
}
