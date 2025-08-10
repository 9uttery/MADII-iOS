//
//  AddNewAlbumBottomSheet.swift
//  Madii
//
//  Created by 정태우 on 7/21/25.
//

import SwiftUI

struct AddNewAlbumBottomSheet: View {
    @State var title: String = ""
    @State var describe: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("새로운 앨범")
                .madiiFont(font: .title2, color: .white) // title2, white
                .padding(.bottom, 16)
            
            Text("이름")
                .madiiFont(font: .madiiBody2, color: .madiiNeutral) // body2, Neutral
                .padding(.bottom, 4)
            
            HStack {
                TextField("이름 입력해주세요", text: $title)
                    .madiiFont(font: .madiiBody2, color: .madiiNormal) // body2, Normal
                
                Text("\(title.count)/30")
                    .madiiFont(font: .madiiBody2, color: .madiiAlternative)
            }
            .padding(12)
            .background(.madiiBox)
            .padding(.bottom, 12)
            
            Text("*필수로 작성해야 해요")
                .madiiFont(font: .caption, color: .madiiNeutral) // cation, .Neutral
                .padding(.bottom, 40)
            
            Text("설명")
                .madiiFont(font: .madiiBody2, color: .white) // body2, Neutral
                .padding(.bottom, 4)
            
            TextEditor(text: $describe)
                .madiiFont(font: .madiiBody2, color: .madiiNormal) // body2, Normal
                .frame(maxWidth: .infinity)
                .frame(height: 52)
                .padding(12)
                .scrollContentBackground(.hidden)
                .background(.madiiBox)
                .overlay(
                    Group {
                        if describe.isEmpty {
                            Text("안녕하세요")
                                .madiiFont(font: .madiiBody2, color: .madiiAlternative) // body2, Alternative
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(12)
                                .allowsHitTesting(false)
                        }
                    }, alignment: .topLeading
                )
                .overlay(
                    Group {
                        Text("\(describe.count)/30")
                            .madiiFont(font: .madiiBody2, color: .gray400)
                            .padding(12)
                    }, alignment: .bottomTrailing
                )
                .padding(.bottom, 40)
            
            HStack(spacing: 10) {
                MadiiButton(title: "취소")
                    .frame(width: 82)
                
                MadiiButton(title: "생성")
            }
        }
    }
}

#Preview {
    AddNewAlbumBottomSheet()
}
