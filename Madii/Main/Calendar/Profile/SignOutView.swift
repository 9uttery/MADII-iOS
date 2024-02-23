//
//  SignOutView.swift
//  Madii
//
//  Created by 정태우 on 1/26/24.
//

import SwiftUI

struct SignOutView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var nickName: String = "에몽"
    @State var days: String = "96"
    @State var joy: String = "32"
    @State var play: String = "231"
    var body: some View {
        GeometryReader { geo in
            TabView {
                VStack {
                    Spacer()
                    Text("1")
                    Spacer()
                    HStack { Spacer() }
                }
                .frame(width: geo.size.height, height: geo.size.width)
                .rotationEffect(.degrees(-90))
                .background(Color.red)
                
                VStack {
                    Spacer()
                    Text("2")
                    Spacer()
                    HStack { Spacer()}
                }
                .rotationEffect(.degrees(-90))
                .background(Color.blue)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .rotationEffect(.degrees(90))
        }
    }
}

#Preview {
    SignOutView()
}

/*
 Text("\(nickName)님은")
     .madiiFont(font: .madiiTitle, color: .white)
 Text("\(days)일동안 일상 속에서")
     .madiiFont(font: .madiiTitle, color: .white)
 Text("\(nickName)개의 소확행을")
     .madiiFont(font: .madiiTitle, color: .white)
 Text("\(nickName)번 재생해왔어요")
     .madiiFont(font: .madiiTitle, color: .white)
 Image("")
     .frame(width: UIScreen.main.bounds.width - 32, height: 395)
     .padding(.bottom, 143)
 Text("정말 마디를 떠나시겠어요?")
     .madiiFont(font: .madiiTitle, color: .white)
 Text("지금 마디를 탈퇴하게 되면")
     .madiiFont(font: .madiiBody3, color: .white)
 Text("모든 데이터와 기록이 사라지고")
     .madiiFont(font: .madiiBody3, color: .white)
 Text("복원되지 않아요")
     .madiiFont(font: .madiiBody3, color: .white)
     .padding(.bottom, 120)
 HStack {
     Button {
         presentationMode.wrappedValue.dismiss()
     } label: {
         Text("네, 탈퇴 할래요")
             .madiiFont(font: .madiiBody2, color: .black)
             .padding(.vertical, 18)
             .frame(maxWidth: .infinity)
             .background(Color.white)
             .cornerRadius(6)
     }
     Button {
         presentationMode.wrappedValue.dismiss()
     } label: {
         Text("아니요, 탈퇴 안 할래요")
             .madiiFont(font: .madiiBody2, color: .black)
             .padding(.vertical, 18)
             .frame(maxWidth: .infinity)
             .background(Color.madiiYellowGreen)
             .cornerRadius(6)
     }
 }
 */
