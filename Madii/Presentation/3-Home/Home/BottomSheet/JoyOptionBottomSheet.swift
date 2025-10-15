//
//  JoyOptionBottomSheet.swift
//  Madii
//
//  Created by 정태우 on 9/22/25.
//

import SwiftUI

struct JoyOptionBottomSheet: View {
    @Binding var joyId: Int
    @Binding var joyTitle: String
    @Binding var showJoyOptionBottomSheet: Bool
    @Binding var showEditJoyBottomSheeet: Bool
    @Binding var showDeleteJoyBottomSheet: Bool
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
                showJoyOptionBottomSheet = false
                showEditJoyBottomSheeet = true
            } label: {
                Text("수정하기")
                    .madiiFont(font: .madiiBody1, color: .madiiNormal)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.bottom, 28)
            
            Button {
                showJoyOptionBottomSheet = false
                showDeleteJoyBottomSheet = true
            } label: {
                Text("삭제하기")
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
                    showJoyOptionBottomSheet = false
                    self.isDuplicated = true
                } else {
                    showJoyOptionBottomSheet = false
                    isPlayJoy = true
                }
                print("Debug plyJoy: post isSuccess true")
            } else {
                print("Debug plyJoy: post isSuccess false")
                showJoyOptionBottomSheet = false
                self.isDuplicated = true
            }
        }
    }
}
