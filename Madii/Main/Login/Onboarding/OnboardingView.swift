//
//  OnboardingView.swift
//  Madii
//
//  Created by 이안진 on 12/12/23.
//

import SwiftUI

struct OnboardingPage: Identifiable {
    let id: Int
    let title, description: String
    let image: Color
}

struct OnboardingView: View {
    let contents: [OnboardingPage] = [
        OnboardingPage(id: 0, title: "단단한 내가 되기 위한 시간", description: "매일매일 나를 위한 시간을 가지면서\n나를 들여다보고, 일상을 다시 살아갈 힘을 얻어요", image: .gray400),
        OnboardingPage(id: 1, title: "아주 소소한 것이라도 좋아요!", description: "바쁜 일상 속에서도 잠깐 시간을 내어\n내가 온전히 행복한 순간들을 기록해보세요", image: .gray200),
        OnboardingPage(id: 2, title: "새로운 행복을 발견해요", description: "무심코 놓치고 있던 행복을 발견하고,\n취향에 맞는 행복도 추천받을 수 있어요", image: .gray400)]
    @State private var selectedPage: Int = 0
    @State private var showMainView: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            // 페이지 위치 점 세개
            pageStatus
                .padding(.top, 30)
                .padding(.horizontal, 28)
            
            // 문구(제목과 설명)
            titleAndDescription
                .padding(.top, 66)
                .padding(.horizontal, 24)
            
            // 이미지
            Rectangle()
                .foregroundStyle(contents[selectedPage].image)
                .frame(width: 360, height: 392)
                .padding(.top, 40)
            
            // 다음으로 넘어가는 버튼
            nextButton
            
            // 메인화면으로 넘어가는 버튼
            showMainButton
            
            Spacer()
        }
        .background(OnboardingBackgroundGradient())
        .navigationDestination(isPresented: $showMainView) {
            MadiiTabView().navigationBarBackButtonHidden()
        }
    }
    
    // 페이지 위치 점 세개
    var pageStatus: some View {
        HStack(spacing: 12) {
            Spacer()
            ForEach(contents) { content in
                Circle()
                    .foregroundStyle(content.id == selectedPage ? Color.white : Color.gray700)
                    .frame(width: 8, height: 8)
            }
        }
    }
    
    // 문구(제목과 설명)
    var titleAndDescription: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack { Spacer() }
                
            Text(contents[selectedPage].title)
                .madiiFont(font: .madiiTitle, color: .white)
                
            Text(contents[selectedPage].description)
                .madiiFont(font: .madiiBody3, color: .white)
        }
    }
    
    // 다음으로 넘어가는 버튼
    var nextButton: some View {
        Button {
            showNextPage()
        } label: {
            MadiiButton(title: "다음")
                .padding(.top, 40)
                .padding(.horizontal, 20)
        }
    }
    
    // '회원가입 없이 둘러보기' 메인화면으로 넘어가는 버튼
    var showMainButton: some View {
        Button {
            showMainView = true
        } label: {
            Text("회원가입 없이 둘러보기")
                .madiiFont(font: .madiiBody2, color: .white)
                .underline()
                .padding(.top, 14)
        }
    }
    
    // 다음 버튼 Action
    private func showNextPage() {
        if selectedPage < 2 {
            withAnimation {
                selectedPage += 1
            }
        } else if selectedPage == 3 {
            // TODO: 로그인 페이지로 이동
        }
    }
}

struct OnboardingBackgroundGradient: View {
    var body: some View {
        LinearGradient(
            stops: [
                Gradient.Stop(color: Color(red: 0.09, green: 0.09, blue: 0.15), location: 0.00),
                Gradient.Stop(color: Color(red: 0.42, green: 0.44, blue: 0.68), location: 1.00)
            ],
            startPoint: UnitPoint(x: 0.5, y: 0),
            endPoint: UnitPoint(x: 0.5, y: 1)
        )
        .ignoresSafeArea()
    }
}

#Preview {
    OnboardingView()
}
