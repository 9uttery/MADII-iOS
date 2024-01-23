//
//  MyJoyView.swift
//  Madii
//
//  Created by 이안진 on 12/1/23.
//

import SwiftUI

struct MyJoyView: View {
    @State private var allJoys: [MyJoy] = MyJoy.dummys
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // (박스) 모든 날짜
                ForEach(allJoys) { eachDayJoy in
                    joyBoxByDate(eachDayJoy.date, joys: eachDayJoy.joys)
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
                JoyRowWithButton(title: joy.title, buttonAction: showBottomSheet) {
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
    
    private func showBottomSheet() {
        
    }
}

#Preview {
    MyJoyView()
}
