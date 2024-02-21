//
//  MyJoyView.swift
//  Madii
//
//  Created by 이안진 on 12/1/23.
//

import SwiftUI

struct MyJoyView: View {
    @EnvironmentObject private var popUpStatus: PopUpStatus
    @Environment(\.dismiss) private var dismiss
    
    @State private var allJoys: [MyJoy] = []
    @State private var selectedJoy: Joy?

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
                        .sheet(item: $selectedJoy) { _ in
                            JoyMenuBottomSheet(joy: $selectedJoy, isMine: true) }
                    }
                    .padding(.top, 28)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 60)
                }
                .scrollIndicators(.hidden)
            }
        }
        .navigationTitle("내가 기록한 소확행")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear { getJoy() }
        .toolbarBackground(Color.madiiBox, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
    
    private var emptyJoyView: some View {
        VStack(spacing: 60) {
            Spacer()
            
            Image("myJoyEmpty")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 240)
            
            VStack(spacing: 20) {
                Text("아직 기록한 소확행이 없어요")
                    .madiiFont(font: .madiiBody3, color: .gray500)
                    .multilineTextAlignment(.center)
                
                /* 임시 삭제
                Button {
                    popUpStatus.showSaveMyJoyOverlay = true
                    dismiss()
                } label: {
                    Text("소확행 기록하러 가기")
                        .madiiFont(font: .madiiBody2, color: .black)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .background(Color.madiiYellowGreen)
                        .clipShape(RoundedRectangle(cornerRadius: 90))
                }
                 */
            }
            
            Spacer()
            Spacer()
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
                JoyRowWithButton(joy: joy) {
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
                .padding(.trailing, 16)
                .padding(.vertical, 4)
            }
        }
        .padding(.bottom, 20)
        .background(Color.madiiBox)
        .cornerRadius(20)
    }
    
    private func getJoy() {
        RecordAPI.shared.getJoy { isSuccess, joyList in
            if isSuccess {
                allJoys = []
                for date in joyList {
                    var joys: [Joy] = []
                    for joy in date.joyList {
                        let newJoy = Joy(joyId: joy.joyId, icon: joy.joyIconNum, title: joy.contents)
                        joys.append(newJoy)
                    }
                    
                    let newDate = MyJoy(date: date.createdAt, joys: joys)
                    allJoys.append(newDate)
                }
            } else {
                print("DEBUG MyJoyView: isSuccess false")
            }
        }
    }
}

#Preview {
    MyJoyView()
}
