//
//  RecordView.swift
//  Madii
//
//  Created by 이안진 on 11/29/23.
//

import SwiftUI

struct RecordView: View {
    @EnvironmentObject private var popUpStatus: PopUpStatus
    
    @State private var showSaveJoyPopUp: Bool = false
    @State private var showSaveJoyToast: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    HStack(spacing: 0) {
                        Text("레코드")
                            .madiiFont(font: .madiiTitle, color: .white)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 22)
                        
                        Spacer()
                    }
                    .padding(.bottom, 12)
                    
                    VStack(alignment: .leading, spacing: 20) {
                        // 나만의 소확행을 기록해 보세요
                        SaveMyJoyView(showSaveJoyPopUp: $showSaveJoyPopUp)
                        
                        // 최근 & 많이 실천한 소확행
                        AchievedJoyView()
                        
                        // 소확행 앨범
                        MyAlbumsView()
                    }
                    // 화면 전체 좌우 여백 16
                    .padding(.horizontal, 16)
                }
                // 하단 여백 40
                .padding(.bottom, 40)
            }
            .scrollIndicators(.hidden)
            
            // 나만의 소확행 저장 팝업
            if showSaveJoyPopUp {
                SaveMyJoyPopUpView(showSaveJoyPopUp: $showSaveJoyPopUp,
                                   showSaveJoyToast: $showSaveJoyToast)
            }
            
            // 앨범 정보 수정 팝업
            if popUpStatus.showChangeAlbumInfo {
                ChangeAlbumInfoPopUpView()
            }
            
            // 앨범 삭제 팝업
            if popUpStatus.showDeleteAlbum {
                DeleteAlbumPopUpView()
            }
            
            // 앨범 저장 토스트메시지
            if showSaveJoyToast { SaveJoyToast() }
        }
        .navigationTitle("")
    }
}

#Preview {
    MadiiTabView()
}
