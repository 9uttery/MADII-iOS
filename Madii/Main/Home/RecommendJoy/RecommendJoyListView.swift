//
//  RecommendJoyListView.swift
//  Madii
//
//  Created by 정태우 on 2/18/24.
//

import SwiftUI

struct RecommendJoyListView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedIdx: Int?
    @Binding var recommendJoys: [GetJoyResponseJoy]
    @Binding var selectedJoy: GetJoyResponseJoy?
    @State var selectedJoyEllipsis: Joy?
    @Binding var isClicked: [Bool]
    @State var isActive: Bool = false
    @State var nickname: String
    @Binding var clickedNum: Int
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
                            selectedJoy = nil
                        } else {
                            selectedIdx = joy.id
                            selectedJoy = joy
                        }
                    } label: {
                        HStack(spacing: 0) {
                            ZStack {
                                Color.black
                                    .frame(width: 56, height: 56)
                                    .cornerRadius(90)
                                
                                Image("icon_\(joy.joyIconNum)")
                                    .resizable()
                                    .frame(width: 34, height: 34)
                            }
                            .padding(.trailing, 15)
                            Text(joy.contents)
                                .madiiFont(font: .madiiBody3, color: .white)
                                .multilineTextAlignment(.leading)
                            
                            Spacer()
                            
                            Button {
                                selectedJoyEllipsis = Joy(joyId: joy.joyId, title: joy.contents)
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
            }
            
            Spacer()
            
            NavigationLink {
                RecommendJoyView(nickname: nickname, recommendJoy: selectedJoy ?? GetJoyResponseJoy(joyId: 0, joyIconNum: 1, contents: "넷플릭스 헬로"), isActive: $isActive)
            } label: {
                if selectedJoy != nil {
                    StyleJoyNextButton(label: "완료", isDisabled: true)
                } else {
                    StyleJoyNextButton(label: "완료", isDisabled: false)
                }
            }
            .disabled(selectedJoy != nil ? false : true)
        }
        .sheet(item: $selectedJoyEllipsis) { _ in
            JoyMenuBottomSheet(joy: $selectedJoyEllipsis, isMine: false, isFromTodayJoy: true)
        }
        .onAppear {
            if isActive {
                withoutAnimation {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}

#Preview {
    RecommendJoyListView(recommendJoys: .constant([]), selectedJoy: .constant(nil), isClicked: .constant(Array(repeating: false, count: 9)), nickname: "코코", clickedNum: .constant(0))
}
