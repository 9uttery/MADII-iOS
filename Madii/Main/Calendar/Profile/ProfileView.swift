//
//  ProfileView.swift
//  Madii
//
//  Created by 정태우 on 1/25/24.
//

import SwiftUI

struct ProfileView: View {
    @State var name: String = ""
    @State var url: String = ""
    @State var showLogOutPopUp: Bool = false
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 18) {
                NavigationLink { MyProfileView(url: $url, nickname: name) } label: { userInfoRow }
                    .background(Color.madiiBox)
                    .cornerRadius(20)
                
                VStack(spacing: 4) {
                    NavigationLink { NotificationView() } label: { profileRow(title: "알림") }
                        .navigationBarTitle("")
                    
                    NavigationLink { NoticeView() } label: { profileRow(title: "공지사항") }
                        .navigationBarTitle("")
                    
                    NavigationLink { InquiryView() } label: { profileRow(title: "문의하기") }
                        .navigationBarTitle("")
                }
                .padding(.vertical, 4)
                .background(Color.madiiBox)
                .cornerRadius(20)
                
                VStack(spacing: 10) {
                    Button { showLogOutPopUp = true } label: { profileRow(title: "로그아웃") }
                        .navigationBarTitle("")
                    
                    NavigationLink { SignOutView() } label: { profileRow(title: "회원탈퇴") }
                        .navigationBarTitle("")
                }
                .padding(.vertical, 4)
                .background(Color.madiiBox)
                .cornerRadius(20)
                
                Spacer()
            }
            .padding(.top, 28)
            .padding(.horizontal, 16)
            
            if showLogOutPopUp { LogOutPopUpView(showLogOutPopUp: $showLogOutPopUp) }
        }
        .navigationTitle("마이페이지")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color.madiiBox, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .onAppear { getUser() }
    }
    
    private var userInfoRow: some View {
        HStack(spacing: 12) {
            AsyncImage(url: URL(string: url)) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
            } placeholder: {
                Image("defaultProfile")
                    .resizable()
                    .frame(width: 40, height: 40)
            }

            Text(name)
                .madiiFont(font: .madiiSubTitle, color: .white)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray500)
                .imageScale(.small)
        }
        .padding(16)
        .padding(.leading, 6)
    }
    
    @ViewBuilder
    private func profileRow(title: String) -> some View {
        HStack {
            Text(title)
                .madiiFont(font: .madiiBody3, color: .white)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray500)
                .imageScale(.small)
        }
        .padding(16)
        .padding(.leading, 6)
    }
    
    private func getUser() {
        ProfileAPI.shared.getUsersProfile { isSuccess, userProfile in
            if isSuccess {
                name = userProfile.nickname
                url = userProfile.image
            } else {
                print("DEBUG ProfileView isSuccess false")
            }
        }
    }
}

#Preview {
    ProfileView()
}
