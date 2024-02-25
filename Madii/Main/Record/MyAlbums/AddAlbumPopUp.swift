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
                        }
                    }
                }
                .scrollIndicators(.never)
                .frame(maxHeight: 240)
            }
            .padding(.horizontal, 36)
            .padding(.vertical, 36)
        }
    }
    
    private func dismiss() {
        showAddAlbumPopUp = false
    }
    
    private func addAlbum() {
        if title.isEmpty == false {
            
        }
    }
}
