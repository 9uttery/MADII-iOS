//
//  RecordView.swift
//  Madii
//
//  Created by 이안진 on 11/29/23.
//

import SwiftUI

struct RecordView: View {
    @Binding var isTabBarShown: Bool
    @State private var showSaveJoyPopUp: Bool = false
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    title
                    
                    VStack(alignment: .leading, spacing: 16) {
                        // 나만의 소확행을 수집해보세요
                        SaveMyJoyView(isTabBarShown: $isTabBarShown,
                                      showSaveJoyPopUp: $showSaveJoyPopUp)
                        
                        // 최근 & 많이 실천한 소확행
                        AchievedJoyView()
                        
                        // 소확행 앨범
                        albums
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
                SaveMyJoyPopUpView(isTabBarShown: $isTabBarShown,
                                   showSaveJoyPopUp: $showSaveJoyPopUp)
            }
        }
        .navigationTitle("")
    }
    
    var title: some View {
        HStack(spacing: 0) {
            Text("레코드")
                .madiiFont(font: .madiiTitle, color: .white)
                .padding(.vertical, 12)
            
            Spacer()
        }
        .padding(.horizontal, 22)
        .padding(.bottom, 12)
    }
    
    var albums: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(spacing: 0) {
                Text("소확행 앨범")
                    .madiiFont(font: .madiiSubTitle, color: .white)
                
                Spacer()
                
                Text("추가")
                    .madiiFont(font: .madiiBody5, color: .white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.madiiOption)
                    .cornerRadius(6)
            }
            
            VStack(spacing: 16) {
                ForEach(0 ... 6, id: \.self) { _ in
                    AlbumRowWithRightView {
                        Button {} label: {
                            Image(systemName: "ellipsis")
                                .resizable()
                                .frame(width: 20, height: 4)
                                .foregroundStyle(Color.gray500)
                                .padding(10)
                                .padding(.vertical, 8)
                        }
                    }
                }
            }
        }
        .roundBackground(bottomPadding: 32)
    }
}
