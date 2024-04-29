//
//  Shapes.swift
//  PracticeAnimation
//
//  Created by 이안진 on 12/21/23.
//

import SwiftUI

public struct Triangle: Shape {
    public func path(in rect: CGRect) -> Path {
        
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        return path
    }
}

public struct SlimRectangle: Shape {
    public func path(in rect: CGRect) -> Path {
        
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: 4*rect.maxY/5))
        path.addLine(to: CGPoint(x: rect.maxX, y: 4*rect.maxY/5))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        return path
    }
}

public struct RoundedCross: Shape {
    public func path(in rect: CGRect) -> Path {
        
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY/3))
        path.addQuadCurve(to: CGPoint(x: rect.maxX/3, y: rect.minY), control: CGPoint(x: rect.maxX/3, y: rect.maxY/3))
        path.addLine(to: CGPoint(x: 2*rect.maxX/3, y: rect.minY))
        
        path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.maxY/3), control: CGPoint(x: 2*rect.maxX/3, y: rect.maxY/3))
        path.addLine(to: CGPoint(x: rect.maxX, y: 2*rect.maxY/3))

        path.addQuadCurve(to: CGPoint(x: 2*rect.maxX/3, y: rect.maxY), control: CGPoint(x: 2*rect.maxX/3, y: 2*rect.maxY/3))
        path.addLine(to: CGPoint(x: rect.maxX/3, y: rect.maxY))

        path.addQuadCurve(to: CGPoint(x: 2*rect.minX/3, y: 2*rect.maxY/3), control: CGPoint(x: rect.maxX/3, y: 2*rect.maxY/3))
        return path
    }
}
