//
//  PlaylistBarMoveToTodayBottmSheet.swift
//  Madii
//
//  Created by 이안진 on 2/21/24.
//

import SwiftUI

struct PlaylistBarMoveToTodayBottmSheet: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 6) {
                ZStack {
                    Circle()
                        .foregroundStyle(Color.madiiPurple)
                    
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 13, height: 13)
                }
                .frame(width: 24, height: 24)
                
                Text("어제 못한 소확행 오늘 하기")
                    .madiiFont(font: .madiiSubTitle, color: .white)
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 28)
            .padding(.bottom, 4)
            .background(Color.madiiOption)
            
            Text("전날 실천하지 않은 소확행이 있어요\n버튼을 눌러 오늘 실천해 보세요")
                .madiiFont(font: .madiiBody3, color: .white)
                .padding(16)
            
            Spacer()
        }
        .background(Color.madiiPopUp)
    }
}
