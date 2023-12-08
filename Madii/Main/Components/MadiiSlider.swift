//
//  MadiiSlider.swift
//  Madii
//
//  Created by 이안진 on 12/8/23.
//

import SwiftUI

struct MadiiSlider: View {
    @Binding var percentage: Float
    var onEnded: () -> Void
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundStyle(
                        LinearGradient(
                            stops: [
                                Gradient.Stop(color: Color.madiiYellowGreen, location: 0.00),
                                Gradient.Stop(color: .white, location: 1.00)
                            ],
                            startPoint: UnitPoint(x: 1, y: 0.5),
                            endPoint: UnitPoint(x: 0, y: 0.5)
                        )
                    )
                    .frame(height: 36)
                    .cornerRadius(100)
                
                Circle()
                    .foregroundStyle(Color.clear)
                    .frame(height: 32)
                    .overlay(Circle().stroke(Color.white, lineWidth: 3))
                    .shadow(color: .black.opacity(0.1), radius: 1.5, x: 0, y: 0)
                    .offset(x: (geometry.size.width - 32) * CGFloat(percentage / 100))
                    .gesture(DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            updatePercentage(from: value, geometry: geometry)
                        }
                        .onEnded { _ in
                            onEnded()
                        })
            }
        }
    }
    
    private func updatePercentage(from value: DragGesture.Value, geometry: GeometryProxy) {
        let changedXLocaion = value.location.x
        let sliderSize = geometry.size.width - 32
        let ratio = Float(changedXLocaion / sliderSize * 100)
        percentage = min(max(0, ratio), 100)
    }
}

#Preview {
    DailyJoyView()
}
