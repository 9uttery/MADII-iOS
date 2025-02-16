//
//  PopUpStatus.swift
//  Madii
//
//  Created by 이안진 on 12/11/23.
//

import SwiftUI

class AppStatus: ObservableObject {
    @Published var showReportToast: Bool = false /// 신고 토스트
    @Published var showAddPlaylistToast: Bool = false /// 오플리 추가 토스트
    @Published var showSaveAlbumToast: Bool = false /// 앨범 저장 토스트
    @Published var isDuplicate: Bool = false /// 오플리 중복 토스트
    @Published var showSaveJoyToast: Bool = false /// 소확행 앨범에 저장 토스트
    @Published var isNaviRecommend: Bool = false /// 소확행 추천뷰로 이동
    @Published var isNaviPlayJoy: Bool = false /// 행복을 재생해요뷰로 이동
    @Published var nickname: String = "" /// 닉네임
}
