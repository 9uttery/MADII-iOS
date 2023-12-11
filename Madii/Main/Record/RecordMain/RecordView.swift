//
//  RecordView.swift
//  Madii
//
//  Created by 이안진 on 11/29/23.
//

import SwiftUI

struct RecordView: View {
    @EnvironmentObject private var tabBarManager: TabBarManager
    @State private var showSaveJoyPopUp: Bool = false
    @State private var showChangeAlbumInfoPopUp: Bool = false
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    HStack(spacing: 0) {
                        Text("레코드")
                            .madiiFont(font: .madiiTitle, color: .white)
                            .padding(.vertical, 12)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 22)
                    .padding(.bottom, 12)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        // 나만의 소확행을 수집해보세요
                        SaveMyJoyView(showSaveJoyPopUp: $showSaveJoyPopUp)
                        
                        // 최근 & 많이 실천한 소확행
                        AchievedJoyView()
                        
                        // 소확행 앨범
                        MyAlbumsView(showChangeAlbumInfoPopUp: $showChangeAlbumInfoPopUp)
                    }
                    // 화면 전체 좌우 여백 16
                    .padding(.horizontal, 16)
                    
                    Spacer()
                }
                // 하단 여백 40
                .padding(.bottom, 40)
            }
            .scrollIndicators(.hidden)
            
            // 나만의 소확행 저장 팝업
            if showSaveJoyPopUp {
                SaveMyJoyPopUpView(showSaveJoyPopUp: $showSaveJoyPopUp)
            }
            
            // 앨범 정보 수정 팝업
            if showChangeAlbumInfoPopUp {
                ChangeAlbumInfoPopUpView()
            }
        }
        .navigationTitle("")
    }
}
