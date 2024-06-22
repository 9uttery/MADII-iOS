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
    @State private var notices: [Notice] = []
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 12) {
                if notices.isEmpty {
                    Image("EmptyNotice")
                        .padding(.top, 130)
                } else {
                    ForEach(notices) { notice in
                        VStack(alignment: .leading) {
                            HStack {
                                Text(notice.title)
                                    .madiiFont(font: .madiiSubTitle, color: .white)
                                    .padding(.bottom, 20)
                                
                                Spacer()
                            }
                            .padding(.leading, 2)
                            
                            Text(notice.content)
                                .madiiFont(font: .madiiBody3, color: .gray400)
                                .padding(.bottom, 12)
                            
                            Text(notice.date)
                                .madiiFont(font: .madiiBody3, color: .gray700)
                                .padding(.bottom, 12)
                        }
                        .padding(20)
                        .background(Color.madiiBox)
                        .cornerRadius(20)
                    }
                }
                
                Spacer()
            }
        }
        .padding(.top, 28)
        .padding(.horizontal, 16)
        .navigationTitle("공지사항")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color.madiiBox, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .onAppear { getNotices() }
        .analyticsScreen(name: "공지사항뷰")
    }
    
    private func getNotices() {
        ProfileAPI.shared.getNotice { isSuccess, notices in
            if isSuccess {
                self.notices = []
                for notice in notices {
                    let newNotice = Notice(title: notice.title, content: notice.contents, date: notice.createdAt)
                    self.notices.append(newNotice)
                }
            } else {
                print("DEBUG NoticeView isSuccess false")
            }
        }
    }
}

#Preview {
    NoticeView()
}
