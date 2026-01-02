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
    @State var isError: Bool = false
    @Binding var showSuccessToast: Bool
    @Binding var album: Album
    
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
                    .madiiFont(.title1)
                    .foregroundStyle(.white)
                    .padding(.bottom, 16)
                
                Text("앨범명을 작성해주세요")
                    .madiiFont(.body2)
                    .foregroundStyle(.madiiNeutral)
                    .lineSpacing(9.6)
                    .padding(.bottom, 4)
                
                HStack {
                    TextField("앨범명", text: $title)
                        .madiiFont(.body2)
                        .foregroundStyle(.madiiNormal)
                        .frame(height: 26)
                        .onChange(of: title) {
                            if title.count > 30 {
                                title = String(title.prefix(30))
                            }
                        }
                    
                    Text("\(title.count)/30")
                        .madiiFont(.body2)
                        .foregroundStyle(.madiiAlternative)
                        .lineSpacing(9.6)
                }
                .padding(12)
                .background(.madiiGray30)
                .cornerRadius(12)
                .roundedBorder(cornerRadius: 12, color: isError ? .madiiNegative : .clear)
                .padding(.bottom, 12)
                
                Text("*필수로 작성해야 해요")
                    .madiiFont(.caption)
                    .foregroundStyle(isError ? .madiiNegative : .madiiNeutral)
                    .padding(.bottom, 40)
                
                Text("앨범 소개")
                    .madiiFont(.body2)
                    .foregroundStyle(.white)
                    .lineSpacing(9.6)
                    .padding(.bottom, 4)
                
                TextEditor(text: $describe)
                    .madiiFont(.body2)
                    .foregroundStyle(.madiiNormal)
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
                                    .madiiFont(.body2)
                                    .foregroundStyle(.madiiAlternative)
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
                                .madiiFont(.body2)
                                .foregroundStyle(.madiiAlternative)
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
                        if title.isEmpty {
                            isError = true
                        } else {
                            isError = false
                            postNewAlbum()
                        }
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
        .dismissKeyboardOnTap() 
    }
    
    func postNewAlbum() {
        AlbumsAPI.postNewAlbum(name: title, description: describe)
            .request { result in
                switch result {
                case .success(let data):
                    print("앨범 생성 성공 \(data)")
                    album = Album(id: data.first?.albumId ?? 0, title: data.first?.name ?? "")
                    showSuccessToast = true
                    showAddNewAlbumBottomSheet = false
                case .failure(let failure):
                    print("앨범 생성 실패 \(failure)")
                }
            }
    }
}
