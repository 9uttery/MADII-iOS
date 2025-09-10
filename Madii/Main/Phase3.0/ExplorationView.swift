//
//  ExplorationView.swift
//  Madii
//
//  Created by 정태우 on 8/14/25.
//

import MadiiDesignSystem
import SwiftUI

struct ExplorationView: View {
    @State var albums: [Album] = [Album(id: 0, title: "안녕하세요"), Album(id: 0, title: "잘가세요"), Album(id: 0, title: "진짜요?"), Album(id: 0, title: "행복하세요"), Album(id: 0, title: "좋아요")]
    
    var body: some View {
        ScrollView {
            VStack {
                MadiiTabNavigation(tabTitle: "탐색")
                
                ZStack {
                    Image("recommendJoy")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    VStack(alignment: .leading) {
                        Text("취향저격 소확행")
                            .madiiFont(font: .madiiCaption, color: .madiiNormal)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 8)
                            .background(.madiiGray100.opacity(0.16))
                            .cornerRadius(90)
                            .padding(.bottom, 8)
                        
                        Text("나에게 꼭 맞는\n소확행을 찾아보세요!")
                            .madiiFont(font: .madiiSubTitle, color: .madiiGray100)
                            .padding(.bottom, 16)
                        
                        Button {
                            
                        } label: {
                            Text("나만의 소확행 찾기")
                                .madiiFont(font: .madiiSubTitle, color: .madiiStrong)
                                .padding(.vertical, 16)
                                .frame(maxWidth: .infinity)
                                .background(.gray100.opacity(0.52))
                                .cornerRadius(20)
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
                
                VStack(alignment: .leading) {
                    Text("행복을 재생해요")
                        .madiiFont(font: .madiiSubTitle, color: .madiiNormal)
                        .padding(.top, 24)
                        .padding(.leading, 16)
                        .padding(.bottom, 32)
                    
                    ForEach(albums, id: \.self) { album in
                        Button {
                            
                        } label: {
                            HStack(spacing: 12) {
                                Image("CoverA")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .cornerRadius(12)
                                
                                Text(album.title)
                                    .madiiFont(font: .madiiBody2, color: .madiiNormal)
                                
                                Spacer()
                                
                                Image("caretRight")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 20)
                    }
                    .padding(.bottom, 4)
                    
                    Button {
                        
                    } label: {
                        Text("더보기")
                            .madiiFont(font: .madiiSubTitle, color: .madiiContrast)
                            .frame(maxWidth: .infinity)
                            .padding(.top, 16)
                            .padding(.bottom, 20)
                            .background(.madiiGreen100)
                    }
                }
                .background(.madiiElevated)
                .cornerRadius(40)
                .overlay(
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(
                            LinearGradient(
                                gradient: Gradient(stops: [
                                    .init(color: Color(red: 1.0, green: 1.0, blue: 1.0).opacity(0.1), location: 0.0),   // FFFFFF
                                    .init(color: Color(red: 0.239, green: 0.761, blue: 1.0).opacity(0.1), location: 0.33), // 3DC2FF
                                    .init(color: Color(red: 0.831, green: 0.471, blue: 1.0).opacity(0.1), location: 0.66), // D478FF
                                    .init(color: Color(red: 1.0, green: 1.0, blue: 1.0).opacity(0.1), location: 1.0)
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1
                        )
                )
                .padding(.horizontal, 20)
            }
        }
    }
}

#Preview {
    ExplorationView()
}
