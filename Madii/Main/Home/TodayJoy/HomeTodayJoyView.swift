//
//  HomeTodayJoyView.swift
//  Madii
//
//  Created by 정태우 on 12/23/23.
//

import SwiftUI

struct HomeTodayJoyView: View {
    @State private var isClickedToday: Bool = true /// 클릭 여부
    
    @State var counter = 0 /// 파티클 애니메이션 추가
    @State var todayJoy: GetJoyResponseJoy?
    @State var todayJoyTitle: String = ""
    @State private var myNewJoy: String = "샤브샤브 먹고 싶어"
    @Binding var showSaveJoyPopUp: Bool
    @State var todayJoyEllipsis: GetJoyResponseJoy?
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 20) {
                if isClickedToday == false {
                    // 클릭해보세요! 버튼
                    TodayJoyBeforeClickButton(isClickedToday: $isClickedToday, counter: $counter)
                } else {
                    HStack {
                        Image("play")
                            .resizable()
                            .frame(width: 56, height: 56)
                        Text(todayJoyTitle)
                            .madiiFont(font: .madiiBody3, color: .white)
                        Spacer()
                        Button {
                            showSaveJoyPopUp = true
                        } label: {
                            Image("play")
                                .resizable()
                                .foregroundColor(.gray300)
                                .frame(width: 16, height: 18)
                        }
                        Button {
                            guard let todayJoyEllipsis = todayJoy else { return }
                        } label: {
                            Image(systemName: "ellipsis")
                                .foregroundColor(.gray500)
                                .rotationEffect(Angle(degrees: 90))
                        }
                            .sheet(item: $todayJoyEllipsis, content: { item in
                                JoyMenuBottomSheet(joy: Joy(title: ""), isMine: false)
                            })
                    }
                }
            }
            .roundBackground("오늘의 소확행")
            .padding(.top, 14)
            .padding(.bottom, 16)
            
            ParticleView(counter: $counter)
        }
    }
}

#Preview {
    HomeTodayJoyView(todayJoy: GetJoyResponseJoy(joyId: 0, joyIconNum: 0, contents: ""), showSaveJoyPopUp: .constant(true))
}
