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
        VStack {
            Rectangle()
                .frame(width: 100, height: 5)
                .foregroundStyle(.madiiContrast)
                .cornerRadius(2.5)
                .padding(.top, 16)
                .padding(.bottom, 40)
            
            VStack(alignment: .leading, spacing: 0) {
                Text("어떤 앨범인가요?")
                    .madiiFont(font: .madiiTitle, color: .white)
                    .padding(.bottom, 16)
                
                Text("앨범명을 작성해주세요")
                    .madiiFont(font: .madiiBody2, color: .madiiNeutral)
                    .lineSpacing(9.6)
                    .padding(.bottom, 4)
                
                HStack {
                    TextField("앨범명", text: $title)
                        .madiiFont(font: .madiiBody2, color: .madiiNormal)
                        .lineSpacing(9.6)
                    
                    Text("\(title.count)/30")
                        .madiiFont(font: .madiiBody2, color: .madiiAlternative)
                        .lineSpacing(9.6)
                }
                .padding(12)
                .background(.madiiGray30)
                .cornerRadius(12)
                .padding(.bottom, 12)
                
                Text("*필수로 작성해야 해요")
                    .madiiFont(font: .caption, color: .madiiNeutral)
                    .padding(.bottom, 40)
                
                Text("앨범 소개")
                    .madiiFont(font: .madiiBody2, color: .white)
                    .lineSpacing(9.6)
                    .padding(.bottom, 4)
                
                TextEditor(text: $describe)
                    .madiiFont(font: .madiiBody2, color: .madiiNormal)
                    .lineSpacing(9.6)
                    .frame(maxWidth: .infinity)
                    .frame(height: 52)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 7)
                    .scrollContentBackground(.hidden)
                    .background(.madiiGray30)
                    .cornerRadius(12)
                    .overlay(
                        Group {
                            if describe.isEmpty {
                                Text("앨범 소개글을 작성해주세요")
                                    .madiiFont(font: .madiiBody2, color: .madiiAlternative)
                                    .lineSpacing(9.6)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(12)
                                    .allowsHitTesting(false)
                            }
                        }, alignment: .topLeading
                    )
                    .overlay(
                        Group {
                            Text("\(describe.count)/30")
                                .madiiFont(font: .madiiBody2, color: .madiiAlternative)
                                .lineSpacing(9.6)
                                .padding(12)
                        }, alignment: .bottomTrailing
                    )
                    .padding(.bottom, 40)
                
                HStack(spacing: 10) {
                    MadiiDesignSystem.MadiiButton(title: "닫기", color: .neutral) {
                        showAddNewAlbumBottomSheet = false
                    }
                    .frame(width: 82)
                    
                    MadiiDesignSystem.MadiiButton(title: "만들기", color: .mainColor) {
                        postNewAlbum()
                    }
                    .disabled(title.isEmpty)
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
    
    func postNewAlbum() {
        AlbumsAPI.postNewAlbum(name: title, description: describe)
            .request { result in
                switch result {
                case .success(let data):
                    print("앨범 생성 성공 \(data)")
                    showAddNewAlbumBottomSheet = false
                case .failure(let failure):
                    print("앨범 생성 실패 \(failure)")
            }
        }
    }
}

#Preview {
    AddNewAlbumBottomSheet(showAddNewAlbumBottomSheet: .constant(true), title: "안녕하세요")
}
