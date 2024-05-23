//
//  ReportPopUp.swift
//  Madii
//
//  Created by 이안진 on 2/24/24.
//

import SwiftUI

struct ReportPopUp: View {
    @EnvironmentObject var appStatus: AppStatus
    let album: Album
    
    @Binding var showReportSheet: Bool
    @Binding var showReportPopUp: Bool
    var dismissAlbumDetailView: () -> Void
    
    private let options: [String] = ["부적절한 표현", "음란성", "개인정보 노출", "특정인 비방"]
    @State private var selectedOption: String = ""
    @State private var etc: String = ""
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.8).ignoresSafeArea()
                .onTapGesture { withoutAnimation { dismiss() } }
                    
            PopUp(title: "신고 이유를 알려주세요", leftButtonTitle: "취소", leftButtonAction: dismiss, rightButtonTitle: "확인", rightButtonColor: selectedOption.isEmpty ? .gray : .white, rightButtonAction: report) {
                VStack(alignment: .leading, spacing: 24) {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 12) {
                            ForEach(0 ..< 4, id: \.self) { index in
                                Button {
                                    if etc.isEmpty {
                                        if selectedOption == options[index] {
                                            selectedOption = ""
                                        } else {
                                            selectedOption = options[index]
                                        }
                                    }
                                    AnalyticsManager.shared.logEvent(name: "신고팝업_\(options[index])의이유클릭")
                                } label: {
                                    SelectAlbumRow(title: options[index], isSelected: options[index] == selectedOption)
                                }
                            }
                            
                            HStack(spacing: 8) {
                                Image(systemName: "plus.app")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundStyle(etc.isEmpty ? Color.gray500 : Color.white)
                                
                                TextField("기타", text: $etc)
                                    .madiiFont(font: .madiiBody3, color: .white)
                                    .multilineTextAlignment(.leading)
                                    .onChange(of: etc) { _ in
                                        selectedOption = etc
                                    }
                                
                                Spacer()
                            }
                            .padding(.horizontal, 8)
                            .padding(.vertical, 16)
                            .background(Color.madiiOption)
                            .cornerRadius(4)
                            .overlay(
                                RoundedRectangle(cornerRadius: 4)
                                    .inset(by: 0.5)
                                    .stroke(Color.madiiYellowGreen.opacity(etc.isEmpty ? 0.0 : 1.0), lineWidth: 1)
                            )
                        }
                    }
                    .scrollIndicators(.never)
                }
            }
            .frame(maxHeight: 500)
            .padding(40)
        }
    }
    
    private func dismiss() {
        showReportPopUp = false
    }
    
    private func report() {
        if selectedOption.isEmpty == false {
            AlbumAPI.shared.reportAlbum(albumId: album.id, contents: selectedOption) { isSuccess in
                if isSuccess {
                    print("신고 성공")
                    withoutAnimation {
                        showReportSheet = false
                        showReportPopUp = false
                        dismissAlbumDetailView()
                    }
                    
                    // 신고 토스트 띄우기
                    withAnimation {
                        appStatus.showReportToast = true
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        withAnimation {
                            appStatus.showReportToast = false
                        }
                    }
                } else {
                    print("신고 실패")
                }
            }
        }
    }
}
