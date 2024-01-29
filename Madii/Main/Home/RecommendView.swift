//
//  RecommendView.swift
//  Madii
//
//  Created by 정태우 on 1/26/24.
//

import SwiftUI

struct RecommendView: View {
    @State private var selectedIdx: UUID?
    @State var nickName: String = "코코"
    @State var isClicked: [Bool] = Array(repeating: false, count: 9)
    @State var recommendJoys: [Joy] = Joy.dailyJoyDummy
    @State private var selectedJoy: Joy?
    var body: some View {
        VStack(spacing: 0) {
            Text("키워드를 선택해주세요")
                .madiiFont(font: .madiiBody4, color: .white)
                .padding(.top, 28)
                .padding(.bottom, 40)
            VStack(spacing: 12) {
                HStack {
                    StyleJoyButton(label: "화창한 날씨", isClicked: $isClicked[0], buttonColor: Color.madiiSkyBlue)
                    
                    StyleJoyButton(label: "혼자서", isClicked: $isClicked[1], buttonColor: Color.madiiPink)
                    
                    StyleJoyButton(label: "특별한 도전을 할 수 있는", isClicked: $isClicked[2], buttonColor: Color.madiiOrange)
                }
                HStack {
                    StyleJoyButton(label: "지금 바로 할 수 있는", isClicked: $isClicked[3], buttonColor: Color.madiiOrange)
                    
                    StyleJoyButton(label: "비 오는 날씨", isClicked: $isClicked[4], buttonColor: Color.madiiSkyBlue)
                    
                    StyleJoyButton(label: "다 함께", isClicked: $isClicked[5], buttonColor: Color.madiiPink)
                }
                HStack {
                    StyleJoyButton(label: "눈 오는 날씨", isClicked: $isClicked[6], buttonColor: Color.madiiSkyBlue)
                    
                    StyleJoyButton(label: "일상 속에서 할 수 있는", isClicked: $isClicked[7], buttonColor: Color.madiiOrange)
                    
                    StyleJoyButton(label: "둘이서", isClicked: $isClicked[8], buttonColor: Color.madiiPink)
                }
            }
            .padding(.bottom, 81)
            VStack(spacing: 12) {
                if recommendJoys.isEmpty {
                    ForEach(1...3, id: \.self) {_ in
                        HStack(spacing: 0) {
                            Circle()
                                .foregroundColor(.gray300)
                                .frame(width: 56, height: 56)
                                .padding(.trailing, 15)
                            Rectangle()
                                .foregroundColor(.gray300)
                                .frame(width: 172, height: 20)
                            Spacer()
                            Image(systemName: "ellipsis")
                        }
                        .padding(20)
                        .background(Color.madiiBox)
                        .cornerRadius(20)
                        .opacity(0.4)
                    }
                } else {
                    ForEach(recommendJoys) { joy in
                        Button {
                            if selectedIdx == joy.id {
                                selectedIdx = nil
                            } else {
                                selectedIdx = joy.id
                            }
                        } label: {
                            HStack(spacing: 0) {
                                Image("")
                                    .resizable()
                                    .frame(width: 56, height: 56)
                                    .background(Color.black)
                                    .cornerRadius(90)
                                    .padding(.trailing, 15)
                                
                                Text(joy.title)
                                    .madiiFont(font: .madiiBody3, color: .white)
                                    .multilineTextAlignment(.leading)
                                
                                Spacer()
                                
                                Button {
                                    selectedJoy = joy
                                } label: {
                                    VStack {
                                        Image(systemName: "ellipsis")
                                    }
                                    .frame(width: 40, height: 40)
                                }
                            }
                            .roundBackground()
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .inset(by: 0)
                                    .stroke(joy.id == selectedIdx ? Color.madiiYellowGreen : Color.clear, lineWidth: 2)
                            )
                        }
                    }
                    .sheet(item: $selectedJoy) { item in
                        JoyMenuBottomSheet(joy: item, isMine: true) }
                }
                Spacer()
                NavigationLink {
                    
                } label: {
                    StyleJoyNextButton(label: "완료", isDisabled: isClicked.contains(true))
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
