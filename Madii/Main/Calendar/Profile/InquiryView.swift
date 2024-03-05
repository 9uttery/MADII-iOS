//
//  InquiryView.swift
//  Madii
//
//  Created by 정태우 on 1/26/24.
//

import MessageUI
import SwiftUI

struct InquiryView: View {
    @State private var isShowingMailView = false
    @State private var result: Result<MFMailComposeResult, Error>? = nil
    var body: some View {
        VStack {
            Button {
                isShowingMailView.toggle()
            } label: {
                Image("MailArrow")
                    .resizable()
                    .frame(width: 111, height: 85)
                    .padding(.bottom, 32)
            }
            .sheet(isPresented: $isShowingMailView) {
                MailView(isShowing: $isShowingMailView, result: $result)
            }
            Text("madii.service.cs@gmail.com로 문의해주세요")
        }
        .navigationTitle("문의하기")
        .toolbarBackground(Color.madiiBox, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

#Preview {
    InquiryView()
}
