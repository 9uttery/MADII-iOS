//
//  MyPageView_P3.swift
//  Madii
//
//  Created by Anjin on 9/27/25.
//

import SwiftUI

struct MyPageView_P3: View {
    @Environment(Router.self) var router
    
    var body: some View {
        VStack {
            navigationBar
            
            VStack(spacing: 20) {
                ProfileRow()
                    .clipShape(RoundedRectangle(cornerRadius: 32))
                
                VStack(spacing: 4) {
                    row("알림")
                    row("공지사항")
                    row("문의하기")
                }
                .padding(.vertical, 8)
                .background(Color.madiiElevated)
                .clipShape(RoundedRectangle(cornerRadius: 32))
                
                VStack(spacing: 4) {
                    row("로그아웃")
                    row("회원탈퇴")
                }
                .padding(.vertical, 8)
                .background(Color.madiiElevated)
                .clipShape(RoundedRectangle(cornerRadius: 32))
            }
            .padding(20)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color.madiiDefault)
    }
    
    private var navigationBar: some View {
        ZStack {
            Text("마이페이지")
                .madiiFont(.subTitle)
                .frame(maxWidth: .infinity)
            
            HStack {
                Button {
                    router.pop()
                } label: {
                    Image(.arrowBack)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .colorMultiply(.madiiAlternative)
                }
                
                Spacer()
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
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
                
            Text(nickname)
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
