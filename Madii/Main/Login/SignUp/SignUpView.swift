//
//  SignUpView.swift
//  Madii
//
//  Created by 이안진 on 1/29/24.
//

import SwiftUI

class SignUpStatus: ObservableObject {
    @Published var allCounts: Int = 4
    @Published var count: Int = 0
    
    @Published var id: String = ""
    @Published var password: String = ""
    @Published var marketingAgreed: Bool = false
}

enum LoginType { case kakao, apple, id }

struct SignUpView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var signUpStatus = SignUpStatus()
    let from: LoginType    
    
    var body: some View {
        ZStack(alignment: .top) {
            ZStack {
                HStack(spacing: 12) {
                    Button {
                        if signUpStatus.count == 0 {
                            dismiss()
                        } else {
                            signUpStatus.count -= 1
                        }
                    } label: {
                        Image(systemName: "chevron.left")
                            .frame(width: 10, height: 16)
                            .foregroundStyle(Color.white)
                            .padding()
                            .frame(width: 20, height: 20)
                            .padding(.horizontal, 20)
                    }
                    
                    Spacer()
                    
                    ForEach(0 ..< signUpStatus.allCounts, id: \.self) { index in
                        Circle()
                            .frame(width: 8, height: 8)
                            .foregroundStyle(index == signUpStatus.count ? Color.white : Color.gray700)
                    }
                }
                
                if signUpStatus.count == 3 {
                    Text("프로필")
                        .madiiFont(font: .madiiBody2, color: .white)
                }
            }
            .frame(height: 60)
            .padding(.trailing, 28)
            
            if signUpStatus.count == 0 {
                ServiceTermsView(from: from)
                    .padding(.top, 94)
            } else if signUpStatus.count == 1 {
                IDView()
                    .padding(.top, 94)
            } else if signUpStatus.count == 2 {
                PasswordView()
            } else {
                AddProfileView()
                    .padding(.top, 94)
            }
        }
        .environmentObject(signUpStatus)
        .onAppear {
            signUpStatus.allCounts = from == .id ? 4 : 2
        }
    }
}
