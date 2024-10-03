//
//  JoyMenuBottomSheet.swift
//  Madii
//
//  Created by 이안진 on 1/24/24.
//

import SwiftUI

struct JoyMenuBottomSheet: View {
    @EnvironmentObject var appStatus: AppStatus
    
    @Binding var joy: Joy?
    var isMine: Bool = false
    var isFromTodayJoy: Bool = false
    var isAddTodayJoy: Bool = true
    
    @State private var newJoy: Joy = Joy(title: "")
    @State private var showSaveJoyToAlbumPopUp: Bool = false
    @State private var showEditJoyPopUp: Bool = false /// 수정하기 팝업
    @State private var showDeleteJoyPopUp: Bool = false
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(newJoy.title)
                    .madiiFont(font: .madiiTitle, color: .white)
                    .padding(.horizontal, 16)
                    .padding(.top, 28)
                    .padding(.bottom, 32)
                    
                Spacer()
            }
            .background(Color.madiiOption)
            
            VStack(alignment: .leading, spacing: 0) {
                if isAddTodayJoy {
                    Button {
                        AchievementsAPI.shared.playJoy(joyId: joy?.joyId ?? 0) { isSuccess, isDuplicate in
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
                                
                                joy = nil
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
                                AnalyticsManager.shared.logEvent(name: "소확행바텀시트_오플리추가클릭")
                            } else {
                                print("DEBUG JoyMenuBottomSheet: 오플리에 추가 false")
                            }
                        }
                    } label: {
                        bottomSheetRow("오늘의 플레이리스트에 추가")
                    }
                }
                
                if isFromTodayJoy {
                    Button {
                        showSaveJoyToAlbumPopUp = true
                        AnalyticsManager.shared.logEvent(name: "소확행바텀시트_앨범저장클릭")
                    } label: {
                        bottomSheetRow("앨범에 저장")
                    }
                }
                
                if isFromTodayJoy == false {
                    Button {
                        showEditJoyPopUp = true
                        AnalyticsManager.shared.logEvent(name: "소확행바텀시트_앨범저장클릭")
                    } label: {
                        bottomSheetRow("앨범 저장")
                    }
                    
                    if isMine {
                        Button {
                            withoutAnimation {
                                showDeleteJoyPopUp = true
                            }
                            AnalyticsManager.shared.logEvent(name: "소확행바텀시트_삭제클릭")
                        } label: {
                            bottomSheetRow("삭제")
                        }
                    }
                }
            }
            
            Spacer()
        }
        .background(Color.madiiPopUp)
        .onAppear { newJoy = joy ?? Joy(title: "") }
        // 나만의 소확행 앨범에 저장 팝업
        .transparentFullScreenCover(isPresented: $showSaveJoyToAlbumPopUp) {
            SaveMyJoyPopUpView(joy: $newJoy, showSaveJoyToAlbumPopUp: $showSaveJoyToAlbumPopUp, showSaveJoyPopUpFromRecordMain: .constant(false), fromAlbumSetting: true) }
        // 소확행 수정
        .transparentFullScreenCover(isPresented: $showEditJoyPopUp) {
            SaveMyJoyPopUpView(joy: $newJoy, showSaveJoyToAlbumPopUp: $showEditJoyPopUp, showSaveJoyPopUpFromRecordMain: .constant(false), fromAlbumSetting: true, canEditTitle: true) }
        // 소확행 삭제
        .transparentFullScreenCover(isPresented: $showDeleteJoyPopUp) {
            DeleteJoyPopUp(joy: $joy, showDeleteJoyPopUp: $showDeleteJoyPopUp)
        }
        .presentationDetents([.height(isAddTodayJoy ? (isFromTodayJoy ? 240 : (isMine ? 280 : 240)) : 155)])
        .analyticsScreen(name: "소확행바텀시트")
    }
    
    @ViewBuilder
    private func bottomSheetRow(_ title: String) -> some View {
        HStack {
            Text(title)
                .madiiFont(font: .madiiBody3, color: .white)
                Spacer()
        }
        .frame(height: 50)
        .padding(.horizontal, 16)
    }
    
    
}

//#Preview {
//    MyJoyView()
//}
