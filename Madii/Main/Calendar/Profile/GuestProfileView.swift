//
//  GuestProfileView.swift
//  Madii
//
//  Created by 정태우 on 1/26/24.
//

import SwiftUI

struct GuestProfileView: View {
    var body: some View {
        VStack(spacing: 9) {
            VStack(alignment: .leading) {
                Text("회원가입하고 나만의 소확행을 재생해요")
                    .madiiFont(font: .madiiBody1, color: .white)
                Text("다른 기기와 연동해서 사용할 수 있어요")
                    .madiiFont(font: .madiiBody4, color: .gray400)
                NavigationLink {
                    LoginView()
                } label: {
                    HStack {
                        Spacer()
                        Text("회원가입하기 →")
                            .madiiFont(font: .madiiBody1, color: .black)
                            .padding(.vertical, 16.5)
                        Spacer()
                    }
                    .background(Color.madiiYellowGreen)
                    .cornerRadius(90)
                }
            }
            .roundBackground()
            .padding(.top, 28)
            VStack(spacing: 10) {
                NavigationLink {
                    NoticeView()
                } label: {
                    HStack {
                        Text("공지사항")
                            .madiiFont(font: .madiiBody3, color: .white)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray500)
                            .imageScale(.small)
                    }
                    .frame(height: 40)
                }
                
                NavigationLink {
                    InquiryView()
                } label: {
                    HStack {
                        Text("문의하기")
                            .madiiFont(font: .madiiBody3, color: .white)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray500)
                            .imageScale(.small)
                    }
                    .frame(height: 40)
                }
            }
            .roundBackground()
            Spacer()
        }
        .navigationTitle("마이페이지")
        .toolbarBackground(Color.madiiBox, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

#Preview {
    GuestProfileView()
}
