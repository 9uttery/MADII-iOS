//
//  InquiryView_P3.swift
//  Madii
//
//  Created by Anjin on 10/27/25.
//

import MessageUI
import SwiftUI

struct InquiryView_P3: View {
    @State private var isShowingMailView = false
    @State private var result: Result<MFMailComposeResult, Error>? = nil
    
    var body: some View {
        ZStack {
            Color.madiiDefault.ignoresSafeArea()
            
            VStack(spacing: 240) {
                MyPageNavigationBar(title: "문의하기")
                
                VStack {
                    Image("MailArrow")
                        .resizable()
                        .frame(width: 111, height: 85)
                        .padding(.bottom, 32)
                    
                    (Text("madii.service.cs@gmail.com")
                        .underline()
                    + Text("로\n문의해 주세요"))
                        .multilineTextAlignment(.center)
                }
                
                Spacer()
            }
        }
        .onAppear {
            if MFMailComposeViewController.canSendMail() {
                isShowingMailView = true
            }
        }
        .sheet(isPresented: $isShowingMailView) {
            MailView(isShowing: $isShowingMailView, result: $result)
        }
    }
}
