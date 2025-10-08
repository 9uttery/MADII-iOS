//
//  OnboardingCard_P3.swift
//  Madii
//
//  Created by Anjin on 10/8/25.
//

import SwiftUI

struct OnboardingCard_P3: View {
    let step: OnboardingStep
    
    var body: some View {
        VStack(spacing: 28) {
            Image(step.image)
                .resizable()
//                .frame(width: 240, height: 240)
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
            VStack(spacing: 8) {
                Text(step.title)
                    .madiiFont(.title2)
                    .foregroundStyle(Color.madiiNormal)
                
                Text(step.description)
                    .multilineTextAlignment(.center)
                    .madiiFont(.body3)
                    .foregroundStyle(Color.white.opacity(0.52))
                    .fixedSize()
            }
        }
        .padding(.top, 20)
        .padding(.horizontal, 24)
        .padding(.bottom, 28)
        .background(.white.opacity(0.12))
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }
}
