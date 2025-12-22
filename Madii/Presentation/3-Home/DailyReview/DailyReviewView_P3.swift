//
//  DailyReviewView.swift
//  Madii
//
//  Created by 정태우 on 8/9/25.
//

import SwiftUI

struct DailyReviewView_P3: View {
    @Environment(Router.self) var router
    
    @State var date: Date
    @State var todayJoys: [Joy] = []
    @State var isHeaderVisible = false
    @State var visibleJoys: [Bool] = []
    @State var isActive = true
    
    var body: some View {
        VStack(spacing: 0) {
            MadiiNavigationBar_P3(title: "오늘 하루 돌아보기")

            Spacer()
            
            HStack(spacing: 4) {
                Image("home_selected")
                    .resizable()
                    .frame(width: 12.6, height: 12.36)
                
                Text(Date().toKoreanString())
                    .madiiFont(font: .caption, color: .madiiGreen100)
                    .padding(.vertical, 4.5)
            }
            .padding(.horizontal, 8)
            .background(.madiiGreen10)
            .cornerRadius(8)
            .padding(.bottom, 12)
            .opacity(isHeaderVisible ? 1 : 0)
            .offset(y: isHeaderVisible ? 0 : 20)
            
            Text("오늘도 행복한 순간들이 함께 했네요!\n행복을 따라, 오늘을 정리해봐요.")
                .madiiFont(font: .madiiBody1, color: .gray100.opacity(0.97))
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .padding(.bottom, 60)
                .opacity(isHeaderVisible ? 1 : 0)
                .offset(y: isHeaderVisible ? 0 : 20)

            ForEach(todayJoys.indices, id: \.self) { index in
                if visibleJoys[index] {
                    HStack(spacing: 12) {
                        Circle()
                            .frame(width: 12, height: 12)
                            .foregroundStyle(.madiiGreen100)

                        Text(todayJoys[index].title)
                            .madiiFont(font: .madiiBody2, color: .madiiNormal)
                            .lineSpacing(9.6)
                            .padding(.leading, 8)
                            .padding(.trailing, 12)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 19)
                    .padding(.leading, 26)
                    .background(.madiiElevated)
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(
                                LinearGradient(
                                    gradient: Gradient(stops: [
                                        .init(color: Color.white.opacity(0.1), location: 0.0),
                                        .init(color: Color(red: 0x3D/255, green: 0xC2/255, blue: 0xFF/255).opacity(0.1), location: 0.5),
                                        .init(color: Color.white.opacity(0.1), location: 1.0)
                                    ]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 1
                            )
                    )
                    .padding(.horizontal, 20)
                    .padding(.bottom, 12)
                    .opacity(visibleJoys[index] ? 1 : 0)
                    .offset(y: visibleJoys[index] ? 0 : 20)
                    .animation(.easeOut(duration: 0.5), value: visibleJoys[index])
                }
            }
            
            Spacer()
        }
        .background(
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0x0F/255, green: 0x13/255, blue: 0x19/255),
                    Color(red: 0x56/255, green: 0x42/255, blue: 0xA7/255)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .onAppear {
            isActive = true
            AnalyticsManager.shared.logEvent(name: "오늘 하루 돌아보기 진입")
            isHeaderVisible = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                guard isActive else { return }
                withAnimation(.easeOut(duration: 0.5)) {
                    isHeaderVisible = true
                }

                for index in todayJoys.indices {
                    DispatchQueue.main.asyncAfter(deadline: .now() + Double(index + 1)) {
                        guard isActive else { return }
                        withAnimation(.easeOut(duration: 0.5)) {
                            visibleJoys[index] = true
                        }
                    }
                }

                let lastAnimationDelay = Double(todayJoys.count) + 1.0
                DispatchQueue.main.asyncAfter(deadline: .now() + lastAnimationDelay + 0.5) {
                    guard isActive else { return }
                    router.push(.review(savingJoys: todayJoys, date: date))
                }
            }
        }
        .onDisappear {
            isActive = false
        }
    }
}
