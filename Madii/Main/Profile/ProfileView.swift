//
//  ProfileView.swift
//  Madii
//
//  Created by 정태우 on 1/25/24.
//

import SwiftUI

struct ProfileView: View {
    @State var name: String = "코코"
    @State var showLogOutPopUp: Bool = false
    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 16) {
                NavigationLink {
                    MyProfileView()
                } label: {
                    HStack() {
                        Image("")
                            .resizable()
                            .frame(width: 40, height: 40)
                        Text(name)
                            .madiiFont(font: .madiiSubTitle, color: .white)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray500)
                            .imageScale(.small)
                    }
                    .roundBackground()
                    .padding(.top, 28)
                }
                VStack(spacing: 10) {
                    NavigationLink {
                        
                    } label: {
                        HStack() {
                            Text("알림")
                                .madiiFont(font: .madiiBody3, color: .white)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray500)
                                .imageScale(.small)
                        }
                        .frame(height: 40)
                    }
                    
                    NavigationLink {
                        NoticeView()
                    } label: {
                        HStack() {
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
                        HStack() {
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
                
                VStack(spacing: 10) {
                    Button {
                        showLogOutPopUp = true
                    } label: {
                        HStack() {
                            Text("로그아웃")
                                .madiiFont(font: .madiiBody3, color: .white)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray500)
                                .imageScale(.small)
                        }
                        .frame(height: 40)
                    }
                    
                    NavigationLink {
                        SignOutView()
                    } label: {
                        HStack() {
                            Text("회원탈퇴")
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
            if showLogOutPopUp {
                LogOutPopUpView(showLogOutPopUp: $showLogOutPopUp)
            }
        }
    }
    
}

#Preview {
    ProfileView()
}
