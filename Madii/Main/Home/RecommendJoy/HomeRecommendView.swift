//
//  HomeRecommendView.swift
//  Madii
//
//  Created by 정태우 on 12/23/23.
//

import SwiftUI

struct HomeRecommendView: View {
    @State private var xangle: CGFloat = 180.00
    @State private var angle: CGFloat = 0.00
    @State private var addNum: CGFloat = 0.03
    @State private var coreAxis: CGFloat = 0.5
    @State private var addNum1: CGFloat = 0.001
    @State private var radius: CGFloat = 0.8
    
    @State private var timer: Timer?
    
    var body: some View {
        VStack {
            NavigationLink {
                RecommendView()
            } label: {
                Rectangle()
                    .frame(height: 100)
                    .cornerRadius(20)
                    .clipped()
                    .overlay(
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("나만의 취향저격 소확행")
                                    .madiiFont(font: .madiiSubTitle, color: .white)
                                
                                Text("나에게 꼭 맞는 소확행을 찾아보세요")
                                    .madiiFont(font: .madiiBody4, color: .white.opacity(0.8))
                            }
                            Spacer()
                            Image("preferenceRight")
                        }
                        .padding(.vertical, 20)
                        .padding(.leading, 16)
                        .padding(.trailing, 28.5)
                        .frame(height: UIScreen.main.bounds.width)
                        .foregroundStyle(Color.clear)
                        .background { backgroundGradation() }
                        .mask { Rectangle().frame(height: 100).cornerRadius(20) }
                    )
                    .padding(.bottom, 20)
            }
            .simultaneousGesture(TapGesture().onEnded {
                AnalyticsManager.shared.logEvent(name: "홈뷰_나만의취향저격소확행클릭")
            })
        }
        .onAppear {
            addAngle()
        }
        .onDisappear {
            timer?.invalidate()
        }
    }
    
    private func addAngle() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { _ in
            withAnimation(.smooth) {
                if angle > 360 || angle < 0 {
                    addNum *= -1
                }
                
                xangle += addNum
                angle += addNum
            }
        }
    }
    
    private func backgroundGradation() -> LinearGradient {
        LinearGradient(
            stops: [
                Gradient.Stop(color: Color(red: 0.61, green: 0.42, blue: 1), location: 0.12),
                Gradient.Stop(color: Color(red: 0.49, green: 0.59, blue: 0.97), location: 0.76)
            ],
            startPoint: UnitPoint(x: radius * cos(xangle) + coreAxis, y: radius * sin(xangle) + coreAxis),
            endPoint: UnitPoint(x: radius * cos(angle) + coreAxis, y: radius * sin(angle) + coreAxis)
        )
    }
}
