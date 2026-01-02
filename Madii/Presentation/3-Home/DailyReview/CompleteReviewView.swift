//
//  CompleteReviewView.swift
//  Madii
//
//  Created by 정태우 on 8/14/25.
//

import MadiiDesignSystem
import SwiftUI

struct CompleteReviewView: View {
    @Environment(Router.self) var router
    @EnvironmentObject var appStatus: AppStatus
    var body: some View {
        VStack {
            MadiiNavigationBar_P3(title: "오늘 하루 돌아보기", popNum: 3)
            
            Spacer()
            
            HStack(spacing: 4) {
                Image("home_selected")
                    .resizable()
                    .frame(width: 12.6, height: 12.36)
                
                Text("\(Date().year)년 \(Date().toKoreanString())")
                    .madiiFont(.caption)
                    .foregroundStyle(.madiiGreen100)
                    .padding(.vertical, 4.5)
            }
            .padding(.horizontal, 8)
            .background(.madiiGreen10)
            .cornerRadius(8)
            .padding(.bottom, 12)
            
            Text("오늘의 행복이 저장되었어요!")
                .madiiFont(.subTitle)
                .foregroundStyle(.madiiNormal)
                .padding(.bottom, 28)
            
            VStack(spacing: 20) {
                Image("CoverA")
                    .resizable()
                    .frame(width: 232, height: 232)
                    .cornerRadius(28)
                
                Text("\(appStatus.nickname)님의 행복")
                    .madiiFont(.subTitle)
                    .foregroundStyle(.madiiGray100)
            }
            .padding(.vertical, 28)
            .padding(.horizontal, 24)
            .background(
                LinearGradient(
                    gradient: Gradient(stops: [
                        .init(color: Color(red: 0xFF/255, green: 0xFF/255, blue: 0xFF/255).opacity(0.08), location: 0.0), // #FFFFFF
                                 .init(color: Color(red: 0x28/255, green: 0xD0/255, blue: 0xED/255).opacity(0.08), location: 1.0)  // #28D0ED
                             ]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .cornerRadius(32)
            .overlay(
                RoundedRectangle(cornerRadius: 32)
                    .stroke(
                        LinearGradient(
                            gradient: Gradient(stops: [
                                .init(color: Color.white.opacity(0.1), location: 0.0),
                                .init(color: Color(red: 0x3D/255, green: 0xC2/255, blue: 0xFF/255).opacity(0.1), location: 0.33),
                                .init(color: Color(red: 0xD4/255, green: 0x78/255, blue: 0xFF/255).opacity(0.1), location: 0.68),
                                .init(color: Color.white.opacity(0.1), location: 1.0)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1
                    )
            )
            .padding(.bottom, 28)
            
            Text("저장 후에는 수정이 어려워요")
                .madiiFont(.caption)
                .foregroundStyle(.madiiAlternative)
            
            Spacer()
            
            MadiiDesignSystem.MadiiButton(title: "홈으로 가기", color: .violet) {
                router.pop(times: 3)
            }
                .padding(.horizontal, 20)
        }
    }
}

#Preview {
    CompleteReviewView()
}
