//
//  UserAnalyticsView.swift
//  Madii
//
//  Created by 이안진 on 12/1/23.
//

import SwiftUI

enum UserAnalyticsType { case recent, many, myJoy }

struct UserAnalyticsContent: Identifiable {
    let id = UUID()
    let type: UserAnalyticsType
    let title, image: String
    let imageColor: Color
}

struct UserAnalyticsView: View {
    private let contents: [UserAnalyticsContent] = [
        UserAnalyticsContent(type: .recent, title: "최근 본 앨범",
                             image: "clock.arrow.circlepath", imageColor: Color.madiiPurple),
        UserAnalyticsContent(type: .many, title: "많이 실천한 소확행",
                             image: "trophy.fill", imageColor: Color.madiiOrange),
        UserAnalyticsContent(type: .myJoy, title: "내가 기록한 소확행",
                             image: "note.text", imageColor: Color.madiiPink)]
    
    var body: some View {
        // 최근 본 앨범 & 많이 실천한 소확행 & 내가 기록한 소확행
        HStack(spacing: 12) {
            ForEach(contents) { content in
                NavigationLink {
                    switch content.type {
                    case .recent: RecentAchievedJoyView() // 최근 본 앨범
                    case .many: ManyAchievedJoyView() // 많이 실천한 소확행
                    case .myJoy: RecentAchievedJoyView() // 최근 본 앨범
                    }
                } label: {
                    analyticsBox(title: content.title, image: content.image, color: content.imageColor)
                }
            }
        }
    }
    
    @ViewBuilder
    func analyticsBox(title: String, image: String, color: Color) -> some View {
        VStack(spacing: 8) {
            Image(systemName: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(color)
                .frame(width: 28, height: 28)
            
            HStack {
                Spacer()
                Text(title)
                    .madiiFont(font: .madiiBody4, color: .white)
                Spacer()
            }
        }
        .padding(.vertical, 12)
        .padding(.bottom, 4)
        .background(Color.madiiBox)
        .cornerRadius(12)
    }
}

#Preview {
    MadiiTabView()
}
