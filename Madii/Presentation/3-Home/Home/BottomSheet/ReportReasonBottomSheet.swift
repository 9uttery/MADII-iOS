//
//  ReportReasonBottomSheet.swift
//  Madii
//
//  Created by 정태우 on 10/12/25.
//

import MadiiDesignSystem
import SwiftUI

struct ReportReasonBottomSheet: View {
    @Binding var albumId: Int
    @Binding var showReportReasonBottomSheet: Bool
    @Binding var showReportToast: Bool
    private let options: [String] = ["부적절한 표현", "음란성", "개인정보 노출", "특정인 비방"]
    @State var selectedOption: String = ""
    @State var reportReason: String = ""
    
    var body: some View {
        VStack {
            Rectangle()
                .frame(width: 100, height: 5)
                .foregroundStyle(.madiiContrast)
                .cornerRadius(2.5)
                .padding(.top, 16)
            
            VStack(alignment: .leading, spacing: 0) {
                Text("신고 이유를 알려주세요")
                    .madiiFont(font: .madiiTitle, color: .madiiNormal)
                    .padding(.bottom, 16)
                
                ForEach(options, id: \.self) { option in
                    Button {
                        selectedOption = option
                    } label: {
                        Text(option)
                            .madiiFont(font: .madiiBody2, color: .madiiNormal)
                            .lineSpacing(9.6)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .frame(height: 26)
                            .padding(12)
                            .background(.madiiGray30)
                            .cornerRadius(12)
                            .roundedBorder(cornerRadius: 12, color: selectedOption == option ? .madiiGreen100 : Color.clear)
                    }
                    .padding(.bottom, 16)
                }
                
                MadiiDesignSystem.MadiiTextField(text: $reportReason, isPlus: true, placeholder: "기타")
                    .roundedBorder(cornerRadius: 12, color: !reportReason.isEmpty ? .madiiGreen100 : Color.clear)
            }
            .padding(.vertical, 40)
            
            HStack(spacing: 10) {
                MadiiDesignSystem.MadiiButton(title: "닫기", color: .neutral) {
                    showReportReasonBottomSheet = false
                }
                .frame(width: 82)
                
                MadiiDesignSystem.MadiiButton(title: "신고하기", color: .mainColor) {
                    reportAlbum()
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
        .onChange(of: reportReason) {
            selectedOption = reportReason
        }
    }
    
    func reportAlbum() {
        if selectedOption.isEmpty == false{
            AlbumAPI.shared.reportAlbum(albumId: albumId, contents: selectedOption) { isSuccess in
                if isSuccess {
                    print("신고 성공")
                    withoutAnimation {
                        showReportReasonBottomSheet = false
                    }
                    
                    // 신고 토스트 띄우기
                    withAnimation {
                        showReportToast = true
                    }
                } else {
                    print("신고 실패")
                }
            }
        }
    }
}
