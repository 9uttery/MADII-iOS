//
//  JoyEllipsisBottomSheet.swift
//  Madii
//
//  Created by 정태우 on 10/12/25.
//

import SwiftUI

struct JoyEllipsisBottomSheet: View {
    @Binding var joyId: Int
    @Binding var joyTitle: String
    @Binding var showJoyEllipsisBottomSheet: Bool
    @Binding var showAlbumSavedBottomSheet: Bool
    @Binding var isDuplicated: Bool
    @Binding var isPlayJoy: Bool
    
    var body: some View {
        VStack {
            Rectangle()
                .frame(width: 100, height: 5)
                .foregroundStyle(.madiiContrast)
                .cornerRadius(2.5)
                .padding(.top, 16)
            
            Text(joyTitle)
                .madiiFont(font: .madiiTitle, color: .madiiNormal)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 40)
            
            Button {
                postJoyPlaylist()
            } label: {
                Text("오늘의 플레이리스트에 추가하기")
                    .madiiFont(font: .madiiBody1, color: .madiiNormal)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.bottom, 28)
            
            Button {
                showJoyEllipsisBottomSheet = false
                showAlbumSavedBottomSheet = true
            } label: {
                Text("앨범에 저장하기")
                    .madiiFont(font: .madiiBody1, color: .madiiNormal)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.bottom, 40)
        }
        .padding(.horizontal, 20)
        .background(.madiiElevated)
        .cornerRadius(40)
        .padding(.horizontal, 20)
        .background(.clear)
    }
    
    func postJoyPlaylist() {
        AchievementsAPI().playJoy(joyId: joyId) { isSuccess, isDuplicated in
            if isSuccess {
                if isDuplicated {
                    showJoyEllipsisBottomSheet = false
                    self.isDuplicated = true
                } else {
                    showJoyEllipsisBottomSheet = false
                    isPlayJoy = true
                }
                print("Debug plyJoy: post isSuccess true")
            } else {
                print("Debug plyJoy: post isSuccess false")
                showJoyEllipsisBottomSheet = false
                self.isDuplicated = true
            }
        }
    }
}
