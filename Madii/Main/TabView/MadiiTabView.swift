//
//  MadiiTabView.swift
//  Madii
//
//  Created by 이안진 on 11/29/23.
//

import Combine
import SwiftUI

struct MadiiTabView: View {
    @EnvironmentObject var appStatus: AppStatus
    
    @State var tabIndex: TabIndex = .home
    @State private var isKeyboardVisible = false
    
    @State private var showPlaylistBar: Bool = true
    @State private var updatePlaylistBar: Bool = false

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                switch tabIndex {
                case .home: HomeView(updatePlaylistBar: $updatePlaylistBar)
                case .record: RecordView()
                case .calendar: CalendarView()
                }
            }
            .padding(.bottom, showPlaylistBar ? 120 : 60)
            .onReceive(Publishers.keyboardHeight) { keyboardHeight in
                self.isKeyboardVisible = keyboardHeight > 0
            }
            
            VStack(spacing: 0) {
                Spacer()
                
                // 신고 완료 토스트
                if appStatus.showReportToast { ReportAlbumToast() }
                
                if showPlaylistBar {
                    PlaylistBar(updatePlaylistBar: $updatePlaylistBar, showPlaylistBar: $showPlaylistBar)
                }
                
                MadiiTabBar(tabIndex: $tabIndex)
                    .frame(height: 60)
            }
            .ignoresSafeArea(.keyboard)
            
            NavigationLink(
                destination: RecommendView(),
                isActive: $appStatus.isNaviRecommend
            ) {
                EmptyView() // 자동으로 화면 전환을 트리거하는 빈 뷰
            }
            
            NavigationLink(
                destination: HomePlayJoyListView(),
                isActive: $appStatus.isNaviPlayJoy
            ) {
                EmptyView() // 자동으로 화면 전환을 트리거하는 빈 뷰
            }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .onChange(of: tabIndex) { newValue in
            if newValue == .calendar {
                showPlaylistBar = false
            } else {
                showPlaylistBar = true
            }
        }
    }
}

extension Publishers {
    static var keyboardHeight: AnyPublisher<CGFloat, Never> {
        let willShow = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .map { $0.keyboardHeight }
        
        let willHide = NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }
        
        return MergeMany(willShow, willHide)
            .eraseToAnyPublisher()
    }
}

extension Notification {
    var keyboardHeight: CGFloat {
        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
    }
}
