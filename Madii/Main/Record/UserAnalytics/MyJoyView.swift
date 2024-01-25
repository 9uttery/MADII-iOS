//
//  MyJoyView.swift
//  Madii
//
//  Created by 이안진 on 12/1/23.
//

import SwiftUI

struct MyJoyView: View {
    @State private var allJoys: [MyJoy] = MyJoy.dummys
//    @State private var allJoys: [MyJoy] = []
    @State private var selectedJoy: Joy? = MyJoy.dummys[0].joys[0]
    
    @State private var sheetHeight: CGFloat = .zero

    var body: some View {
        VStack(spacing: 0) {
            if allJoys.isEmpty {
                // 내가 기록한 소확행 없을 때
                emptyJoyView
            } else {
                // 내가 기록한 소확행 있을 때
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(allJoys) { eachDayJoy in
                            // 날짜별 소확행 박스
                            joyBoxByDate(eachDayJoy.date, joys: eachDayJoy.joys)
                        }
                        .sheet(item: $selectedJoy) { item in
                            JoyMenuBottomSheet(joy: item, isMine: true) }
                    }
                    .padding(.top, 28)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 60)
                }
                .scrollIndicators(.hidden)
            }
        }
        .navigationTitle("내가 기록한 소확행")
        .toolbarBackground(Color.madiiBox, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
    
    private var emptyJoyView: some View {
        VStack(spacing: 60) {
            Rectangle()
                .frame(width: 200, height: 200)
            
            VStack(spacing: 16) {
                Text("기록된 소확행이 없어요.\n소확행을 기록하고 행복을 충전하세요!")
                    .madiiFont(font: .madiiBody3, color: .gray500)
                    .multilineTextAlignment(.center)
                
                Button {
                    // TODO: 레코드 탭 화면으로 넘어가서 소확행 기록 박스 테두리
                } label: {
                    Text("소확행 기록하러 가기")
                        .madiiFont(font: .madiiBody1, color: Color(red: 0.51, green: 0.68, blue: 0.02))
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .background(Color.madiiYellowGreen)
                        .clipShape(RoundedRectangle(cornerRadius: 90))
                }
            }
        }
    }
    
    @ViewBuilder
    private func joyBoxByDate(_ date: String, joys: [Joy]) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(date)
                .madiiFont(font: .madiiSubTitle, color: .white)
                .padding(.horizontal, 16)
                .padding(.vertical, 20)
            
            ForEach(joys) { joy in
                JoyRowWithButton(title: joy.title) {
                    // 메뉴 버튼 action
                    selectedJoy = joy
                } buttonLabel: {
                    // 메뉴 버튼 이미지
                    Image(systemName: "ellipsis")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .foregroundStyle(Color.gray500)
                        .padding(10)
                }
                .padding(.leading, 12)
                .padding(.trailing, 15)
                .padding(.vertical, 4)
            }
        }
        .padding(.bottom, 20)
        .background(Color.madiiBox)
        .cornerRadius(20)
    }
}

#Preview {
    MyJoyView()
}
