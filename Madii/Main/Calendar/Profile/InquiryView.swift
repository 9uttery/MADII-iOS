//
//  InquiryView.swift
//  Madii
//
//  Created by 정태우 on 1/26/24.
//

import SwiftUI

struct InquiryView: View {
    var body: some View {
        VStack {
            Image("MailArrow")
                .resizable()
                .frame(width: 111, height: 85)
                .padding(.bottom, 32)
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
