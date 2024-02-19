//
//  ConfettiContainer.swift
//  PracticeAnimation
//
//  Created by 이안진 on 12/21/23.
//

import SwiftUI

struct ConfettiContainer: View {
    @StateObject var confettiVM: ConfettiCenterVM
    @Binding var finishedAnimationCounter: Int
    @State var firstAppear = true

    var body: some View {
        ZStack {
            ForEach(0 ..< confettiVM.confettiNumber, id: \.self) { _ in
                ConfettiFrame(confettiVM: confettiVM)
            }
        }
        .onAppear {
            if firstAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + confettiVM.getAnimDuration()) {
                    self.finishedAnimationCounter += 1
                }
                firstAppear = false
            }
        }
    }
}
