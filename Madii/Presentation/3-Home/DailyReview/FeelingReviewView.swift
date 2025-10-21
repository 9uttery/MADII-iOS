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
    
    // 🔹 “다음” 버튼 활성화 여부
    private var isNextButtonDisabled: Bool {
        todayJoys.contains { $0.selectedEmotions.isEmpty }
    }
    
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
                                    .lineSpacing(9.6)
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                                    .layoutPriority(-1)
                                
                                Spacer()
                                
                                HStack(spacing: 4) {
                                    ForEach(todayJoys[index].selectedEmotions) { emotion in
                                        Text(emotion.title)
                                            .madiiFont(font: .caption, color: emotion.color)
                                            .padding(.vertical, 4.5)
                                            .padding(.horizontal, 8)
                                            .background(emotion.color.opacity(0.08))
                                            .cornerRadius(8)
                                            .lineLimit(1)
                                            .layoutPriority(1)
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
            .scrollIndicators(.hidden)
            .frame(height: todayJoys.count > 3 ? 248 : 216)
            .padding(.bottom, todayJoys.count > 3 ? 40 : 72)
            
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
                    // 🔹 2개 이상 선택된 경우는 선택 비활성화
                    .disabled(
                        todayJoys.indices.contains(clickedNum) &&
                        todayJoys[clickedNum].selectedEmotions.count >= 2 &&
                        !todayJoys[clickedNum].selectedEmotions.contains(emotion)
                    )
                }
            }
            .padding(.bottom, 16)
            
            Text("감정은 최대 2개까지 선택할 수 있어요")
                .madiiFont(font: .caption, color: .madiiAlternative)
                
            Spacer()
            
            MadiiDesignSystem.MadiiButton(title: "다음", color: .violet) {
                tabNum = 1
            }
            .disabled(isNextButtonDisabled)
            .opacity(isNextButtonDisabled ? 0.4 : 1.0)
        }
        .animation(.easeInOut, value: clickedNum)
        .animation(.easeInOut, value: todayJoys)
    }
    
    func toggleEmotion(_ emotion: Emotion, for joyIndex: Int) {
        guard todayJoys.indices.contains(joyIndex) else { return }
        
        if let existingIndex = todayJoys[joyIndex].selectedEmotions.firstIndex(of: emotion) {
            todayJoys[joyIndex].selectedEmotions.remove(at: existingIndex)
        } else if todayJoys[joyIndex].selectedEmotions.count < 2 {
            // 2개 미만일 때만 추가
            todayJoys[joyIndex].selectedEmotions.append(emotion)
        }
    }
}
