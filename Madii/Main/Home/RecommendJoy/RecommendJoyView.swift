//
//  RecommendJoyView.swift
//  Madii
//
//  Created by 정태우 on 1/28/24.
//

import SwiftUI

struct RecommendJoyView: View {
    @State var rotation: CGFloat = 0.0
    @EnvironmentObject var appStatus: AppStatus
    @Environment(\.presentationMode) var presentationMode
    
    @State var nickname: String
    @State var recommendJoy: GetJoyResponseJoy = GetJoyResponseJoy(joyId: 0, joyIconNum: 1, contents: "넷플릭스 보면서 귤까기", isJoySaved: false)
    @State private var frameWidth: CGFloat = UIScreen.main.bounds.width
    @State private var isActive: Bool = false
    @State var updatePlaylistBar: Bool = true
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(.clear)
                .frame(width: frameWidth, height: frameWidth)
                .background(
                EllipticalGradient(
                    stops: [
                        Gradient.Stop(color: .white.opacity(0.21), location: 0.00),
                        Gradient.Stop(color: .white.opacity(0.03), location: 1.00)
                        ],
                        center: UnitPoint(x: 0.5, y: 0.5)
                    )
                )
                .cornerRadius(frameWidth)
                .opacity(0.6)
            
            Circle()
                .foregroundColor(.clear)
                .frame(width: frameWidth * 1.44, height: frameWidth * 1.44)
                .background(
                    EllipticalGradient(
                        stops: [
                            Gradient.Stop(color: .white.opacity(0.18), location: 0.00),
                            Gradient.Stop(color: .white.opacity(0.03), location: 1.00)
                        ],
                        center: UnitPoint(x: 0.5, y: 0.5)
                    )
                )
                .cornerRadius(frameWidth * 1.44)
                .opacity(0.6)
            
            Circle()
                .foregroundColor(.clear)
                .frame(width: frameWidth * 1.83, height: frameWidth * 1.83)
                .background(
                    EllipticalGradient(
                    stops: [
                        Gradient.Stop(color: .white.opacity(0.18), location: 0.00),
                        Gradient.Stop(color: .white.opacity(0.03), location: 1.00)
                    ],
                    center: UnitPoint(x: 0.5, y: 0.5)
                    )
                )
                .cornerRadius(frameWidth * 1.83)
                .opacity(0.6)
            
            VStack(spacing: 0) {
                Spacer()
                
                ZStack {
                    VStack(spacing: 0) {
                        ZStack {
                            Circle()
                                .stroke(Color.white.opacity(0.2), lineWidth: 1)
                                .frame(width: 220, height: 220)
                                .background(Color.black)
                                .cornerRadius(110)
                            
                            Image("icon_\(recommendJoy.joyIconNum)")
                                .resizable()
                                .frame(width: 118, height: 118)
                        }
                        .padding(.bottom, 42)
                        
                        Text(recommendJoy.contents)
                            .madiiFont(font: .madiiSubTitle, color: .white)
                            .multilineTextAlignment(.center)
                            .frame(width: frameWidth - 130)
                            .padding(.bottom, 20)
                    }
                    .frame(width: frameWidth - 70)
                    .padding(.top, 40)
                    .padding(.bottom, 48)
                    .background(Color.madiiBox)
                    .cornerRadius(20)
                    
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .frame(width: 200, height: 200)
                        .offset(x: 200)
                        .foregroundStyle(
                            LinearGradient(
                                stops: [
                                    Gradient.Stop(color: .white, location: 0.00),
                                    Gradient.Stop(color: Color(red: 0.8, green: 0.8, blue: 0.8), location: 0.35),
                                    Gradient.Stop(color: .white, location: 0.65),
                                    Gradient.Stop(color: Color(red: 0.8, green: 0.8, blue: 0.8), location: 1.00)
                                ],
                                startPoint: UnitPoint(x: 0.5, y: 0),
                                endPoint: UnitPoint(x: 0.5, y: 1)
                            )
                        )
                        .rotationEffect(.degrees(rotation))
                        .mask {
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .stroke(lineWidth: 3)
                                .frame(width: frameWidth - 66, height: 396)
                        }
                }
                .padding(.bottom, 31)
                
                Text("\(nickname)님을 위한 소확행이에요!")
                    .madiiFont(font: .madiiSubTitle, color: .white)
                    .padding(.bottom, 80)
                
                Spacer()
                
                NavigationLink(
                    destination: MadiiTabView(),
                    isActive: $isActive
                ) {
                    EmptyView()
                }
            }
        }
        .navigationBarHidden(true)
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
        .onAppear {
            ProfileAPI.shared.getUsersProfile { isSuccess, userProfile in
                if isSuccess {
                    nickname = userProfile.nickname
                }
            }
            playJoy(joyId: recommendJoy.joyId)
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                isActive = true
            }
            withAnimation(.linear(duration: 4).repeatForever(autoreverses: false)) {
                rotation = 360
            }
        }
    }
    
    private func playJoy(joyId: Int) {
        AchievementsAPI.shared.playJoy(joyId: joyId) { isSuccess in
            if isSuccess {
                print("DEBUG JoyMenuBottomSheet: 오플리에 추가 true")
                
                withAnimation {
                    appStatus.showAddPlaylistToast = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        appStatus.showAddPlaylistToast = false
                    }
                }
            } else {
                print("DEBUG JoyMenuBottomSheet: 오플리에 추가 false")
            }
        }
    }
}

#Preview {
    RecommendJoyView(nickname: "")
}
