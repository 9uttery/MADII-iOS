//
//  ReportAlbumBottomSheet.swift
//  Madii
//
//  Created by 정태우 on 10/12/25.
//

import SwiftUI

struct ReportAlbumBottomSheet: View {
    @State var albumTitle: String = ""
    @Binding var showReportAlbumBottomSheet: Bool
    @Binding var showReportReasonBottomSheet: Bool
    
    var body: some View {
        VStack {
            Rectangle()
                .frame(width: 100, height: 5)
                .foregroundStyle(.madiiContrast)
                .cornerRadius(2.5)
                .padding(.top, 16)
            
            Text(albumTitle)
                .madiiFont(.title1)
                .foregroundStyle(.madiiNormal)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 40)
            
            Button {
                showReportAlbumBottomSheet = false
                showReportReasonBottomSheet = true
            } label: {
                Text("신고하기")
                    .madiiFont(.body1)
                    .foregroundStyle(.madiiNormal)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.bottom, 40)
        }
        .padding(.horizontal, 20)
        .background(.madiiElevated)
        .cornerRadius(40)
        .padding(.horizontal, 20)
        .background(.clear)
    }
}
