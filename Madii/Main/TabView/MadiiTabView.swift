//
//  MadiiTabView.swift
//  Madii
//
//  Created by 이안진 on 11/29/23.
//

import SwiftUI

struct MadiiTabView: View {
    @State var tabIndex: TabIndex = .record
    @State var isKeyboardShown: Bool = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                switch tabIndex {
                case .home: HomeView().padding(.bottom, 60)
                case .record: RecordView()
                case .calendar: CalendarView().padding(.bottom, 60)
                }

                // 키보드가 올라오면 함께 올라오는 문제 해결을 위해
                // 키보드가 없을 때만 나타나도록 구현
                if isKeyboardShown == false {
                    MadiiTabBar(tabIndex: $tabIndex)
                }
            }
            .onAppear {
                checkIsKeyboardShown()
            }
        }
    }

    func checkIsKeyboardShown() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { _ in
            isKeyboardShown = true
        }

        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
            isKeyboardShown = false
        }
    }
}

#Preview {
    MadiiTabView()
}
