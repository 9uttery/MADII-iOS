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
    @State var showSaveJoyToAlbumPopUp: Bool = false
    @State var selectedJoyEllipsis: Joy?
    @Binding var isClicked: [Bool]
    @Binding var clickedNum: Int
    @Binding var reClicked: Bool
    @State private var xOffset: CGFloat = 0
    @State private var showTodayPlaylist: Bool = false
    @Binding var isRecommendJoy: Bool
    @State private var newJoy: Joy = Joy(title: "")
    
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
                .padding(.bottom, 4)
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
                        AnalyticsManager.shared.logEvent(name: "취향저격소확행뷰_추천소확행클릭")
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
                                showSaveJoyToAlbumPopUp.toggle()
                                selectedJoyEllipsis = Joy(joyId: joy.joyId, title: joy.contents)
                                AnalyticsManager.shared.logEvent(name: "취향저격소확행뷰_추천소확행앨범저장클릭")
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
                .padding(.bottom, 4)
            }
            
            if !recommendJoys.isEmpty {
                Button {
                    reClicked.toggle()
                    selectedJoy = nil
                    selectedIdx = nil
                    AnalyticsManager.shared.logEvent(name: "취향저격소확행뷰_다시고르기클릭")
                } label: {
                    Text("다시 고르기")
                        .madiiFont(font: .madiiBody4, color: .white)
                        .underline()
                }
            } else {
                Text("")
                    .madiiFont(font: .madiiBody4, color: .white)
                    .underline()
            }
            
            Spacer()
            
            Button {
                AnalyticsManager.shared.logEvent(name: "취향저격소확행뷰_오플리에추가클릭")
                isRecommendJoy.toggle()
                playJoy(joyId: selectedJoy!.joyId)
            } label: {
                StyleJoyNextButton(label: "오늘의 플레이리스트에 추가", isDisabled: selectedJoy != nil ? true : false)
            }
            .frame(width: UIScreen.main.bounds.width - 40, height: 96)
            .disabled(selectedJoy != nil ? false : true)
        }
        .onChange(of: selectedJoyEllipsis) { _ in
            newJoy = selectedJoyEllipsis ?? Joy(title: "넷플릭스 먹으면서 귤 보기")
                }
        .transparentFullScreenCover(isPresented: $showSaveJoyToAlbumPopUp) {
            SaveMyJoyPopUpView(joy: $newJoy, showSaveJoyToAlbumPopUp: $showSaveJoyToAlbumPopUp, showSaveJoyPopUpFromRecordMain: .constant(false), fromAlbumSetting: true) }
    }
    
    private func playJoy(joyId: Int) {
        AchievementsAPI.shared.playJoy(joyId: joyId) { isSuccess, isDuplicate in
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
            } else if isDuplicate {
                withAnimation {
                    appStatus.isDuplicate.toggle()
                }
                print("DEBUG HomeTodayJoyView playJoy: isSuccess false and isDuplicate true")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        appStatus.isDuplicate = false
                    }
                }
            } else {
                print("DEBUG JoyMenuBottomSheet: 오플리에 추가 false")
            }
        }
    }
}

