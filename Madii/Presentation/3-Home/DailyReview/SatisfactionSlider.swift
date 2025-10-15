//
//  SataisfactionSlider.swift
//  Madii
//
//  Created by 정태우 on 10/11/25.
//

import SwiftUI

struct SatisfactionSlider: View {
    @Binding var value: Int
    let range = 1...9
    let buttonSize: CGFloat = 20
    let trackHeight: CGFloat = 4

    var body: some View {
        let trackWidth = UIScreen.main.bounds.width - 58
        
        let midValue = Double(range.upperBound + range.lowerBound) / 2.0
        let maxMovement = (trackWidth - buttonSize) / 2
        
        let rangeLength = Double(range.upperBound - range.lowerBound)
        
        let halfRange = rangeLength / 2.0
        
        let relativeValue = Double(value) - midValue
        let ratio = relativeValue / halfRange
        let currentOffsetX = CGFloat(ratio) * maxMovement
        
        func getValue(for offsetX: CGFloat) -> Int {
            let ratio = offsetX / maxMovement
            let doubleValue = (ratio * halfRange) + midValue
            let clampedValue = min(max(Double(range.lowerBound), doubleValue.rounded()), Double(range.upperBound))
            return Int(clampedValue)
        }
        
        return VStack {
            ZStack(alignment: .center) {
                Capsule()
                    .fill(.madiiAssistive)
                    .frame(width: trackWidth, height: trackHeight)

                Rectangle()
                    .fill(Color.clear)
                    .frame(width: trackWidth, height: buttonSize)
                    .contentShape(Rectangle())
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                let newRelativeX = gesture.location.x - (trackWidth / 2)
                                let clampedX = min(max(-maxMovement, newRelativeX), maxMovement)
                                
                                value = getValue(for: clampedX)
                            }
                    )
                
                Circle()
                    .fill(.madiiGreen100)
                    .frame(width: buttonSize, height: buttonSize)
                    .offset(x: currentOffsetX)
                    .animation(.interactiveSpring(), value: value)
            }
            .frame(width: trackWidth, height: buttonSize)
        }
    }
}

#Preview {
    SatisfactionSlider(value: .constant(5))
}
