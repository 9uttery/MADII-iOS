//
//  FeelingReviewView.swift
//  Madii
//
//  Created by 정태우 on 8/10/25.
//

import SwiftUI

struct FeelingReviewView: View {
    @State var todayJoys: [Joy] = [Joy(title: "아침에 일어나서 환기시키기"), Joy(title: "하루를 즐겁게 시작하기"), Joy(title: "가족들과 맛있는 저녁 먹기")]
    @State var clickedNum: Int = 0
    @State var emotions: [String] = ["기쁨", "즐거움", "여유로움", "상쾌함", "자유로움", "사랑", "친밀감", "따뜻함", "감동", "고마움", "추억", "만족감", "성취감", "호기심", "몰입감", "기대감"]
    
    var body: some View {
        VStack(spacing: 0) {
            Text("행복 속 어떤 감정을 느끼셨나요?")
                .madiiFont(font: .madiiSubTitle, color: .madiiNormal)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 40)
            
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(todayJoys.indices, id: \.self) { index in
                        Button {
                            clickedNum = index
                        } label: {
                            HStack(spacing: 12) {
                                Circle()
                                    .frame(width: 12, height: 12)
                                    .foregroundStyle(.madiiGreen100)
                                
                                Text(todayJoys[index].title)
                                    .madiiFont(font: .madiiBody2, color: .madiiNormal)
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
                            .opacity(index == clickedNum ? 1 : 0.4)
                            .padding(.bottom, 12)
                        }
                    }
                }
            }
            .frame(height: todayJoys.count > 3 ? 248 : 216)
            .padding(.bottom, todayJoys.count > 3 ? 40: 72)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 12) {
                ForEach(emotions, id: \.self) { emotion in
                    Text(emotion)
                        .madiiFont(font: .madiiBody3, color: .madiiNormal)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 6)
                        .background(.madiiContrast)
                        .cornerRadius(10)
                }
            }
            .padding(.bottom, 16)
            
            Text("*최대 2개까지 고를 수 있어요")
        }
        .animation(.easeInOut, value: clickedNum)
    }
}

#Preview {
    FeelingReviewView()
}
