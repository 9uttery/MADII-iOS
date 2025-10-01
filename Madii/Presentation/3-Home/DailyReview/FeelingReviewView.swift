//
//  FeelingReviewView.swift
//  Madii
//
//  Created by 정태우 on 8/10/25.
//

import MadiiDesignSystem
import SwiftUI

struct FeelingReviewView: View {
    @Binding var tabNum: Int
    @Binding var todayJoys: [Joy]
    @State var clickedNum: Int = 0
    @State var emotions: [Emotion] = Emotion.emotionList
    
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
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                                    .layoutPriority(0)
                                
                                Spacer()
                                
                                HStack(spacing: 4) {
                                    ForEach(todayJoys[index].selectedEmotions) { emotion in
                                        Text(emotion.title)
                                            .madiiFont(font: .madiiCaption, color: emotion.color)
                                            .padding(.vertical, 4.5)
                                            .padding(.horizontal, 8)
                                            .background(emotion.color.opacity(0.08))
                                            .cornerRadius(8)
                                    }
                                }
                                .padding(.trailing, 22)
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
                    Button {
                        toggleEmotion(emotion, for: clickedNum)
                    } label: {
                        Text(emotion.title)
                            .madiiFont(font: .madiiBody3, color: .madiiNormal)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 6)
                            .background(
                                (todayJoys.indices.contains(clickedNum) &&
                                 todayJoys[clickedNum].selectedEmotions.contains(emotion))
                                ? .madiiViolet : .madiiContrast
                            )
                            .cornerRadius(10)
                    }
                }
            }
            .padding(.bottom, 16)
            
            Text("*최대 2개까지 고를 수 있어요")
                .madiiFont(font: .madiiCaption, color: .madiiAlternative)
                
            Spacer()
            
            MadiiDesignSystem.MadiiButton(title: "다음", color: .violet) {
                tabNum = 1
            }
        }
        .animation(.easeInOut, value: clickedNum)
    }
    
    func toggleEmotion(_ emotion: Emotion, for joyIndex: Int) {
        // 이미 선택되어 있으면 제거
        if let existingIndex = todayJoys[joyIndex].selectedEmotions.firstIndex(of: emotion) {
            todayJoys[joyIndex].selectedEmotions.remove(at: existingIndex)
        }
        // 새로 선택할 때
        else {
            if todayJoys[joyIndex].selectedEmotions.count >= 2 {
                // 가장 먼저 선택한 걸 제거 (0번째)
                todayJoys[joyIndex].selectedEmotions.removeFirst()
            }
            // 새 선택 추가
            todayJoys[joyIndex].selectedEmotions.append(emotion)
        }
    }
}
