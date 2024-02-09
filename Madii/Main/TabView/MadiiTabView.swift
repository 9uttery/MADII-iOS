//
//  MadiiTabView.swift
//  Madii
//
//  Created by 이안진 on 11/29/23.
//

import SwiftUI

struct MadiiTabView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var showPlaylist: Bool = false
    
    @State var tabIndex: TabIndex = .record
    @StateObject private var tabBarManager = TabBarManager()
    @StateObject private var popUpStatus = PopUpStatus()

    var body: some View {
        VStack(spacing: 0) {
            switch tabIndex {
            case .home: HomeView()
            case .record: RecordView()
            case .calendar: CalendarView()
            }
            
            Button {
                showPlaylist = true
            } label: {
                PlaylistBar()
            }
            .fullScreenCover(isPresented: $showPlaylist, content: {
                ZStack {
                    Color.red
                    
                    Button {
                        showPlaylist = false
                    } label: {
                        Text("dismiss")
                    }
                }
                .gesture(
                    DragGesture().onEnded { value in
                        if value.location.y - value.startLocation.y > 150 {
                            /// Use presentationMode.wrappedValue.dismiss() for iOS 14 and below
                            showPlaylist = false
                        }
                    }
                )
            })
            
            if tabBarManager.isTabBarShown {
                MadiiTabBar(tabIndex: $tabIndex)
            }
        }
        .environmentObject(tabBarManager)
        .environmentObject(popUpStatus)
        .onAppear {
            tabBarManager.isTabBarShown = true
            checkIsTabBarShown()
        }
    }

    func checkIsTabBarShown() {
        // 키보드가 올라오면 함께 올라오는 문제 해결을 위해
        // 키보드가 없을 때만 나타나도록 구현

        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { _ in
            tabBarManager.isTabBarShown = false
        }

        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
            tabBarManager.isTabBarShown = true
        }
    }
}

#Preview {
    MadiiTabView()
}
