//
//  ReportBottomSheet.swift
//  Madii
//
//  Created by 이안진 on 2/22/24.
//

import SwiftUI

struct ReportBottomSheet: View {
    let album: Album
    
    @Binding var showReportSheet: Bool
    @Binding var showReportPopUp: Bool
    var dismissAlbumDetailView: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(album.title)
                    .madiiFont(font: .madiiTitle, color: .white)
                    .padding(.horizontal, 16)
                    .padding(.top, 28)
                    .padding(.bottom, 32)
                    
                Spacer()
            }
            .background(Color.madiiOption)
            
            VStack(alignment: .leading, spacing: 0) {
                Button {
                    showReportPopUp = true
                    AnalyticsManager.shared.logEvent(name: "신고바텀시트_신고클릭")
                } label: {
                    bottomSheetRow("신고")
                }
            }
            
            Spacer()
        }
        .background(Color.madiiPopUp)
        .background(Color.madiiPopUp)
        .transparentFullScreenCover(isPresented: $showReportPopUp) {
            ReportPopUp(album: album, showReportSheet: $showReportSheet,
                        showReportPopUp: $showReportPopUp,
                        dismissAlbumDetailView: dismissAlbumDetailView) }
    }
    
    @ViewBuilder
    private func bottomSheetRow(_ title: String) -> some View {
        HStack {
            Text(title)
                .madiiFont(font: .madiiBody3, color: .white)
                Spacer()
        }
        .frame(height: 50)
        .padding(.horizontal, 16)
    }
}
