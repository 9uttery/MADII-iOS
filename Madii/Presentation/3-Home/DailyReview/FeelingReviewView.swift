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
            Text("행복 속 어떤 감정을 느꼈나요?")
                .madiiFont(.subTitle)
                .foregroundStyle(.madiiNormal)
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
                                    .madiiFont(.body2)
                                    .foregroundStyle(.madiiNormal)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                                    .minimumScaleFactor(1)
                                    .allowsTightening(false)
                                    .layoutPriority(-1)
                                
                                Spacer(minLength: 0)
                                
                                HStack(spacing: 4) {
                                    ForEach(todayJoys[index].selectedEmotions) { emotion in
                                        Text(emotion.title)
                                            .madiiFont(.caption)
                                            .foregroundStyle(emotion.color)
                                            .padding(.vertical, 4.5)
                                            .padding(.horizontal, 8)
                                            .background(emotion.color.opacity(0.08))
                                            .cornerRadius(8)
                                            .lineLimit(1)
                                            .layoutPriority(1)
                                    }
                                }
                                .frame(alignment: .trailing)
                                .padding(.trailing, 12)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.vertical, 19)
                            .padding(.leading, 26)
                            .frame(height: 64)
                            .background(.madiiElevated)
                            .cornerRadius(20)
                            .animation(nil, value: clickedNum)
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
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 4), spacing: 12) {
                ForEach(emotions, id: \.self) { emotion in
                    Button {
                        toggleEmotion(emotion, for: clickedNum)
                    } label: {
                        Text(emotion.title)
                            .madiiFont(.body3)
                            .foregroundStyle(.madiiNormal)
                            .frame(height: 22)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 9)
                            .background(
                                (todayJoys.indices.contains(clickedNum) &&
                                 todayJoys[clickedNum].selectedEmotions.contains(emotion))
                                ? .madiiViolet : .madiiContrast
                            )
                            .cornerRadius(10)
                    }
                    .disabled(
                        todayJoys.indices.contains(clickedNum) &&
                        todayJoys[clickedNum].selectedEmotions.count >= 2 &&
                        !todayJoys[clickedNum].selectedEmotions.contains(emotion)
                    )
                }
            }
            .padding(.bottom, 16)
            
            Text("감정은 최대 2개까지 선택할 수 있어요")
                .madiiFont(.caption)
                .foregroundStyle(.madiiAlternative)
                
            Spacer()
            
            MadiiDesignSystem.MadiiButton(title: "다음", color: .violet) {
                tabNum = 1
            }
            .disabled(isNextButtonDisabled)
            .opacity(isNextButtonDisabled ? 0.4 : 1.0)
        }
    }
    
    func toggleEmotion(_ emotion: Emotion, for joyIndex: Int) {
        guard todayJoys.indices.contains(joyIndex) else { return }
        
        if let existingIndex = todayJoys[joyIndex].selectedEmotions.firstIndex(of: emotion) {
            todayJoys[joyIndex].selectedEmotions.remove(at: existingIndex)
        } else if todayJoys[joyIndex].selectedEmotions.count < 2 {
            // 2개 미만일 때만 추가
            todayJoys[joyIndex].selectedEmotions.append(emotion)
            if todayJoys[joyIndex].selectedEmotions.count == 2 {
                if clickedNum < todayJoys.count - 1 {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        clickedNum += 1
                    }
                }
            }
        }
    }
}
