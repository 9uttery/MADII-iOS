//
//  NotificationView_P3.swift
//  Madii
//
//  Created by Anjin on 10/27/25.
//

import SwiftUI

struct NotificationView_P3: View {
    @State private var notifications: [Notifications] = []
    
    var body: some View {
        ZStack {
            Color.madiiDefault.ignoresSafeArea()
            
            VStack(spacing: 0) {
                MyPageNavigationBar(title: "알림")
                
                if notifications.isEmpty {
                    VStack {
                        Spacer()
                        
                        Image(.noticeBackground)
                            .resizable()
                            .frame(width: 120, height: 120)
                        
                        Spacer()
                    }
                } else {
                    ScrollView {
                        VStack(spacing: 12) {
                            ForEach(notifications) { noti in
                                notificationRow(noti)
                            }
                        }
                        .padding(20)
                    }
                    .scrollIndicators(.hidden)
                }
            }
        }
        .onAppear { getNotification() }
    }
    
    private func notificationRow(_ noti: Notifications) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(noti.title)
                .madiiFont(.body2)
                .foregroundStyle(Color.madiiNormal)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(noti.contents)
                .madiiFont(.body3)
                .foregroundStyle(Color.madiiNeutral)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(noti.createdAt)
                .madiiFont(.caption)
                .foregroundStyle(Color.madiiAlternative)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.leading, 20)
        .padding(.trailing, 17)
        .padding(.vertical, 16)
        .background(Color.madiiElevated)
        .clipShape(RoundedRectangle(cornerRadius: 32))
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
    NotificationView_P3()
}
