//
//  MyJoyView.swift
//  Madii
//
//  Created by 이안진 on 12/1/23.
//

import SwiftUI

struct MyJoyView: View {
    @State private var allJoys: [MyJoy] = MyJoy.dummys
    @State private var selectedJoy: Joy?
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(allJoys) { eachDayJoy in
                    // 날짜별 소확행 박스
                    joyBoxByDate(eachDayJoy.date, joys: eachDayJoy.joys)
                }
                .sheet(item: $selectedJoy) { item in
                    Text(item.title)
                        .presentationDetents([.medium])
                }
            }
            .padding(.top, 28)
            .padding(.horizontal, 16)
            .padding(.bottom, 60)
        }
        .scrollIndicators(.hidden)
        .navigationTitle("내가 기록한 소확행")
        .toolbarBackground(Color.madiiBox, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
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
