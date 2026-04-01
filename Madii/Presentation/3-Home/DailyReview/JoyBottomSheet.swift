//
//  JoyBottomSheet.swift
//  Madii
//
//  Created by 정태우 on 3/28/26.
//

import SwiftUI

struct JoyBottomSheet: View {
    @Binding var joys: [Joy]
    @State var date: Date
    
    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .frame(width: 100, height: 5)
                .foregroundStyle(.madiiContrast)
                .cornerRadius(2.5)
                .padding(.top, 16)
            
            Text(date.toKoreanString())
                .madiiFont(.title2)
                .foregroundStyle(.madiiStrong)
                .padding(.vertical, 40)
            
            ForEach(joys.indices, id: \.self) { index in
                HStack(spacing: 12) {
                    Circle()
                        .frame(width: 12, height: 12)
                        .foregroundStyle(.madiiGreen100)
                    
                    Text(joys[index].title)
                        .madiiFont(.body2)
                        .foregroundStyle(.madiiNormal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .minimumScaleFactor(1)
                        .allowsTightening(false)
                        .layoutPriority(-1)
                    
                    Spacer(minLength: 0)
                    
                    HStack(spacing: 4) {
                        ForEach(joys[index].selectedEmotions) { emotion in
                            Text(emotion.title)
                                .madiiFont(.caption)
                                .foregroundStyle(emotion.color)
                                .padding(.vertical, 4.5)
                                .padding(.horizontal, 8)
                                .background(emotion.color.opacity(0.08))
                                .cornerRadius(8)
                                .lineLimit(1)
                                .layoutPriority(1)
                        }
                    }
                    .frame(alignment: .trailing)
                    .padding(.trailing, 12)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 19)
                .padding(.leading, 26)
                .frame(height: 64)
                .background(.madiiElevated)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(
                            LinearGradient(
                                gradient: Gradient(stops: [
                                    .init(color: Color.white.opacity(0.1), location: 0.0),
                                    .init(color: Color(red: 0x3D/255, green: 0xC2/255, blue: 0xFF/255).opacity(0.1), location: 0.5),
                                    .init(color: Color.white.opacity(0.1), location: 1.0)
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1
                        )
                )
                .padding(.bottom, 12)
            }
        }
        .padding([.horizontal, .bottom], 20)
        .background(.madiiElevated)
        .cornerRadius(40)
        .padding(.horizontal, 20)
        .background(.clear)
    }
}
