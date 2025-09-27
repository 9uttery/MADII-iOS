//
//  JoyOptionBottomSheet.swift
//  Madii
//
//  Created by 정태우 on 9/22/25.
//

import SwiftUI

struct JoyOptionBottomSheet: View {
    @Binding var joyId: Int
    @State var joyTitle: String = ""
    @State var isDuplicated: Bool = false
    @Binding var showJoyOptionBottomSheet: Bool
    @Binding var showEditJoyBottomSheeet: Bool
    @Binding var showDeleteJoyBottomSheet: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(joyTitle)
                .madiiFont(font: .title2, color: .madiiNormal)
                .padding(.vertical, 40)
            
            Button {
                
            } label: {
                Text("오늘의 플레이리스트에 추가")
                    .madiiFont(font: .madiiBody1, color: .madiiNormal)
            }
            .padding(.bottom, 28)
            
            Button {
                
            } label: {
                Text("수정")
                    .madiiFont(font: .madiiBody1, color: .madiiNormal)
            }
            .padding(.bottom, 28)
            
            Button {
                
            } label: {
                Text("삭제")
                    .madiiFont(font: .madiiBody1, color: .madiiNormal)
            }
            .padding(.bottom, 28)
        }
        .padding(.horizontal, 20)
    }
    
    func postJoyPlaylist() {
        AchievementsAPI().playJoy(joyId: joyId) { isSuccess, isDuplicated in
            if isSuccess {
                if isDuplicated {
                    showJoyOptionBottomSheet = false
                } else {
                    
                }
                print("Debug plyJoy: post isSuccess true")
            } else {
                print("Debug plyJoy: post isSuccess false")
            }
        }
    }
}
//
//#Preview {
//    JoyOptionBottomSheet(joyId: .constant(0), showJoyOptionBottomSheet: .c)
//}
