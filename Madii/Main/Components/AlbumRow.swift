//
//  AlbumRow.swift
//  Madii
//
//  Created by 이안진 on 11/30/23.
//

import SwiftUI

// FIXME: 이 두개를 합칠 수 있는 방법을 찾아보자

struct AlbumRow: View {
    var hasName: Bool = false
    var name: String = ""
    let title: String
    
    var body: some View {
        HStack(spacing: 15) {
            Rectangle()
                .frame(width: 56, height: 56)
                .foregroundStyle(Color.madiiPurple)
                .cornerRadius(4)
            
            VStack(alignment: .leading, spacing: 0) {
                if hasName {
                    Text(name)
                        .madiiFont(font: .madiiBody4, color: .gray500)
                }
                
                Text(title)
                    .madiiFont(font: .madiiBody3, color: .white, withHeight: true)
            }

            Spacer()
        }
    }
}

struct AlbumRowWithRightView<Content>: View where Content: View {
    @ViewBuilder var rightView: Content
    
    var body: some View {
        HStack(spacing: 15) {
            Rectangle()
                .frame(width: 56, height: 56)
                .foregroundStyle(Color.madiiPurple)
                .cornerRadius(4)

            Text("내가 찾은 소확행들의 앨범")
                .madiiFont(font: .madiiBody3, color: .white, withHeight: true)

            Spacer()

            rightView
        }
    }
}
