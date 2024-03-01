//
//  RecommendView.swift
//  Madii
//
//  Created by 정태우 on 1/26/24.
//

import SwiftUI

struct RecommendView: View {
    @State var nickName: String = "코코"
    @State var isClicked: [Bool] = Array(repeating: false, count: 9)
    @State var recommendJoys: [GetJoyResponseJoy] = []
    @State var selectedJoy: GetJoyResponseJoy?
    @State var when: [Int] = []
    @State var who: [Int] = []
    @State var which: [Int] = []
    @State var clickedNum: Int = 0
    
    var body: some View {
        VStack(spacing: 0) {
            Text("키워드를 선택해주세요")
                .madiiFont(font: .madiiBody4, color: .white)
                .padding(.top, 28)
                .padding(.bottom, 40)
            VStack(spacing: 12) {
                HStack {
                    StyleJoyButton(label: "활기찬", isClicked: $isClicked[0], buttonColor: Color.madiiSkyBlue) {
                        if isClicked[0] {
                            when.append(1)
                            clickedNum += 1
                        } else {
                            when.removeAll { $0 == 1 }
                            clickedNum -= 1
                        }
                    }
                    
                    StyleJoyButton(label: "혼자서", isClicked: $isClicked[1], buttonColor: Color.madiiPink) {
                        if isClicked[1] {
                            who.append(4)
                            clickedNum += 1
                        } else {
                            who.removeAll { $0 == 4 }
                            clickedNum -= 1
                        }
                    }
                    
                    StyleJoyButton(label: "특별한 도전을 할 수 있는", isClicked: $isClicked[2], buttonColor: Color.madiiOrange) {
                        if isClicked[2] {
                            which.append(7)
                            clickedNum += 1
                        } else {
                            which.removeAll { $0 == 7 }
                            clickedNum -= 1
                        }
                    }
                }
                HStack {
                    StyleJoyButton(label: "지금 바로 할 수 있는", isClicked: $isClicked[3], buttonColor: Color.madiiOrange) {
                        if isClicked[3] {
                            which.append(9)
                            clickedNum += 1
                        } else {
                            which.removeAll { $0 == 9 }
                            clickedNum -= 1
                        }
                    }
                    
                    StyleJoyButton(label: "울적한", isClicked: $isClicked[4], buttonColor: Color.madiiSkyBlue) {
                        if isClicked[4] {
                            when.append(2)
                            clickedNum += 1
                        } else {
                            when.removeAll { $0 == 2 }
                            clickedNum -= 1
                        }
                    }
                    
                    StyleJoyButton(label: "다 함께", isClicked: $isClicked[5], buttonColor: Color.madiiPink) {
                        if isClicked[5] {
                            who.append(6)
                            clickedNum += 1
                        } else {
                            who.removeAll { $0 == 6 }
                            clickedNum -= 1
                        }
                    }
                }
                HStack {
                    StyleJoyButton(label: "여유로운 ", isClicked: $isClicked[6], buttonColor: Color.madiiSkyBlue) {
                        if isClicked[6] {
                            when.append(3)
                            clickedNum += 1
                        } else {
                            when.removeAll { $0 == 3 }
                            clickedNum -= 1
                        }
                    }
                    
                    StyleJoyButton(label: "일상 속에서 할 수 있는", isClicked: $isClicked[7], buttonColor: Color.madiiOrange) {
                        if isClicked[7] {
                            which.append(9)
                            clickedNum += 1
                        } else {
                            which.removeAll { $0 == 9 }
                            clickedNum -= 1
                        }
                    }
                    
                    StyleJoyButton(label: "둘이서", isClicked: $isClicked[8], buttonColor: Color.madiiPink) {
                        if isClicked[8] {
                            who.append(5)
                            clickedNum += 1
                        } else {
                            who.removeAll { $0 == 5 }
                            clickedNum -= 1
                        }
                    }
                }
            }
            .padding(.bottom, 81)
            RecommendJoyListView(recommendJoys: $recommendJoys, selectedJoy: $selectedJoy, isClicked: $isClicked)
        }
        .onChange(of: clickedNum) { newValue in
            HomeAPI.shared.postJoyRecommend(when: when, who: who, which: which) { isSuccess, joyList in
                if isSuccess {
                    recommendJoys = joyList
                }
            }
            if selectedJoy != nil && !recommendJoys.isEmpty {
                let isContainedInRecommendJoys = recommendJoys.contains { joy in
                    joy.joyId == selectedJoy?.joyId
                }
                
                if !isContainedInRecommendJoys {
                    selectedJoy = nil
                }
            }
        }
        .navigationTitle("\(nickName)님의 취향저격 소확행")
        .toolbarBackground(Color.clear, for: .navigationBar)
        .padding(.horizontal, 16)
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
        .background(Color(red: 0.06, green: 0.06, blue: 0.13))
    }
}

#Preview {
    RecommendView()
}
