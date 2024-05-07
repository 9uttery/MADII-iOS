//
//  RecommendView.swift
//  Madii
//
//  Created by 정태우 on 1/26/24.
//

import SwiftUI

struct RecommendView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var brightDotIndex = 0
    @State var nickname: String
    @State var isClicked: [Bool] = Array(repeating: false, count: 9)
    @State var recommendJoys: [GetJoyResponseJoy] = []
    @State var selectedJoy: GetJoyResponseJoy?
    @State var keywordlabel: [String] = ["활기찬", "혼자서", "특별한 도전을 할 수 있는", "지금 바로 할 수 있는", "울적한", "다 함께", "여유로운", "일상 속에서 할 수 있는", "둘이서"]
    @State var keywordCategory: [Int] = [0, 1, 2, 2, 0, 1, 0, 2, 1]
    @State var keywordRemove: [Int] = [1, 4, 7, 8, 2, 6, 3, 9, 5]
    @State var keywordColor: [Color] = [.madiiSkyBlue, .madiiPink, .madiiOrange, .madiiOrange, .madiiSkyBlue, .madiiPink, .madiiSkyBlue, .madiiOrange, .madiiPink]
    @State var when: [Int] = []
    @State var who: [Int] = []
    @State var which: [Int] = []
    @State var clickedNum: Int = 0
    @State var reClicked: Bool = false
    @EnvironmentObject var appStatus: AppStatus
    @State private var showTodayPlaylist: Bool = false /// 오플리 sheet 열기
    @State var isActive: Bool = false
    @State var isRecommendJoy: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                HStack {
                    if selectedJoy != nil {
                        Text("\(nickname)님을 위한 소확행이에요!")
                            .madiiFont(font: .madiiBody5, color: .gray800)
                    } else if recommendJoys.isEmpty {
                        Text("아래에 있는 키워드를 선택하여 나만을 위한 소확행을 찾아보세요")
                            .madiiFont(font: .madiiBody5, color: .gray800)
                    } else {
                        ForEach(0..<3) { index in
                            Circle()
                                .fill(.gray800)
                                .opacity(brightDotIndex == index ? 1.0 : 0.2)
                                .frame(width: 8, height: 8)
                        }
                    }
                }
                .frame(height: 20)
                .padding(.top, 40)
                .padding(.bottom, 40)
                
                VStack(spacing: 12) {
                    ForEach(0..<3) { rdx in
                        HStack {
                            ForEach(0..<3) { cdx in
                                StyleJoyButton(label: keywordlabel[rdx * 3 + cdx], isClicked: $isClicked[rdx * 3 + cdx], buttonColor: keywordColor[rdx * 3 + cdx]) {
                                    if isClicked[rdx * 3 + cdx] {
                                        switch keywordCategory[rdx * 3 + cdx] {
                                        case 0:
                                            when.append(keywordRemove[rdx * 3 + cdx])
                                        case 1:
                                            who.append(keywordRemove[rdx * 3 + cdx])
                                        default:
                                                which.append(keywordRemove[rdx * 3 + cdx])
                                        }
                                        clickedNum += 1
                                    } else {
                                        switch keywordCategory[rdx * 3 + cdx] {
                                        case 0:
                                            when.removeAll { $0 == keywordRemove[rdx * 3 + cdx] }
                                        case 1:
                                            who.removeAll { $0 == keywordRemove[rdx * 3 + cdx] }
                                        default:
                                                which.removeAll { $0 == keywordRemove[rdx * 3 + cdx] }
                                        }
                                        clickedNum -= 1
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(.bottom, 48)
                
                RecommendJoyListView(recommendJoys: $recommendJoys, selectedJoy: $selectedJoy, isClicked: $isClicked, nickname: nickname, clickedNum: $clickedNum, reClicked: $reClicked, isRecommendJoy: $isRecommendJoy)
            }
            .padding(.horizontal, 16)
            
            // 오플리 추가 안내 토스트
            if appStatus.showAddPlaylistToast {
                AddTodayPlaylistBarToast(showTodayPlaylist: $showTodayPlaylist) }
            
            withAnimation(.easeInOut(duration: 1)) {
                RecommendJoyView(nickname: nickname, selectedJoy: $selectedJoy, isActive: $isActive, isRecommendJoy: $isRecommendJoy)
                    .offset(x: isRecommendJoy ? 0 : UIScreen.main.bounds.width * 2)
            }
        }
        // 오늘의 소확행 오플리에 추가 후, 바로가기에서 sheet
        .sheet(isPresented: $showTodayPlaylist) {
            TodayPlaylistView(showPlaylist: $showTodayPlaylist) }
        .onChange(of: clickedNum) { _ in
            getRecommendJoys(when: when, who: who, which: which)
        }
        .onChange(of: reClicked) { _ in
            getRecommendJoys(when: when, who: who, which: which)
        }
        .onChange(of: isActive) { _ in
            self.presentationMode.wrappedValue.dismiss()
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
                withAnimation {
                    brightDotIndex = (brightDotIndex + 1) % 3
                }
            }
        }
        .navigationTitle("\(nickname)님의 취향저격 소확행")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color.clear, for: .navigationBar)
        .background(
            LinearGradient(
                stops: [
                Gradient.Stop(color: Color(red: 0.61, green: 0.42, blue: 1).opacity(0.8), location: 0.00),
                Gradient.Stop(color: Color(red: 0.5, green: 0.77, blue: 0.91).opacity(0.8), location: 0.48),
                Gradient.Stop(color: Color(red: 0.81, green: 0.98, blue: 0.32).opacity(0.8), location: 1.00)
                ],
                startPoint: UnitPoint(x: 0.5, y: -0.19),
                endPoint: UnitPoint(x: 0.5, y: 1.5)
                )
            )
    }
    
    private func getRecommendJoys(when: [Int], who: [Int], which: [Int]) {
        HomeAPI.shared.postJoyRecommend(when: when, who: who, which: which) { isSuccess, joyList in
            if isSuccess {
                recommendJoys = joyList
                
                if selectedJoy != nil {
                    let isContainedInRecommendJoys = recommendJoys.contains { joy in
                        joy.joyId == selectedJoy?.joyId
                    }
                    
                    if !isContainedInRecommendJoys {
                        selectedJoy = nil
                    }
                }
            }
        }
    }
}

#Preview {
    RecommendView(nickname: "코코")
}
