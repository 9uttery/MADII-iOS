//
//  SaveJoyAtAlbumPopUpView.swift
//  Madii
//
//  Created by 이안진 on 12/1/23.
//

import SwiftUI

struct Album: Identifiable {
    let id: Int
    let title: String
}

struct SaveJoyAtAlbumPopUpView: View {
    @State private var albums: [Album] = [Album(id: 1, title: "비 올 때 하기 좋은 소확행"),
                                          Album(id: 2, title: "샤브샤브 먹고 싶어")]
    @State private var selectedAlbumIds: [Int] = []

    var body: some View {
        ZStack(alignment: .top) {
            Color.black.opacity(0.8).ignoresSafeArea()

            PopUp(title: "어떤 앨범에 저장할까요?",
                  leftButtonTitle: "취소", leftButtonAction: leftA,
                  rightButtonTitle: "확인", rightButtonColor: .white, rightButtonAction: rightA) {
                
                ScrollView(.vertical) {
                    VStack(alignment: .leading, spacing: 12) {
                        // 기본 선택: 내가 찾은 소확행
                        SelectAlbumRow(title: "내가 찾은 소확행", isSelected: true)
                        
                        // 내가 가지고 있는 앨범들
                        myAlbums

                        // 새로운 앨범 추가 버튼
                        createAlbumButton
                    }
                }
                .frame(maxHeight: 180)
            }
            .padding(.horizontal, 40)
            .padding(.top, 160)
        }
    }
    
    var myAlbums: some View {
        ForEach(albums) { album in
            Button {
                if let index = selectedAlbumIds.firstIndex(of: album.id) {
                    selectedAlbumIds.remove(at: index)
                } else {
                    selectedAlbumIds.append(album.id)
                }
            } label: {
                SelectAlbumRow(title: album.title, isSelected: selectedAlbumIds.contains(album.id))
            }
        }
    }
    
    var createAlbumButton: some View {
        Button {
            // showCreateAlbumPopUp
        } label: {
            HStack {
                Image(systemName: "plus.app")
                    .frame(width: 20, height: 20)
                    .foregroundStyle(Color.gray500)

                Text("새로운 앨범")
                    .madiiFont(font: .madiiBody3, color: .gray500)
                Spacer()
            }
            .padding(.horizontal, 6)
            .padding(.vertical, 8)
            .background(Color(red: 0.21, green: 0.22, blue: 0.29))
            .cornerRadius(4)
        }
    }

    func leftA() {}
    
    func rightA() {}
}

#Preview {
    RecordView()
}
