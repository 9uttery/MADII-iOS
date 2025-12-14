//
//  DiaryReviewView.swift
//  Madii
//
//  Created by 정태우 on 8/14/25.
//

import MadiiDesignSystem
import SwiftUI

struct DiaryReviewView: View {
    @Environment(Router.self) var router
    @Binding var tabNum: Int
    @Binding var date: Date
    @Binding var satisfaction: Int
    @Binding var savingJoys: [Joy]
    @State var diaryContent: String = ""
    @State var isClickedImageButton: Bool = false
    @State var selectedImages: [UIImage] = []
    @State private var selectedAssetIdentifiers: [String] = []
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("오늘의 마음을 짧게 남겨보세요")
                .madiiFont(font: .madiiSubTitle, color: .madiiNormal)
                .padding(.top, 12)
                .padding(.bottom, 4)
            
            Text("꼭 기록하지 않아도 괜찮아요")
                .madiiFont(font: .caption, color: .gray100.opacity(0.43))
                .padding(.bottom, 40)
            
            VStack(alignment: .trailing) {
                TextEditor(text: $diaryContent)
                    .madiiFont(font: .madiiBody2, color: .madiiNormal)
                    .lineSpacing(9.6)
                    .frame(maxWidth: .infinity)
                    .frame(height: 182)
                    .scrollContentBackground(.hidden)
                    .overlay(
                        Group {
                            if diaryContent.isEmpty {
                                Text("오늘의 마음을 짧게 남겨보세요")
                                    .madiiFont(font: .madiiBody2, color: .madiiAlternative)
                                    .lineSpacing(25.6)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 4)
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
                    ForEach(Array(selectedImages.enumerated()), id: \.element) { index, image in
                        ZStack(alignment: .topTrailing) {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 132, height: 132)
                                .cornerRadius(20)
                            
                            Button {
                                selectedImages.remove(at: index)
                            } label: {
                                Image("closeFill")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .padding(8)
                            }
                        }
                        .padding(.top, 5)
                    }
                }
            }
            .scrollIndicators(.hidden)
            
            Spacer()
            
            MadiiDesignSystem.MadiiButton(title: "저장하기", color: .violet) {
                clickCompleteButton()
                router.push(.completeOhadol)
            }
        }
        .opacity(isClickedImageButton ? 0.8 : 1)
        .sheet(isPresented: $isClickedImageButton) {
            PhotoPicker(
                selectedImages: $selectedImages,
                maxSelectionLimit: 3
            )
        }
        .onAppear {
            UITextView.appearance().textContainerInset =
                UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        .dismissKeyboardOnTap() 
    }
    
    private func clickCompleteButton() {
        let savingJoysDTO: [SavingJoysRequestDTO] = savingJoys.map { joy in
            SavingJoysRequestDTO(
                joyId: joy.joyId ?? 0,
                emotion: joy.selectedEmotions.map { $0.title }
            )
        }
        
        DailySummaryAPI.shared.postDailySummary(date: date, satisfaction: satisfaction, diaryContent: diaryContent, savingJoys: savingJoysDTO, images: selectedImages) { isSuccess, postDailySummary in
            if isSuccess {
                
            } else {
                
            }
        }
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder),
                   to: nil, from: nil, for: nil)
    }
}

extension View {
    func dismissKeyboardOnTap() -> some View {
        self.onTapGesture {
            UIApplication.shared.endEditing()
        }
    }
}
