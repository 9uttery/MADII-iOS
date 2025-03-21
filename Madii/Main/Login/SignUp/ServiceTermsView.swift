//
//  ServiceTermsView.swift
//  Madii
//
//  Created by 이안진 on 1/28/24.
//

import SwiftUI

struct ServiceTermsView: View {
    let from: LoginType
    @EnvironmentObject private var signUpStatus: SignUpStatus
    
    private let options: [String] = ["서비스 이용약관 동의", "개인정보 처리방침 동의", "마케팅 수신 동의 (선택)"]
    private let urls: [String] = ["https://docs.google.com/document/d/e/2PACX-1vRFuhWLyIE43X99pvLCJfdD9FEkyWDqW34pgA6YiRvGaVyoJo48WR2EBZeTK4T9Rcq7-7m71BJUeuSF/pub", "https://docs.google.com/document/d/e/2PACX-1vTUyhxvK17s7JMJFZcKgOe6JJxLXgzeBSdY16EzglDNmb2YanuaNWC2A_jPhrOXT8Z-FkqAHPFsBqiZ/pub"]
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
                AnalyticsManager.shared.logEvent(name: "서비스이용약관뷰_전체동의클릭")
            } label: {
                HStack(spacing: 8) {
                    Image(systemName: allTermsAgreed ? "checkmark.circle.fill" : "checkmark.circle")
                        .resizable()
                        .frame(width: 26, height: 26)
                        .padding(2)
                        .foregroundStyle(allTermsAgreed ? Color.madiiYellowGreen : Color.gray200.opacity(0.4))
                    
                    Text("전체 동의")
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
                // 마케팅 수신 동의 여부 저장
                signUpStatus.marketingAgreed = status[2]
                
                if from == .id {
                    signUpStatus.count += 1
                } else {
                    signUpStatus.count = 3
                }
                AnalyticsManager.shared.logEvent(name: "서비스이용약관뷰_다음클릭")
            } label: {
                MadiiButton(title: "다음", size: .big)
                    .opacity(essentialTermsAgreed ? 1.0 : 0.4)
            }
            .disabled(essentialTermsAgreed == false)
            .padding(.bottom, 24)
        }
        .padding(.horizontal, 18)
        .analyticsScreen(name: "서비스이용약관뷰")
    }
    
    @ViewBuilder
    private func termRow(of index: Int) -> some View {
        HStack {
            Button {
                status[index].toggle()
                AnalyticsManager.shared.logEvent(name: "서비스이용약관뷰_\(options[index])클릭")
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
            
            if index != 2 {
                Button {
                    if let url = URL(string: urls[index]) {
                        UIApplication.shared.open(url)
                    }
                    AnalyticsManager.shared.logEvent(name: "서비스이용약관뷰_\(options[index])보기클릭")
                } label: {
                    Text("보기")
                        .madiiFont(font: .madiiBody4, color: .gray500)
                        .padding(.horizontal, 2)
                }
            }
        }
        .frame(height: 28)
    }
}
