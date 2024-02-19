//
//  RecommendJoyListView.swift
//  Madii
//
//  Created by 정태우 on 2/18/24.
//

import SwiftUI

struct RecommendJoyListView: View {
    @State private var selectedIdx: Int?
    @Binding var recommendJoys: [GetJoyResponseJoy]
    @State private var selectedJoy: GetJoyResponseJoy?
    @Binding var isClicked: [Bool]
    var body: some View {
        VStack(spacing: 12) {
            if recommendJoys.isEmpty {
                ForEach(1...3, id: \.self) {_ in
                    HStack(spacing: 0) {
                        Circle()
                            .foregroundColor(.gray300)
                            .frame(width: 56, height: 56)
                            .padding(.trailing, 15)
                        Rectangle()
                            .foregroundColor(.gray300)
                            .frame(width: 172, height: 20)
                        Spacer()
                        Image(systemName: "ellipsis")
                    }
                    .padding(20)
                    .background(Color.madiiBox)
                    .cornerRadius(20)
                    .opacity(0.4)
                }
            } else {
                ForEach(recommendJoys) { joy in
                    Button {
                        if selectedIdx == joy.joyId {
                            selectedIdx = nil
                        } else {
                            selectedIdx = joy.id
                        }
                    } label: {
                        HStack(spacing: 0) {
                            Image("")
                                .resizable()
                                .frame(width: 56, height: 56)
                                .background(Color.black)
                                .cornerRadius(90)
                                .padding(.trailing, 15)
                            
                            Text(joy.contents)
                                .madiiFont(font: .madiiBody3, color: .white)
                                .multilineTextAlignment(.leading)
                            
                            Spacer()
                            
                            Button {
                                selectedJoy = joy
                            } label: {
                                VStack {
                                    Image(systemName: "ellipsis")
                                }
                                .frame(width: 40, height: 40)
                            }
                        }
                        .roundBackground()
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .inset(by: 0)
                                .stroke(joy.joyId == selectedIdx ? Color.madiiYellowGreen : Color.clear, lineWidth: 2)
                        )
                    }
                }
//                .sheet(item: $selectedJoy) { item in
//                    JoyMenuBottomSheet(joy: item, isMine: true) }
            }
            Spacer()
            NavigationLink {
                
            } label: {
                StyleJoyNextButton(label: "완료", isDisabled: isClicked.contains(true))
            }
        }
    }
}

#Preview {
    RecommendJoyListView(recommendJoys: .constant([]), isClicked: .constant(Array(repeating: false, count: 9)))
}
