//
//  OnboardingView.swift
//  Madii
//
//  Created by 이안진 on 12/12/23.
//

import SwiftUI

enum OnboardingPages {
    case first, second, third
    
    var title: String {
        switch self {
        case .first: "단단한 내가 되기 위한 시간"
        case .second: "아주 소소한 것이라도 좋아요!"
        case .third: "새로운 행복을 발견해요"
        }
    }
    
    var description: String {
        switch self {
        case .first: "매일매일 나를 위한 시간을 가지면서\n나를 들여다보고, 일상을 다시 살아갈 힘을 얻어요"
        case .second: "바쁜 일상 속에서도 잠깐 시간을 내어\n내가 온전히 행복한 순간들을 기록해보세요"
        case .third: "무심코 놓치고 있던 행복을 발견하고,\n취향에 맞는 행복도 추천받을 수 있어요"
        }
    }
    
    var image: String {
        switch self {
        case .first: ""
        case .second: ""
        case .third: ""
        }
    }
}

struct OnboardingView: View {
    let contents: [Int: OnboardingPages] = [0: .first, 1: .second, 2: .third]
    @State private var selectedPage: Int = 0
    @State private var showMainView: Bool = false
    @State private var showLoginView: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            // 페이지 위치 점 세개
            pageStatus
                .padding(.leading, 20)
                .padding(.trailing, 28)
            
            // 문구(제목과 설명)
            titleAndDescription
                .padding(.top, 44)
                .padding(.horizontal, 24)
            
            // 이미지
            Rectangle()
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
            MadiiTabView().navigationBarBackButtonHidden() }
        .navigationDestination(isPresented: $showLoginView) {
            LoginView().navigationBarBackButtonHidden() }
    }
    
    // 페이지 위치 점 세개
    var pageStatus: some View {
        HStack(spacing: 12) {
            if selectedPage > 0 {
                Button {
                    selectedPage -= 1
                } label: {
                    Image(systemName: "chevron.left")
                        .frame(width: 10, height: 16)
                        .foregroundStyle(Color.white)
                        .padding()
                        .frame(width: 20, height: 20)
                }
            }
            
            Spacer()
            
            ForEach(0 ..< 3, id: \.self) { index in
                Circle()
                    .foregroundStyle(index == selectedPage ? Color.white : Color.gray700)
                    .frame(width: 8, height: 8)
            }
        }
        .frame(height: 60)
    }
    
    // 문구(제목과 설명)
    var titleAndDescription: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack { Spacer() }
                
            Text(contents[selectedPage]?.title ?? "")
                .madiiFont(font: .madiiTitle, color: .white)
                
            Text(contents[selectedPage]?.description ?? "")
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
            selectedPage += 1
        } else if selectedPage == 2 {
            showLoginView = true
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
