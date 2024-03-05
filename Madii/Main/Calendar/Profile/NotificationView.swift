//
//  NotificationView.swift
//  Madii
//
//  Created by 정태우 on 3/1/24.
//

import SwiftUI

struct Notifications: Identifiable {
    let id = UUID()
    let title: String
    let contents: String
    let createdAt: String
}

struct NotificationView: View {
    @State private var notifications: [Notifications] = []
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 12) {
                ForEach(notifications) { notification in
                    VStack(alignment: .leading) {
                        HStack {
                            Text(notification.title)
                                .madiiFont(font: .madiiSubTitle, color: .white)
                                .padding(.bottom, 20)
                            
                            Spacer()
                        }
                        .padding(.leading, 2)
                        
                        Text(notification.contents)
                            .madiiFont(font: .madiiBody3, color: .gray400)
                            .padding(.bottom, 12)
                        
                        Text(notification.createdAt)
                            .madiiFont(font: .madiiBody3, color: .gray700)
                            .padding(.bottom, 12)
                    }
                    .padding(20)
                    .background(Color.madiiBox)
                    .cornerRadius(20)
                }
                
                Spacer()
            }
        }
        .padding(.top, 28)
        .padding(.horizontal, 16)
        .navigationTitle("알림")
        .toolbarBackground(Color.madiiBox, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .onAppear { getNotification() }
    }
    
    private func getNotification() {
        ProfileAPI.shared.getNotification { isSuccess, notification in
            if isSuccess {
                self.notifications = []
                for notific in notification {
                    let newNotice = Notifications(title: notific.title, contents: notific.contents, createdAt: notific.createdAt)
                    self.notifications.append(newNotice)
                }
            }
        }
    }
}

#Preview {
    NotificationView()
}
