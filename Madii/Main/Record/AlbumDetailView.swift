//
//  AlbumDetailView.swift
//  Madii
//
//  Created by 이안진 on 12/5/23.
//

import SwiftUI

struct AlbumDetailView: View {
    var body: some View {
        ScrollView {
            ZStack(alignment: .top) {
                // 앨범 커버
                ZStack(alignment: .topLeading) {
                    Rectangle()
                        .foregroundStyle(Color.madiiPurple)
                        .frame(height: UIScreen.main.bounds.width)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("앨범 제목")
                            .madiiFont(font: .madiiTitle, color: .black)
                        
                        Text("구떠리님")
                            .madiiFont(font: .madiiBody4, color: .black.opacity(0.6))
                        
                        Text("이 소확행은 기분이 째질 때 츄라이해보면 좋은 소확행이에요")
                            .madiiFont(font: .madiiCaption, color: .black.opacity(0.6))
                    }
                    .padding(.top, 20)
                    .padding(.horizontal, 24)
                }
                
                VStack(spacing: 12) {
                    // 소확행 리스트
                    VStack(spacing: 12) {
                        ForEach(0 ..< 3, id: \.self) { _ in
                            HStack {
                                JoyRow(title: "샤브샤브 먹기")
                                Spacer()
                                Button {
                                    
                                } label: {
                                    Image(systemName: "ellipsis")
                                        .resizable()
                                        .frame(width: 20, height: 4)
                                        .foregroundStyle(Color.gray500)
                                        .padding(10)
                                        .padding(.vertical, 8)
                                }
                            }
                            .padding(.vertical, 8)
                        }
                    }
                    .roundBackground(bottomPadding: 32)
                    
                    // 다른 소확행 앨범 모음
                    VStack(spacing: 12) {
                        ForEach(0 ..< 4, id: \.self) { _ in
                            AlbumRow(hasName: true)
                        }
                    }
                    .roundBackground("다른 소확행 앨범 모음", bottomPadding: 32)
                }
                .padding(.horizontal, 16)
                .padding(.top, 284)
            }
            .padding(.bottom, 40)
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    AlbumDetailView()
}
