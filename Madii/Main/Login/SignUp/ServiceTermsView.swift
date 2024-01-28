//
//  ServiceTermsView.swift
//  Madii
//
//  Created by 이안진 on 1/28/24.
//

import SwiftUI

struct ServiceTermsView: View {
    private let options: [String] = ["서비스 이용약관 (필수)", "개인정보 처리방침 (필수)", "마케팅 수신 동의 (선택)"]
    @State private var status: [Bool] = [false, false, false]
    var allTermsAgreed: Bool { status[0] && status[1] && status[2] }
    var essentialTermsAgreed: Bool { status[0] && status[1] }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("서비스 이용 동의서")
                .madiiFont(font: .madiiTitle, color: .white)
                .padding(.horizontal, 8)
                .padding(.vertical, 10)
                .padding(.bottom, 14)
                
            Button {
                status = status.map { _ in !allTermsAgreed }
            } label: {
                HStack(spacing: 8) {
                    Image(systemName: allTermsAgreed ? "checkmark.circle.fill" : "checkmark.circle")
                        .resizable()
                        .frame(width: 26, height: 26)
                        .padding(2)
                        .foregroundStyle(allTermsAgreed ? Color.madiiYellowGreen : Color.gray200.opacity(0.4))
                    
                    Text("모두 동의하기 (선택 정보 포함)")
                        .madiiFont(font: .madiiBody3, color: .white)
                }
            }
            
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(Color.gray800)
                .padding(.vertical, 20)
                
            VStack(alignment: .leading, spacing: 20) {
                ForEach(0 ..< 3, id: \.self) { index in
                    termRow(of: index)
                }
            }
            
            Spacer()
            
            Button {
                
            } label: {
                MadiiButton(title: "다음", size: .big)
                    .opacity(essentialTermsAgreed ? 1.0 : 0.4)
            }
            .disabled(essentialTermsAgreed == false)
            .padding(.bottom, 24)
        }
        .padding(.horizontal, 18)
    }
    
    @ViewBuilder
    private func termRow(of index: Int) -> some View {
        HStack {
            Button {
                status[index].toggle()
            } label: {
                HStack(spacing: 8) {
                    Image(systemName: "checkmark")
                        .resizable()
                        .frame(width: 12, height: 12)
                        .foregroundStyle(status[index] ? Color.madiiYellowGreen : Color.gray200.opacity(0.4))
                        .padding(8)
                    
                    Text(options[index])
                        .madiiFont(font: .madiiBody3, color: .white)
                }
            }
            
            Spacer()
            
            Button {
                if let url = URL(string: "https://www.naver.com") {
                    UIApplication.shared.open(url)
                }
            } label: {
                Text("보기")
                    .madiiFont(font: .madiiBody4, color: .gray500)
                    .padding(.horizontal, 2)
            }
        }
        .frame(height: 28)
    }
}

#Preview {
    ServiceTermsView()
}
