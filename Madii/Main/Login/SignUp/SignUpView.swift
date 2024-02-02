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
}

struct SignUpView: View {
    @EnvironmentObject private var pathStatus: PathStatus
    @StateObject var signUpStatus = SignUpStatus()
    
    var body: some View {
        ZStack(alignment: .top) {
            HStack(spacing: 12) {
                if signUpStatus.count != 0 {
                    Button {
                        signUpStatus.count -= 1
                    } label: {
                        Image(systemName: "chevron.left")
                            .frame(width: 10, height: 16)
                            .foregroundStyle(Color.white)
                            .padding()
                            .frame(width: 20, height: 20)
                            .padding(.horizontal, 20)
                    }
                }
                
                Spacer()
                
                ForEach(0 ..< signUpStatus.allCounts, id: \.self) { index in
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundStyle(index == signUpStatus.count ? Color.white : Color.gray700)
                }
            }
            .frame(height: 60)
            .padding(.trailing, 28)
            
            if signUpStatus.count == 0 {
                ServiceTermsView()
                    .padding(.top, 94)
            } else if signUpStatus.count == 1 {
                IDView()
                    .padding(.top, 94)
            } else {
                PasswordView()
            }
        }
        .environmentObject(signUpStatus)
        .onAppear {
            print("path는 \(pathStatus.path)")
        }
    }
}

#Preview {
    SignUpView()
}
