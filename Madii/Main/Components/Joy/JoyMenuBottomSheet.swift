//
//  JoyMenuBottomSheet.swift
//  Madii
//
//  Created by 이안진 on 1/24/24.
//

import SwiftUI

struct JoyMenuBottomSheet: View {
    let joy: Joy
    var isMine: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(joy.title)
                    .madiiFont(font: .madiiTitle, color: .white)
                    .padding(.horizontal, 16)
                    .padding(.top, 28)
                    .padding(.bottom, 32)
                    
                Spacer()
            }
            .background(Color.madiiOption)
            
            VStack(alignment: .leading, spacing: 0) {
                Button {
                    
                } label: {
                    bottomSheetRow("오늘의 플레이리스트에 추가하기")
                }
                
                Button {
                    
                } label: {
                    bottomSheetRow("앨범에 저장하기")
                }
                
                Button {
                    
                } label: {
                    bottomSheetRow("수정")
                }
                
                if isMine {
                    Button {
                        
                    } label: {
                        bottomSheetRow("삭제")
                    }
                }
            }
            
            Spacer()
        }
        .background(Color.madiiPopUp)
        .presentationDetents([.height(isMine ? 350 : 280)])
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

#Preview {
    MyJoyView()
}
