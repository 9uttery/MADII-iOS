//
//  TestView.swift
//  Madii
//
//  Created by 이안진 on 1/7/24.
//

import SwiftUI

struct TestView: View {
    @State private var draggedOffset = CGSize.zero
    @State private var isActive = false

    var body: some View {
        VStack {
            HStack { Spacer() }
            Spacer()
            Text("wow")
                .onTapGesture {
                    withAnimation {
                        isActive = true
                    }
                }
            Spacer()
        }
        .background(Color.madiiSkyBlue)
        .transparentFullScreenCover(isPresented: $isActive, content: {
            VStack {
                HStack { Spacer() }
                Spacer()
                Text("haha")
                Spacer()
            }
            .background(Color.madiiPink)
            .offset(draggedOffset)
            .gesture(swipeDownToDismiss)
        })
    }

    var swipeDownToDismiss: some Gesture {
        DragGesture()
            .onChanged { gesture in
                // 아래로만 드래그 되도록 구현
                guard gesture.translation.height > 0 else { return }
                
                draggedOffset.height = gesture.translation.height
            }
            .onEnded { gesture in
                if checkIsDismissable(gesture: gesture) {
                    isActive = false
                }
                
                withAnimation {
                    draggedOffset = .zero
                }
            }
    }

    func checkIsDismissable(gesture: _ChangedGesture<DragGesture>.Value) -> Bool {
        let dismissableLocation = gesture.translation.height > 100
        let dismissableVolocity = (gesture.predictedEndLocation - gesture.location).y > 100
        return dismissableLocation || dismissableVolocity
    }
}

#Preview {
    TestView()
}
