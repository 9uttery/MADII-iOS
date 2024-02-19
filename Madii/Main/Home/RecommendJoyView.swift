//
//  RecommendJoyView.swift
//  Madii
//
//  Created by 정태우 on 1/28/24.
//

import SwiftUI

struct RecommendJoyView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var nickName: String = "코코"
    @State var recommendJoy: Joy = Joy(title: "넷플릭스 보면서 귤 까먹기", counts: 1, satisfaction: JoySatisfaction.great, isSaved: true)
    
    var body: some View {
        VStack(spacing: 0) {
            Text("\(nickName)님의 취향저격 소확행")
                .madiiFont(font: .madiiSubTitle, color: .white)
                .padding(.top, 28)
                .padding(.bottom, 68)
            VStack(spacing: 0) {
                Image("")
                    .resizable()
                    .frame(width: 220, height: 220)
                
            Text(recommendJoy.title)
                .madiiFont(font: .madiiSubTitle, color: .white)
                .padding(.bottom, 20)
            HStack {
                Button {
                    
                } label: {
                    if recommendJoy.isSaved {
                        Image("activeSave")
                    } else {
                        Image("inActiveSave")
                    }
                    
                }
                Button {
                    
                } label: {
                    HStack {
                        Image("play")
                            .resizable()
                            .frame(width: 18, height: 20)
                        Text("플레이")
                            .madiiFont(font: .madiiBody3, color: .black)
                    }
                    .padding(.vertical, 9.5)
                    .padding(.leading, 22)
                    .padding(.trailing, 25)
                    .background(Color.white)
                    .cornerRadius(6)
                }
            }
                
            }
            .padding(.top, 40)
            .padding(.horizontal, 50)
            .padding(.bottom, 48)
            .background(Color.madiiBox)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .inset(by: 0.5)
                    .stroke(
                        LinearGradient(
                            stops: [
                                Gradient.Stop(color: .white, location: 0.00),
                                Gradient.Stop(color: .white.opacity(0.2), location: 0.27),
                                Gradient.Stop(color: .white, location: 0.51),
                                Gradient.Stop(color: .white.opacity(0.2), location: 0.77),
                                Gradient.Stop(color: .white, location: 1.00)
                            ],
                        startPoint: UnitPoint(x: 0.5, y: 0),
                        endPoint: UnitPoint(x: 0.5, y: 1)
                    ), lineWidth: 1)
            )
            .padding(.bottom, 28)
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("다시 고르기")
                    .madiiFont(font: .madiiBody4, color: .white)
                    .underline()
            }
            Spacer()
    
            NavigationLink {
                HomeView()
            } label: {
                StyleJoyNextButton(label: "완료", isDisabled: true)
            }
        }
        .navigationTitle("\(nickName)님의 취향저격 소확행")
        .toolbarBackground(Color.clear, for: .navigationBar)
        .padding(.horizontal, 16)
        .background(
                LinearGradient(
                stops: [
                Gradient.Stop(color: Color(red: 0.61, green: 0.42, blue: 1).opacity(0.2), location: 0.00),
                Gradient.Stop(color: Color(red: 0.5, green: 0.77, blue: 0.91).opacity(0.2), location: 0.48),
                Gradient.Stop(color: Color(red: 0.81, green: 0.98, blue: 0.32).opacity(0.2), location: 1.00)
                ],
                startPoint: UnitPoint(x: 0.5, y: -0.19),
                endPoint: UnitPoint(x: 0.5, y: 1.5)
                )
            )
            .background(Color(red: 0.06, green: 0.06, blue: 0.13))
    }
}

#Preview {
    RecommendJoyView()
}
