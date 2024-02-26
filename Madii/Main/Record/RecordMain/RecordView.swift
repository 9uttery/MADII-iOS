//
//  RecordView.swift
//  Madii
//
//  Created by 이안진 on 11/29/23.
//

import SwiftUI

struct RecordView: View {
    @AppStorage("isLoggedIn") var isLoggedIn = false
    @EnvironmentObject private var popUpStatus: PopUpStatus
    
    @State private var newJoy: Joy = Joy(title: "")
    @State private var showSaveJoyToast: Bool = false
    
    @State private var showAddAlbumPopUp: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 0) {
                navigationBar
                    
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        // 나만의 소확행을 기록해 보세요
                        SaveMyJoyView(joy: $newJoy, showSaveJoyToast: $showSaveJoyToast)
                            .padding(.top, 12)
                        
                        // 최근 본 앨범 & 많이 실천한 소확행 & 내가 기록한 소확행
                        UserAnalyticsView()
                        
                        if isLoggedIn {
                            // 소확행 앨범
                            MyAlbumsView(showAddAlbumPopUp: $showAddAlbumPopUp)
                        } else {
                            beforeLoginMyAlbums
                        }
                    }
                    // 화면 전체 좌우 여백 16
                    .padding(.horizontal, 16)
                    // 하단 여백 40
                    .padding(.bottom, 40)
                    
                }
                .scrollIndicators(.hidden)
            }
            // 나만의 소확행 앨범에 저장 팝업
            .transparentFullScreenCover(isPresented: $popUpStatus.showSaveJoyToAlbumPopUp) {
                SaveMyJoyPopUpView(joy: $newJoy, showSaveJoyToAlbumPopUp: .constant(true)) }
            
            // 소확행 기록 완료 토스트메시지
            if showSaveJoyToast { SaveJoyToast() }
            
            // 새로운 앨범 추가 팝업
            if showAddAlbumPopUp { AddAlbumPopUp(showAddAlbumPopUp: $showAddAlbumPopUp) }
        }
        .navigationTitle("")
    }
    
    var navigationBar: some View {
        HStack(spacing: 0) {
            Text("레코드")
                .madiiFont(font: .madiiTitle, color: .white)
                .padding(.vertical, 12)
                .padding(.horizontal, 22)
            
            Spacer()
        }
    }
    
    var beforeLoginMyAlbums: some View {
        HStack {
            Spacer()
            
            VStack(spacing: 16) {
                Text("로그인 후 나만의 소확행 앨범을 만들고,\n오늘 해보고 싶은 소확행을 앨범에 담아보세요")
                    .madiiFont(font: .madiiBody4, color: .gray500)
                    .multilineTextAlignment(.center)
                
                Text("로그인하러 가기")
                    .font(.madiiBody1)
                    .foregroundColor(Color(red: 0.51, green: 0.68, blue: 0.02))
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .background(Color.madiiYellowGreen)
                    .cornerRadius(90)
            }
            
            Spacer()
        }
        .padding(.top, 120)
    }
}

#Preview {
    SplashView()
//    MadiiTabView()
}

extension View {
    func withoutAnimation(action: @escaping () -> Void) {
        var transaction = Transaction()
        transaction.disablesAnimations = true
        withTransaction(transaction) {
            action()
        }
    }
}
