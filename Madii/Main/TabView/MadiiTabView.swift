//
//  MadiiTabView.swift
//  Madii
//
//  Created by 이안진 on 11/29/23.
//

import Combine
import SwiftUI

struct MadiiTabView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var showPlaylist: Bool = false
    
    @State var tabIndex: TabIndex = .record
    
    @State private var isKeyboardVisible = false

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                switch tabIndex {
                case .home: HomeView()
                case .record: RecordView()
                case .calendar: CalendarView()
                }
            }
            .padding(.bottom, isKeyboardVisible ? 0 : 120)
            .onReceive(Publishers.keyboardHeight) { keyboardHeight in
                self.isKeyboardVisible = keyboardHeight > 0
            }
            
            VStack(spacing: 0) {
                Spacer()
                
                Button {
                    showPlaylist = true
                } label: {
                    PlaylistBar()
                        .background(Color.black)
                        .frame(height: 60)
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
                
                MadiiTabBar(tabIndex: $tabIndex)
                    .frame(height: 60)
            }
            .ignoresSafeArea(.keyboard)
        }
    }
}

#Preview {
    MadiiTabView()
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
