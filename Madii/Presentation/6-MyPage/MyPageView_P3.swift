//
//  MyPageView_P3.swift
//  Madii
//
//  Created by Anjin on 9/27/25.
//

import SwiftUI

struct MyPageView_P3: View {
    @Environment(Router.self) var router
    @State private var showLogoutSheet: Bool = false
    
    var body: some View {
        ZStack {
            Color.madiiDefault.ignoresSafeArea()
            
            VStack {
                MyPageNavigationBar(title: "마이페이지")
                
                VStack(spacing: 20) {
                    Button {
                        router.push(.profile)
                    } label: {
                        ProfileRow()
                            .clipShape(RoundedRectangle(cornerRadius: 32))
                    }
                    
                    VStack(spacing: 4) {
                        Button {
                            router.push(.notification)
                        } label: {
                            row("알림")
                        }
                        
                        Button {
                            router.push(.notice)
                        } label: {
                            row("공지사항")
                        }
                        
                        Button {
                            router.push(.inquiry)
                        } label: {
                            row("문의하기")
                        }
                    }
                    .padding(.vertical, 8)
                    .background(Color.madiiElevated)
                    .clipShape(RoundedRectangle(cornerRadius: 32))
                    
                    VStack(spacing: 4) {
                        Button {
                            withAnimation {
                                showLogoutSheet = true
                            }
                        } label: {
                            row("로그아웃")
                        }
                        
                        Button {
                            router.push(.signOut)
                        } label: {
                            row("회원탈퇴")
                        }
                    }
                    .padding(.vertical, 8)
                    .background(Color.madiiElevated)
                    .clipShape(RoundedRectangle(cornerRadius: 32))
                    
                    // 현재 버전
                    CurrentVersionView()
                }
                .padding(20)
                
                Spacer()
            }
            
            if showLogoutSheet {
                Color.black.opacity(0.8)
                    .onTapGesture {
                        withoutAnimation {
                            showLogoutSheet = false
                        }
                    }
                
                VStack {
                    Spacer()
                    
                    LogoutSheet_P3(showLogoutSheet: $showLogoutSheet)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 40)
                }
                .ignoresSafeArea()
                .transition(.move(edge: .bottom))
            }
        }
    }
    
    @ViewBuilder
    private func row(_ title: String) -> some View {
        HStack {
            Text(title)
                .madiiFont(.subTitle)
                .foregroundStyle(Color.madiiNormal)
            
            Spacer()
            
            Image(.arrowForward)
                .resizable()
                .frame(width: 24, height: 24)
        }
        .padding(.leading, 22)
        .padding(.trailing, 17)
        .padding(.vertical, 16)
        .frame(maxHeight: 58)
    }
}

private struct ProfileRow: View {
    @State private var image = UIImage(named: "defaultProfile") ?? UIImage()
    @State private var url: String = ""
    @State private var nickname: String = ""
    
    var body: some View {
        HStack(spacing: 12) {
            if image == UIImage(named: "defaultProfile") {
                AsyncImage(url: URL(string: url)) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                } placeholder: {
                    Image("defaultProfile")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                }
            } else {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 140, height: 140)
                    .clipShape(Circle())
            }
                
            Text("\(nickname)")
                .madiiFont(.subTitle)
                .foregroundStyle(Color.madiiNormal)
            
            Spacer()
            
            Image(.arrowForward)
                .resizable()
                .frame(width: 24, height: 24)
        }
        .padding(.leading, 22)
        .padding(.trailing, 17)
        .padding(.vertical, 16)
        .frame(maxHeight: 72)
        .background(Color.madiiElevated)
        .onAppear { getUser() }
    }
    
    private func getUser() {
        ProfileAPI.shared.getUsersProfile { isSuccess, userProfile in
            if isSuccess {
                nickname = userProfile.nickname
                url = userProfile.image
            } else {
                print("DEBUG ProfileView isSuccess false")
            }
        }
    }
}
