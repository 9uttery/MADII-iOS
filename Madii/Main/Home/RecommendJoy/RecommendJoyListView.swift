//
//  RecommendJoyListView.swift
//  Madii
//
//  Created by 정태우 on 2/18/24.
//

import SwiftUI

struct RecommendJoyListView: View {
    @State private var selectedIdx: Int?
    @EnvironmentObject var appStatus: AppStatus
    @Binding var recommendJoys: [GetJoyResponseJoy]
    @Binding var selectedJoy: GetJoyResponseJoy?
    @State var selectedJoyEllipsis: Joy?
    @Binding var isClicked: [Bool]
    @State var nickname: String
    @Binding var clickedNum: Int
    @Binding var reClicked: Bool
    @State private var xOffset: CGFloat = 0
    @State private var showTodayPlaylist: Bool = false
    @Binding var isRecommendJoy: Bool
    
    var body: some View {
        VStack(spacing: 12) {
            if recommendJoys.isEmpty {
                ForEach(1...3, id: \.self) {_ in
                    ZStack {
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
                        .onAppear {
                            withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                                self.xOffset = UIScreen.main.bounds.width * 2
                            }
                        }
                        .onDisappear {
                            self.xOffset = 0
                        }
                        
                        LinearGradient(gradient: Gradient(colors: [.clear, .white.opacity(0.05), .clear]), startPoint: .leading, endPoint: .trailing)
                            .frame(width: UIScreen.main.bounds.width - 40, height: 96)
                            .offset(x: xOffset - UIScreen.main.bounds.width, y: 0)
                        
                    }
                    .frame(width: UIScreen.main.bounds.width - 40, height: 96)
                }
            } else {
                ForEach(recommendJoys) { joy in
                    Button {
                        if selectedIdx == joy.joyId {
                            selectedIdx = nil
                            selectedJoy = nil
                        } else {
                            selectedIdx = joy.id
                            selectedJoy = joy
                        }
                    } label: {
                        HStack(spacing: 0) {
                            ZStack {
                                Color.black
                                    .frame(width: 56, height: 56)
                                    .cornerRadius(90)
                                
                                Image("icon_\(joy.joyIconNum)")
                                    .resizable()
                                    .frame(width: 34, height: 34)
                            }
                            .padding(.trailing, 15)
                            Text(joy.contents)
                                .madiiFont(font: .madiiBody3, color: .white)
                                .multilineTextAlignment(.leading)
                            
                            Spacer()
                            
                            Button {
                                selectedJoyEllipsis = Joy(joyId: joy.joyId, title: joy.contents)
                            } label: {
                                Image(joy.isJoySaved == true ? "activeSave" : "inactiveSave")
                                    .resizable()
                                    .frame(width: 36, height: 36)
                            }
                        }
                        .roundBackground()
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .inset(by: 0)
                                .stroke(joy.joyId == selectedIdx ? Color.madiiYellowGreen : Color.clear, lineWidth: 2)
                        )
                    }
                    .frame(width: UIScreen.main.bounds.width - 40, height: 96)
                }
            }
            
            if !recommendJoys.isEmpty {
                Button {
                    reClicked.toggle()
                } label: {
                    Text("다시 고르기")
                        .madiiFont(font: .madiiBody4, color: .white)
                        .underline()
                }
            }
            
            Spacer()
            
            Button {
                isRecommendJoy.toggle()
                playJoy(joyId: selectedJoy!.joyId)
            } label: {
                StyleJoyNextButton(label: "오늘의 플레이리스트 추가", isDisabled: selectedJoy != nil ? true : false)
            }
            .frame(width: UIScreen.main.bounds.width - 40, height: 96)
            .disabled(selectedJoy != nil ? false : true)
        }
        .sheet(item: $selectedJoyEllipsis) { _ in
            JoyMenuBottomSheet(joy: $selectedJoyEllipsis, isMine: false, isFromTodayJoy: true)
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
    RecommendJoyListView(recommendJoys: .constant([]), selectedJoy: .constant(nil), isClicked: .constant(Array(repeating: false, count: 9)), nickname: "코코", clickedNum: .constant(0), reClicked: .constant(false), isRecommendJoy: .constant(false))
}
