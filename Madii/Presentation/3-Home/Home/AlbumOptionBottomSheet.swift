//
//  AlbumOptionBottomSheet.swift
//  Madii
//
//  Created by 정태우 on 9/26/25.
//

import SwiftUI

struct AlbumOptionBottomSheet: View {
    @Binding var album: Album
    @State var isOpen: Bool = false
    var body: some View {
        VStack {
            Rectangle()
                .frame(width: 100, height: 5)
                .foregroundStyle(.madiiContrast)
                .cornerRadius(2.5)
                .padding(.top, 16)
            
            VStack(alignment: .leading, spacing: 0) {
                Text(album.title)
                    .madiiFont(font: .madiiTitle, color: .madiiNormal)
                    .padding(.top, 40)
                    .padding(.bottom, 10)
                
                Text(album.description)
                    .madiiFont(font: .madiiBody3, color: .madiiAlternative)
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, 40)
                
                Button {
                    
                } label: {
                    Text("앨범 편집")
                        .madiiFont(font: .madiiBody1, color: .madiiNormal)
                }
                .padding(.bottom, 28)
                
                Button {
                    
                } label: {
                    Text("삭제하기")
                        .madiiFont(font: .madiiBody1, color: .madiiNormal)
                }
                .padding(.bottom, 28)
                
                HStack {
                    Text("전체 공개")
                        .madiiFont(font: .madiiBody1, color: .madiiNormal)
                    
                    Spacer()
                    
                    Button {
                        if !isOpen {
                            isOpen.toggle()
                        }
                    } label: {
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundStyle(isOpen ? .madiiLime : .madiiAlternative)
                    }
                }
            }
            .padding(.bottom, 40)
        }
        .padding(.horizontal, 20)
        .background(.madiiElevated)
        .cornerRadius(40)
        .padding(.horizontal, 20)
        .background(.clear)
    }
}

#Preview {
    AlbumOptionBottomSheet(album: .constant(Album(id: 0, backgroundColorNum: 1, iconNum: 1, title: "앨범이름", creator: "정태우", description: "안녕하세요 앨범이 참 이쁘네요", isPublic: false)))
}
