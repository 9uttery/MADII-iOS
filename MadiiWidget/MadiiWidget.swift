//
//  MadiiWidget.swift
//  MadiiWidget
//
//  Created by Anjin on 12/23/24.
//

import SwiftUI
import WidgetKit

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> TodayJoyEntry {
        TodayJoyEntry()
    }
    
    func getSnapshot(in context: Context, completion: @escaping (TodayJoyEntry) -> Void) {
        let entry = TodayJoyEntry()
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        let timeline = Timeline(entries: [TodayJoyEntry()], policy: .atEnd)
        completion(timeline)
    }
}

struct TodayJoyEntry: TimelineEntry {
    let date: Date = .now
    let todayJoy: String = "넷플릭스 보면서 귤까먹기"
}

struct MadiiWidgetEntryView: View {
    var entry: Provider.Entry
    
    var body: some View {
        ZStack {
            ZStack {
                Image("particle_rectangle")
                    .resizable()
                    .frame(width: 14, height: 14)
                    .position(x: 14, y: 14)
                    .colorMultiply(Color(red: 0.61, green: 0.42, blue: 1))
                
                Circle()
                    .frame(width: 6, height: 6)
                    .position(x: 32, y: 10)
                    .foregroundStyle(Color(red: 0.81, green: 0.98, blue: 0.32))
                
//                Image("particle_rectangle")
//                    .resizable()
//                    .frame(width: 14, height: 14)
//                    .rotationEffect(Angle(degrees: 100))
//                    .position(x: 110, y: 14)
//                    .colorMultiply(Color(red: 0.81, green: 0.98, blue: 0.32))
//                
//                Circle()
//                    .frame(width: 6, height: 6)
//                    .position(x: 96, y: 14)
//                    .foregroundStyle(Color(red: 1, green: 0.49, blue: 0.31))
//                
//                Circle()
//                    .frame(width: 6, height: 6)
//                    .position(x: 120, y: 30)
//                    .foregroundStyle(Color(red: 0.61, green: 0.42, blue: 1))
                
//                Image("particle_rectangle")
//                    .resizable()
//                    .frame(width: 14, height: 14)
//                    .rotationEffect(Angle(degrees: 180))
//                    .position(x: 14, y: 100)
//                    .colorMultiply(Color(red: 1, green: 0.49, blue: 0.31))
//                    .blur(radius: 1)
//                
//                Image("particle_rectangle")
//                    .resizable()
//                    .frame(width: 8, height: 20)
//                    .rotationEffect(Angle(degrees: 270))
//                    .position(x: 100, y: 110)
//                    .colorMultiply(Color(red: 0.49, green: 0.59, blue: 0.97))
//                    .blur(radius: 1)
            }
            
            VStack(spacing: 6) {
                VStack(spacing: 0) {
//                    Text("MADII가 알려주는")
//                        .font(.caption)
////                        .fontWeight(.semibold)
//                        .foregroundStyle(Color.white)
                    
                    Text("🍀 오늘의 소확행 🍀")
                        .font(.caption)
                        .fontWeight(.heavy).bold()
                        .foregroundStyle(Color.white)
                }
                
                Text(entry.todayJoy)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .bold()
                    .foregroundStyle(Color.white)
            }
            .padding(4)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background {
            LinearGradient(
            stops: [
            Gradient.Stop(color: Color(red: 0.49, green: 0.59, blue: 0.97), location: 0.00),
            Gradient.Stop(color: Color(red: 0.61, green: 0.42, blue: 1), location: 1.00),
            ],
            startPoint: UnitPoint(x: 0.5, y: 0),
            endPoint: UnitPoint(x: 0.5, y: 1)
            )
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct CurvedShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // 시작점 (왼쪽 상단 -> 왼쪽 하단)
        path.move(to: CGPoint(x: 0, y: rect.height))
        
        // 곡선 그리기 (좌->우)
        path.addQuadCurve(
            to: CGPoint(x: rect.width, y: rect.height), // 끝점 (오른쪽 하단)
            control: CGPoint(x: rect.width / 2, y: rect.height * 0.5) // 곡선 제어점
        )
        
        // 하단 선 연결 (우->좌)
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        
        // 곡선 그리기 (좌->우)
        path.addQuadCurve(
            to: CGPoint(x: 0, y: 0), // 끝점 (오른쪽 하단)
            control: CGPoint(x: rect.width / 2, y: -rect.height * 0.5) // 곡선 제어점
        )
        
        path.closeSubpath()
        return path
    }
}

struct MadiiWidget: Widget {
    let kind: String = "MadiiWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                MadiiWidgetEntryView(entry: entry)
                    .containerBackground(.black, for: .widget)
            } else {
                MadiiWidgetEntryView(entry: entry)
                    .background(Color.black)
            }
        }
        .configurationDisplayName("오늘의 소확행 🍀")
        .description("오늘의 소확행을 확인할 수 있어요")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

// 프리뷰 정의
struct MyWidgetPreviews: PreviewProvider {
    static var previews: some View {
        // 여러 위젯 크기 프리뷰
        if #available(iOS 17.0, *) {
            MadiiWidgetEntryView(entry: TodayJoyEntry())
                .containerBackground(.black, for: .widget)
                .previewContext(WidgetPreviewContext(family: .systemSmall))
        }
        
        if #available(iOS 17.0, *) {
            MadiiWidgetEntryView(entry: TodayJoyEntry())
                .containerBackground(.black, for: .widget)
                .previewContext(WidgetPreviewContext(family: .systemMedium))
        }
        
        if #available(iOS 17.0, *) {
            MadiiWidgetEntryView(entry: TodayJoyEntry())
                .containerBackground(.black, for: .widget)
                .previewContext(WidgetPreviewContext(family: .systemLarge))
        }
    }
}
