//
//  DiaryReviewView.swift
//  Madii
//
//  Created by 정태우 on 8/14/25.
//

import SwiftUI
import MadiiDesignSystem

struct DiaryReviewView: View {
    @State var diary: String = ""
    @State var isClickedImageButton: Bool = false
    @State var selectedImage: [UIImage] = []
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("오늘의 마음을 짧게 남겨보세요")
                .madiiFont(font: .madiiSubTitle, color: .madiiNormal)
                .padding(.top, 12)
                .padding(.bottom, 4)
            
            Text("꼭 적지 않아도 괜찮아요")
                .madiiFont(font: .caption, color: .gray100.opacity(0.43))
                .padding(.bottom, 40)
            
            VStack(alignment: .trailing) {
                TextEditor(text: $diary)
                    .madiiFont(font: .madiiBody2, color: .madiiNormal)
                    .frame(height: 182)
                    .scrollContentBackground(.hidden)
                    .overlay(
                        Group {
                            if diary.isEmpty {
                                Text("오늘 마음에 남는 순간을 들려주세요")
                                    .madiiFont(font: .madiiBody2, color: .madiiAlternative)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }, alignment: .topLeading
                    )
                    .padding(.top, 20)
                    .padding(.horizontal, 18)
                    .padding(.bottom, 10)
                
                Button {
                    isClickedImageButton = true
                } label: {
                    Image("image")
                }
                .padding([.trailing, .bottom], 20)
            }
            .background(.madiiElevated)
            .cornerRadius(12)
            .padding(.bottom, 40)
            
            ScrollView(.horizontal) {
                HStack(spacing: 8) {
                    ForEach(Array(selectedImage.enumerated()), id: \.element) { index, image in
                        ZStack(alignment: .topTrailing) {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 132, height: 132)
                                .cornerRadius(20)
                            
                            Button {
                                selectedImage.remove(at: index)
                            } label: {
                                Image("closeFill")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            }
                            .offset(x: -8, y: 8)
                        }
                        .padding(.top, 5)
                    }
                }
            }
            
            Spacer()
            
            MadiiDesignSystem.MadiiButton(title: "완료", color: .violet) {
                
            }
        }
        .sheet(isPresented: $isClickedImageButton) {
            PhotoPicker(selectedImages: $selectedImage, maxSelectionLimit: 5)
        }
    }
}

#Preview {
    DiaryReviewView()
}
