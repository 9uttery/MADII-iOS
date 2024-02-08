//
//  NoticeView.swift
//  Madii
//
//  Created by 정태우 on 1/25/24.
//

import SwiftUI

struct Notice: Identifiable {
    let id = UUID()
    let title: String
    let content: String
    let date: String
}

struct NoticeView: View {
    let notices: [Notice] = [
        Notice(title: "공지 제목 1", content: "공지 내용 1", date: "2024-01-25"),
        Notice(title: "공지 제목 2", content: "공지 내용 2", date: "2024-01-26"),
        Notice(title: "공지 제목 3", content: "공지 내용 3", date: "2024-01-27"),
    ]
    var body: some View {
        VStack(spacing: 12) {
            ForEach(notices) { notice in
                VStack(alignment: .leading) {
                    HStack() {
                        Text(notice.title)
                            .madiiFont(font: .madiiSubTitle, color: .white)
                            .padding(.bottom, 20)
                        Spacer()
                    }
                    Text(notice.content)
                        .madiiFont(font: .madiiBody3, color: .gray400)
                        .padding(.bottom, 10)
                    Text(notice.date)
                        .madiiFont(font: .madiiBody3, color: .gray700)
                        .padding(.bottom, 10)
                }
                .roundBackground()
            }
            Spacer()
        }
        .padding(.horizontal, 16)
        .navigationTitle("공지사항")
        .toolbarBackground(Color.madiiBox, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

#Preview {
    NoticeView()
}
