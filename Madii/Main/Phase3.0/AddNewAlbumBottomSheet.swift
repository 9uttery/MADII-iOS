//
//  AddNewAlbumBottomSheet.swift
//  Madii
//
//  Created by 정태우 on 7/21/25.
//

import MadiiDesignSystem
import SwiftUI

struct AddNewAlbumBottomSheet: View {
    @Binding var showAddNewAlbumBottomSheet: Bool
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
            .cornerRadius(12)
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
                .padding(.vertical, 4)
                .padding(.horizontal, 7)
                .scrollContentBackground(.hidden)
                .background(.madiiBox)
                .cornerRadius(12)
                .overlay(
                    Group {
                        if describe.isEmpty {
                            Text("앨범 소개글을 작성해주세요")
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
                MadiiDesignSystem.MadiiButton(title: "취소", color: .neutral) {
                    showAddNewAlbumBottomSheet = false
                }
                    .frame(width: 82)
                
                MadiiDesignSystem.MadiiButton(title: "생성", color: .mainColor) {
                    postNewAlbum()
                }
                    .disabled(title.isEmpty)
            }
        }
    }
    
    func postNewAlbum() {
        AlbumsAPI.postNewAlbum(name: title, description: describe)
            .request { result in
                switch result {
                case .success(let data):
                    print("앨범 생성 성공 \(data)")
                case .failure(let failure):
                    print("앨범 생성 실패 \(failure)")
            }
        }
    }
}

#Preview {
    AddNewAlbumBottomSheet(showAddNewAlbumBottomSheet: .constant(true), title: "안녕하세요")
}
