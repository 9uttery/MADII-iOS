//
//  MadiiTabView.swift
//  Madii
//
//  Created by 이안진 on 11/29/23.
//

import Combine
import SwiftUI

struct MadiiTabView: View {
    @State var tabIndex: TabIndex = .home
    @State private var isKeyboardVisible = false
    
    @State private var showPlaylistBar: Bool = false
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
            .padding(.bottom, isKeyboardVisible ? 0 : (showPlaylistBar ? 120 : 60))
            .onReceive(Publishers.keyboardHeight) { keyboardHeight in
                self.isKeyboardVisible = keyboardHeight > 0
            }
            
            VStack(spacing: 0) {
                Spacer()
                
                PlaylistBar(updatePlaylistBar: $updatePlaylistBar, showPlaylistBar: $showPlaylistBar)
                
                MadiiTabBar(tabIndex: $tabIndex)
                    .frame(height: 60)
            }
            .ignoresSafeArea(.keyboard)
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

private extension Notification {
    var keyboardHeight: CGFloat {
        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
    }
}
