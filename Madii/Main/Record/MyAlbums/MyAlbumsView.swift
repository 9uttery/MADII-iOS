//
//  MyAlbumsView.swift
//  Madii
//
//  Created by 이안진 on 12/4/23.
//

import SwiftUI

struct MyAlbumsView: View {
    @State private var showAlbumSettingSheet: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(spacing: 0) {
                Text("소확행 앨범")
                    .madiiFont(font: .madiiSubTitle, color: .white)
                    
                Spacer()
                
                /*
                // 추가 버튼 삭제
                 
                Text("추가")
                    .madiiFont(font: .madiiBody5, color: .white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.madiiOption)
                    .cornerRadius(6)
                 */
            }
                
            VStack(spacing: 16) {
                ForEach(0 ... 6, id: \.self) { _ in
                    NavigationLink {
                        AlbumDetailView()
                    } label: {
                        AlbumRowWithRightView {
                            Button {
                                showAlbumSettingSheet = true
                            } label: {
                                Image(systemName: "ellipsis")
                                    .resizable()
                                    .frame(width: 20, height: 4)
                                    .foregroundStyle(Color.gray500)
                                    .padding(10)
                                    .padding(.vertical, 8)
                            }
                        }
                    }
                }
            }
        }
        .roundBackground(bottomPadding: 32)
        .sheet(isPresented: $showAlbumSettingSheet) {
            AlbumSettingBottomSheet(showAlbumSettingSheet: $showAlbumSettingSheet)
                .presentationDetents([.height(360)])
                .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    MadiiTabView()
}
