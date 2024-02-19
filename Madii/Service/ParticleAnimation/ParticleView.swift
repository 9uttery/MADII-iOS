//
//  ConfettiView.swift
//  PracticeAnimation
//
//  Created by 이안진 on 12/21/23.
//

import SwiftUI

struct ParticleView: View {
    
    @Binding var counter: Int
    @StateObject var confettiVM = ConfettiCenterVM()
    @State var animate = 0
    @State var finishedAnimationCounter = 0
    @State var firstAppear = false
    
    var body: some View {
        ZStack {
            ForEach(finishedAnimationCounter..<animate, id: \.self) { idx in
                ConfettiContainer(
                    confettiVM: confettiVM, finishedAnimationCounter: $finishedAnimationCounter
                )
            }
        }
        .onAppear { firstAppear = true }
        .onChange(of: counter) { value in
            if firstAppear {
                for idx in 0...confettiVM.repetitions{
                    DispatchQueue.main.asyncAfter(deadline: .now() + confettiVM.repetitionInterval * Double(idx)) {
                        animate += 1
                    }
                }
            }
        }
    }
}
