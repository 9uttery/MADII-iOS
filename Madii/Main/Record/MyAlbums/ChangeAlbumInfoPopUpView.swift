//
//  ChangeAlbumInfoPopUpView.swift
//  Madii
//
//  Created by 이안진 on 12/11/23.
//

import SwiftUI

struct ChangeAlbumInfoPopUpView: View {
    let album: Album
    @Binding var showChangeInfo: Bool
    @State private var title: String = ""
    @State private var description: String = ""
    
    var body: some View {
        ZStack(alignment: .center) {
            Color.black.opacity(0.8).ignoresSafeArea()
                .onTapGesture { dismissPopUp() }
            
            PopUp(title: "앨범 이름・설명 수정",
                  leftButtonTitle: "취소", leftButtonAction: dismissPopUp,
                  rightButtonTitle: "확인", rightButtonColor: title.isEmpty ? .gray : .white, rightButtonAction: changeInfo) {
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        VStack(alignment: .leading, spacing: 0) {
                            HStack(spacing: 4) {
                                Text("이름")
                                    .madiiFont(font: .madiiBody2, color: .white)
                                Text("*필수")
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
        .onAppear {
            title = album.title
            description = album.description
        }
    }
    
    private func dismissPopUp() {
        showChangeInfo = false
    }
    
    private func changeInfo() {
        if title.isEmpty == false {
            AlbumAPI.shared.editAlbumInfos(albumId: album.id, name: title, description: description) { isSuccess in
                if isSuccess {
                    print("앨범 정보 수정 성공")
                    withAnimation {
                        dismissPopUp()
                    }
                } else {
                    print("앨범 정보 수정 실패")
                }
            }
        }
    }
}
