//
//  SaveJoyToast.swift
//  Madii
//
//  Created by 이안진 on 12/11/23.
//

import SwiftUI

struct SaveJoyToast: View {
    @Binding var showSaveJoyToAlbumPopUp: Bool
    var transitionEdge: Edge = .bottom
    
    var body: some View {
        HStack {
            Text("내가 기록한 소확행에 저장되었어요")
                .madiiFont(font: .madiiBody4, color: .black)
            
            Spacer()
            
            NavigationLink {
                MyJoyView()
            } label: {
                Text("바로가기")
                    .madiiFont(font: .madiiBody4, color: .madiiOrange)
                    .padding(.horizontal, 8)
            }
            .simultaneousGesture(TapGesture().onEnded {
                AnalyticsManager.shared.logEvent(name: "소확행기록하기토스트_앨범저장클릭")
            })
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 12)
        .frame(height: 40)
        .background(Color.white)
        .cornerRadius(6)
        .padding(.horizontal, 16)
        .offset(y: -20)
        .transition(.move(edge: transitionEdge))
        .analyticsScreen(name: "소확행기록하기토스트")
    }
}
