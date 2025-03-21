//
//  AddAlbumPopUp.swift
//  Madii
//
//  Created by 이안진 on 2/26/24.
//

import SwiftUI

struct AddAlbumPopUp: View {
    @Binding var showAddAlbumPopUp: Bool
    
    @State private var title: String = ""
    @State private var description: String = ""
    
    var getAlbums: () -> Void = { }
    
    var body: some View {
        ZStack(alignment: .center) {
            Color.black.opacity(0.8).ignoresSafeArea()
                .onTapGesture { withoutAnimation { dismiss() } }
            
            PopUp(title: "새로운 앨범",
                  leftButtonTitle: "취소", leftButtonAction: dismiss,
                  rightButtonTitle: "생성", rightButtonColor: title.isEmpty ? .gray : .white, rightButtonAction: addAlbum) {
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        VStack(alignment: .leading, spacing: 0) {
                            HStack(spacing: 4) {
                                Text("이름")
                                    .madiiFont(font: .madiiBody2, color: .white)
                                Text("*필수로 작성해야해요")
                                    .madiiFont(font: .madiiBody4, color: .gray600)
                                Spacer()
                            }
                            .padding(.horizontal, 6)
                            .padding(.vertical, 8)
                            
                            MadiiTextField(placeHolder: "앨범 이름을 적어주세요", text: $title, strokeColor: .clear, limit: 30)
                                .multilineTextAlignment(.leading)
                        }
                        
                        VStack(alignment: .leading, spacing: 0) {
                            HStack(spacing: 4) {
                                Text("설명")
                                    .madiiFont(font: .madiiBody2, color: .white)
                                Spacer()
                            }
                            .padding(.horizontal, 6)
                            .padding(.vertical, 8)
                            
                            MadiiTextField(placeHolder: "앨범에 대한 설명을 적어주세요", text: $description, strokeColor: .clear, limit: 50)
                                .multilineTextAlignment(.leading)
                        }
                    }
                }
                .scrollIndicators(.never)
                .frame(maxHeight: 240)
            }
            .padding(.horizontal, 36)
            .padding(.vertical, 36)
        }
        .onTapGesture { hideKeyboard() }
    }
    
    private func dismiss() {
        withoutAnimation {
            showAddAlbumPopUp = false
        }
    }
    
    private func addAlbum() {
        if title.isEmpty == false {
            // 임시로 적용해둔 Network 사용
            let endpoint = AlbumsAPI.postNewAlbum(name: title, description: description)
            endpoint.request { result in
                switch result {
                case .success(let data):
                    print("앨범 생성 성공")
                    getAlbums()
                    showAddAlbumPopUp = false
                case .failure(let failure):
                    print("앨범 생성 실패")
                }
            }
            
            // 이전 사용
//            RecordAPI.shared.postAlbum(name: title, description: description) { isSuccess, _ in
//                if isSuccess {
//                    print("앨범 생성 성공")
//                    getAlbums()
//                    showAddAlbumPopUp = false
//                } else {
//                    print("앨범 생성 실패")
//                }
//            }
        }
    }
}
