//
//  TodayPlayListJoyView.swift
//  Madii
//
//  Created by 정태우 on 1/31/24.
//

import SwiftUI

struct TodayPlayListJoyView: View {
    @State var joyTodayPlayList: [Joy] = Joy.todayPlayListDummy
    @State var selectedJoy: Joy?
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("2024.01.14")
                .madiiFont(font: .madiiSubTitle, color: .white)
                .padding(.bottom, 11.5)
            
            List {
                ForEach(joyTodayPlayList.indices, id: \.self) { index in
                    let joy = joyTodayPlayList[index]
                    HStack {
                        Image("")
                            .resizable()
                            .frame(width: 48, height: 48)
                            .cornerRadius(90)
                            .padding(.trailing, 14.5)
                        Text(joy.title)
                            .madiiFont(font: .madiiBody3, color: .white)
                        Spacer()
                        Button {
                            if !joyTodayPlayList[index].isCompleted {
                                selectedJoy = joy
                            }
                            joyTodayPlayList[index].isCompleted.toggle()
                        } label: {
                            if joy.isCompleted {
                                Image("check")
                                    .resizable()
                                    .frame(width: 28, height: 28)
                            } else {
                                Image("unCheck")
                                    .resizable()
                                    .frame(width: 28, height: 28)
                            }
                        }
                    }
                    .sheet(item: $selectedJoy) { item in
                        JoySatisfactionBottomSheet(joy: item)
                            .presentationDetents([.height(300)])
                            .presentationDragIndicator(.hidden)
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.madiiBox)
                }
                .onDelete(perform: { indexSet in
                    joyTodayPlayList.remove(atOffsets: indexSet)
                })
            }
            .frame(width: UIScreen.main.bounds.width - 40, height: CGFloat(joyTodayPlayList.count) * 56 + 40)
            .padding(0)
            .scrollIndicators(.hidden)
            .listStyle(PlainListStyle())
        }
        .roundBackground()
    }
}

#Preview {
    TodayPlayListJoyView()
}
