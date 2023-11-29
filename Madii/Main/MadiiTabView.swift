//
//  MadiiTabView.swift
//  Madii
//
//  Created by 이안진 on 11/29/23.
//

import SwiftUI

enum TabIndex {
    case home, record, calendar
}

struct MadiiTabView: View {
    @State var tabIndex: TabIndex = .home
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if tabIndex == .home {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Text("home")
                        Spacer()
                    }
                    Spacer()
                }
//                .background(Color.green)
            } else if tabIndex == .record {
                Text("record")
            } else {
                Text("calendar")
            }
            
            HStack(spacing: 0) {
                VStack(spacing: 4) {
                    Rectangle()
                        .frame(width: 24, height: 24)
                    
                    Text("홈")
                        .madiiFont(font: .madiiBody4, color: .madiiYellowGreen)
                }
                .frame(width: 48)
                .background(Color.blue)
                .padding(.leading, 42)
                
                Spacer()
                
                VStack(spacing: 4) {
                    Rectangle()
                        .frame(width: 24, height: 24)
                    
                    Text("레코드")
                        .madiiFont(font: .madiiBody4, color: .madiiYellowGreen)
                }
                .frame(width: 48)
                .background(Color.blue)
                
                Spacer()
                
                VStack(spacing: 4) {
                    Rectangle()
                        .frame(width: 24)
                    
                    Text("캘린더")
                        .madiiFont(font: .madiiBody4, color: .madiiYellowGreen)
                }
                .frame(width: 48, height: 40)
                .background(Color.blue)
                .padding(.trailing, 42)
            }
            .padding(.vertical, 10)
            .background(Color.black)
            .cornerRadius(12, corners: [.topLeft, .topRight])
            .shadow(color: .gray800, radius: 0, y: -2)
        }
    }
}

#Preview {
    MadiiTabView()
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
