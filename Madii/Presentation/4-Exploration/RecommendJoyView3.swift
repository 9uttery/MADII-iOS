//
//  RecommendJoyView3.swift
//  Madii
//
//  Created by 정태우 on 8/29/25.
//

import MadiiDesignSystem
import SwiftUI

struct RecommendJoyView3: View {
    @State var who: [Int] = []
    @State var when: [Int] = []
    @State var which: [Int] = []
    @State var recommendJoys: [GetJoyResponseJoy] = []
    @State var selectedJoy: GetJoyResponseJoy?
    
    var body: some View {
        VStack(spacing: 0) {
            Text("키워드를 선택해 나만을 위한 소확행을 찾아보세요")
                .madiiFont(font: .madiiBody3, color: .madiiNeutral)
                .padding(.vertical, 20)
            
            HStack(spacing: 12) {
                RecommendButton(title: "화창한 날씨") { isClicked in
                    if isClicked {
                        when.append(1)
                    } else {
                        if let index = when.firstIndex(of: 1) {
                            when.remove(at: index)
                        }
                    }
                    getRecommendJoy()
                }
                
                RecommendButton(title: "혼자서") { isClicked in
                    if isClicked {
                        who.append(4)
                    } else {
                        if let index = who.firstIndex(of: 4) {
                            who.remove(at: index)
                        }
                    }
                    getRecommendJoy()
                }
                
                RecommendButton(title: "다함께") { isClicked in
                    if isClicked {
                        who.append(6)
                    } else {
                        if let index = who.firstIndex(of: 6) {
                            who.remove(at: index)
                        }
                    }
                    getRecommendJoy()
                }
            }
            .padding(.bottom, 12)
            
            HStack(spacing: 12) {
                RecommendButton(title: "특별한 도전을 할 수 있는") { isClicked in
                    if isClicked {
                        which.append(7)
                    } else {
                        if let index = which.firstIndex(of: 7) {
                            which.remove(at: index)
                        }
                    }
                    getRecommendJoy()
                }
                
                RecommendButton(title: "둘이서") { isClicked in
                    if isClicked {
                        who.append(5)
                    } else {
                        if let index = who.firstIndex(of: 5) {
                            who.remove(at: index)
                        }
                    }
                    getRecommendJoy()
                }
            }
            .padding(.bottom, 12)
            
            HStack(spacing: 12) {
                RecommendButton(title: "눈 오는 날씨") { isClicked in
                    if isClicked {
                        when.append(3)
                    } else {
                        if let index = when.firstIndex(of: 3) {
                            when.remove(at: index)
                        }
                    }
                    getRecommendJoy()
                }
                
                RecommendButton(title: "지금 바로 할 수 있는") { isClicked in
                    if isClicked {
                        which.append(8)
                    } else {
                        if let index = which.firstIndex(of: 8) {
                            which.remove(at: index)
                        }
                    }
                    getRecommendJoy()
                }
            }
            .padding(.bottom, 12)
            
            HStack(spacing: 12) {
                RecommendButton(title: "비 오는 날씨") { isClicked in
                    if isClicked {
                        when.append(2)
                    } else {
                        if let index = when.firstIndex(of: 2) {
                            when.remove(at: index)
                        }
                    }
                    getRecommendJoy()
                }
                
                RecommendButton(title: "일상 속에서 할 수 있는") { isClicked in
                    if isClicked {
                        who.append(9)
                    } else {
                        if let index = who.firstIndex(of: 9) {
                            who.remove(at: index)
                        }
                    }
                    getRecommendJoy()
                }
            }
            .padding(.bottom, 60)
            
            if recommendJoys.isEmpty {
                HStack(spacing: 12) {
                    Circle()
                        .frame(width: 12, height: 12)
                        .foregroundStyle(.madiiDisabled)
                    
                    RoundedRectangle(cornerRadius: 8)
                        .frame(maxWidth: .infinity)
                        .frame(height: 26)
                        .foregroundStyle(.madiiDisabled)
                }
                .padding(.vertical, 19)
                .padding(.leading, 26)
                .padding(.trailing, 67)
                .background(.madiiElevated)
                .cornerRadius(20)
                .gradientBorder(hexColors: ["FFFFFF", "3DC2FF", "FFFFFF"], lineWidth: 1, cornerRadius: 20, startPoint: .topLeading, endPoint: .bottomTrailing, opacity: 0.1)
            } else {
                Button {
                    if selectedJoy == recommendJoys[0] {
                        selectedJoy = nil
                    } else {
                        selectedJoy = recommendJoys[0]
                    }
                } label: {
                    HStack(spacing: 12) {
                        Circle()
                            .frame(width: 12, height: 12)
                            .foregroundStyle(.madiiDisabled)
                        
                        Text(recommendJoys[0].contents)
                            .madiiFont(font: .madiiBody2, color: .madiiNormal)
                            .frame(maxWidth: .infinity)
                            .frame(height: 26)
                    }
                    .padding(.vertical, 19)
                    .padding(.leading, 26)
                    .padding(.trailing, 67)
                    .background(.madiiElevated)
                    .cornerRadius(20)
                    .gradientBorder(hexColors: ["FFFFFF", "3DC2FF", "FFFFFF"], lineWidth: 1, cornerRadius: 20, startPoint: .topLeading, endPoint: .bottomTrailing, opacity: 0.1)
                    .opacity(selectedJoy == recommendJoys[0] ? 1.0 : 0.4)
                }
            }
            
            Spacer().frame(height: 12)
            
            if recommendJoys.isEmpty {
                HStack(spacing: 12) {
                    Circle()
                        .frame(width: 12, height: 12)
                        .foregroundStyle(.madiiDisabled)
                    
                    RoundedRectangle(cornerRadius: 8)
                        .frame(maxWidth: .infinity)
                        .frame(height: 26)
                        .foregroundStyle(.madiiDisabled)
                }
                .padding(.vertical, 19)
                .padding(.leading, 26)
                .padding(.trailing, 67)
                .background(.madiiElevated)
                .cornerRadius(20)
                .opacity(0.6)
                .gradientBorder(hexColors: ["FFFFFF", "3DC2FF", "FFFFFF"], lineWidth: 1, cornerRadius: 20, startPoint: .topLeading, endPoint: .bottomTrailing, opacity: 0.1)
            } else {
                Button {
                    if selectedJoy == recommendJoys[1] {
                        selectedJoy = nil
                    } else {
                        selectedJoy = recommendJoys[1]
                    }
                } label: {
                    HStack(spacing: 12) {
                        Circle()
                            .frame(width: 12, height: 12)
                            .foregroundStyle(.madiiDisabled)
                        
                        Text(recommendJoys[1].contents)
                            .madiiFont(font: .madiiBody2, color: .madiiNormal)
                            .frame(maxWidth: .infinity)
                            .frame(height: 26)
                    }
                    .padding(.vertical, 19)
                    .padding(.leading, 26)
                    .padding(.trailing, 67)
                    .background(.madiiElevated)
                    .cornerRadius(20)
                    .gradientBorder(hexColors: ["FFFFFF", "3DC2FF", "FFFFFF"], lineWidth: 1, cornerRadius: 20, startPoint: .topLeading, endPoint: .bottomTrailing, opacity: 0.1)
                    .opacity(selectedJoy == recommendJoys[1] ? 1.0 : 0.4)
                }
            }
            
            Spacer().frame(height: 12)
            
            if recommendJoys.isEmpty {
                HStack(spacing: 12) {
                    Circle()
                        .frame(width: 12, height: 12)
                        .foregroundStyle(.madiiDisabled)
                    
                    RoundedRectangle(cornerRadius: 8)
                        .frame(maxWidth: .infinity)
                        .frame(height: 26)
                        .foregroundStyle(.madiiDisabled)
                }
                .padding(.vertical, 19)
                .padding(.leading, 26)
                .padding(.trailing, 67)
                .background(.madiiElevated)
                .cornerRadius(20)
                .opacity(0.4)
                .gradientBorder(hexColors: ["FFFFFF", "3DC2FF", "FFFFFF"], lineWidth: 1, cornerRadius: 20, startPoint: .topLeading, endPoint: .bottomTrailing, opacity: 0.1)
            } else {
                Button {
                    if selectedJoy == recommendJoys[2] {
                        selectedJoy = nil
                    } else {
                        selectedJoy = recommendJoys[2]
                    }
                } label: {
                    HStack(spacing: 12) {
                        Circle()
                            .frame(width: 12, height: 12)
                            .foregroundStyle(.madiiDisabled)
                        
                        Text(recommendJoys[2].contents)
                            .madiiFont(font: .madiiBody2, color: .madiiNormal)
                            .frame(maxWidth: .infinity)
                            .frame(height: 26)
                    }
                    .padding(.vertical, 19)
                    .padding(.leading, 26)
                    .padding(.trailing, 67)
                    .background(.madiiElevated)
                    .cornerRadius(20)
                    .gradientBorder(hexColors: ["FFFFFF", "3DC2FF", "FFFFFF"], lineWidth: 1, cornerRadius: 20, startPoint: .topLeading, endPoint: .bottomTrailing, opacity: 0.1)
                    .opacity(selectedJoy == recommendJoys[2] ? 1.0 : 0.4)
                }
            }
            
            Spacer()
            
            if selectedJoy != nil {
                Button {
                    selectedJoy = nil
                } label: {
                    Text("다시 고르기")
                        .madiiFont(font: .madiiBody3, color: .madiiNeutral)
                        .underline()
                }
                .padding(.bottom, 16)
            }
            
            MadiiDesignSystem.MadiiButton(title: selectedJoy == nil ? "완료" : "오늘의 플레이리스트에 추가", color: .violet) {
                playJoy()
            }
                .disabled(selectedJoy == nil)
        }
        .padding(.horizontal, 20)
        .navigationTitle("취향저격 소확행")
        .background(
            LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: Color(red: 14/255, green: 21/255, blue: 44/255), location: 0.0),
                    .init(color: Color(red: 54/255, green: 33/255, blue: 96/255), location: 1.0)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }
    
    func getRecommendJoy() {
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
    
    private func playJoy() {
        AchievementsAPI.shared.playJoy(joyId: selectedJoy?.joyId ?? 0) { isSuccess, isDuplicate in
            if isSuccess {
                print("DEBUG HomeTodayJoyView playJoy: isSuccess true")
            } else if isDuplicate {
                withAnimation {
                    print("DEBUG HomeTodayJoyView playJoy: isSuccess false and isDuplicate true")
                }
            } else {
                print("DEBUG HomeTodayJoyView playJoy: isSuccess false")
            }
        }
    }
}

#Preview {
    RecommendJoyView3()
}
