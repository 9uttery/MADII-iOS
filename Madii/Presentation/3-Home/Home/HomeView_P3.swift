//
//  MadiiHomeView.swift
//  Madii
//
//  Created by 정태우 on 8/7/25.
//

import MadiiDesignSystem
import SwiftUI

struct HomeView_P3: View {
    @Environment(Router.self) var router
    @EnvironmentObject var appStatus: AppStatus
    @State private var viewModel: HomeViewModel_P3
    @AppStorage("todayJoyId") var todayJoyId: Int = 0
    @State var isOhadol: Bool = false
    @State var canOhadol: Bool = false
    @State var selectedDate: Date = Date()
    @State var showTodayJoyOptionBottomSheet: Bool = false
    @State var showSaveAlbumBottomSheet: Bool = false
    @State var showAddNewAlbumBottomSheet: Bool = false
    @State var isDeleted: Bool = false
    @State private var isFinishedGetJoy: Bool = false

    init(viewModel: HomeViewModel_P3) {
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    MadiiHomeNavigation {
                        viewModel.action(.showAlbumList)
                    }
                    .padding(.bottom, 12)
                    
                    if isFinishedGetJoy {
                        if viewModel.todayJoy.joyId == todayJoyId {
                            todayJoyCard
                                .transition(.move(edge: .bottom).combined(with: .opacity))
                        } else {
                            todayJoyPlaceholder
                                .transition(.move(edge: .top).combined(with: .opacity))
                        }
                    }
                    
                    if !isOhadol && canOhadol {
                        Button {
                            router.push(.dailyReview(todayJoys: viewModel.finishedJoys, visibleJoys: Array(repeating: false, count: viewModel.finishedJoys.count), date: selectedDate))
                        } label: {
                            Text("\(selectedDate < Date() && !selectedDate.isSameDay(as: Date()) ? "" : "오늘 ")하루 돌아보기")
                                .madiiFont(font: .madiiSubTitle, color: .madiiContrast)
                                .padding(.vertical, 16)
                                .frame(maxWidth: .infinity)
                                .background(.madiiGreen100)
                                .cornerRadius(20)
                        }
                        .padding(.bottom, 16)
                    }
                    
                    HomeCalendar(isMonthly: $viewModel.isMonthly, joys: $viewModel.playListJoys, selectedDate: $selectedDate, isOhadol: $isOhadol, finishedJoys: $viewModel.finishedJoys, canOhadol: $canOhadol, isDeleted: $isDeleted)
                }
                .padding(.horizontal, 20)
            }
            .scrollIndicators(.hidden)
            
            if viewModel.isPlayJoy {
                MadiiDesignSystem.MadiiToast(title: "오늘의 플레이리스트에 추가되었어요", isShowToast: $viewModel.isPlayJoy)
                    .padding(.bottom, 100)
            }
            
            if viewModel.isDuplicated {
                MadiiDesignSystem.MadiiToast(type: .error, title: "이미 플레이리스트에 있어요", isShowToast: $viewModel.isDuplicated)
                    .padding(.bottom, 100)
            }
            
            if isDeleted {
                MadiiDesignSystem.MadiiToast(title: "행복 기록이 삭제되었어요", isShowToast: $isDeleted)
                    .padding(.bottom, 100)
            }
        }
        .onAppear {
            getUserNickname()
            getTodayJoy()
        }
        .animation(.easeInOut, value: viewModel.isMonthly)
        .sheet(isPresented: $showTodayJoyOptionBottomSheet) {
            TodayJoyOptionBottomSheet(joyId: Binding(
                get: { viewModel.todayJoy.joyId ?? 0 },   // 기본값 0 또는 적절한 값
                set: { viewModel.todayJoy.joyId = $0 }
            ), joyTitle: $viewModel.todayJoy.title, showTodayJoyOptionBottomSheet: $showTodayJoyOptionBottomSheet, showSaveAlbumBottomSheet: $showSaveAlbumBottomSheet, isDuplicated: $viewModel.isDuplicated, isPlayJoy: $viewModel.isPlayJoy)
                .presentationDetents([.height(251)])
                .presentationDragIndicator(.hidden)
                .presentationBackground(.clear)
        }
        .sheet(isPresented: $showSaveAlbumBottomSheet) {
            GeometryReader { geo in
                EditJoyBottomSheet(showEditJoyBottomSheet: $showSaveAlbumBottomSheet, joyId: Binding(
                    get: { viewModel.todayJoy.joyId ?? 0 },   // 기본값 0 또는 적절한 값
                    set: { viewModel.todayJoy.joyId = $0 }
                ), joyTitle: $viewModel.todayJoy.title, showAddNewAlbumBottomSheet: $showAddNewAlbumBottomSheet)
                    .presentationDetents([.height(608 + geo.safeAreaInsets.bottom)])
                    .presentationDragIndicator(.hidden)
                    .presentationBackground(.clear)
            }
        }
        .sheet(isPresented: $showAddNewAlbumBottomSheet) {
            AddNewAlbumBottomSheet(showAddNewAlbumBottomSheet: $showAddNewAlbumBottomSheet)
                .presentationDetents([.height(503)])
                .presentationDragIndicator(.hidden)
                .presentationBackground(.clear)
        }
    }
    
    private var todayJoyCard: some View {
        HStack(spacing: 16) {
            Image("Cover\(viewModel.todayJoy.icon % 8 + 1)")
                .resizable()
                .frame(width: 100, height: 100)
                .cornerRadius(32)
            
            VStack(alignment: .leading, spacing: 3) {
                HStack(spacing: 4) {
                    Image("home_selected")
                        .resizable()
                        .frame(width: 12.6, height: 12.36)
                    
                    Text("오늘의 소확행 선물")
                        .madiiFont(font: .caption, color: .madiiGreen100)
                        .padding(.vertical, 4.5)
                }
                .padding(.horizontal, 8)
                .background(.madiiGreen10)
                .cornerRadius(8)
                
                Text(viewModel.todayJoy.title)
                    .madiiFont(font: .madiiBody2, color: .madiiGray100)
                    .lineSpacing(9.6)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack(spacing: 8) {
                    Button {
                        viewModel.action(.playJoy)
                    } label: {
                        Image("playCircle")
                            .resizable()
                            .frame(width: 40, height: 40)
                    }
                    
                    Button {
                        showTodayJoyOptionBottomSheet = true
                    } label: {
                        Image("ellipsis")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundStyle(.madiiAlternative)
                    }
                }
            }
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 18)
        .background(.madiiElevated)
        .cornerRadius(32)
        .padding(.bottom, 24)
    }
    
    private var todayJoyPlaceholder: some View {
        
        ZStack {
            Image("todayJoy")
                .resizable()
                .scaledToFill()
                .cornerRadius(40)
                .clipped()
            
            VStack(spacing: 6) {
                Image("todayClover")
                
                Button {
                    withAnimation(.easeInOut(duration: 0.4)) {
                        viewModel.action(.loadTodayJoy)
                    }
                } label: {
                    Text("클릭해 보세요!")
                        .madiiFont(font: .madiiSubTitle, color: .madiiStrong)
                        .padding(.vertical, 16)
                        .frame(width: UIScreen.main.bounds.width - 80)
                        .background(.gray100.opacity(0.52))
                        .cornerRadius(20)
                }
            }
            .padding(20)
        }
        .padding(.bottom, 24)
    }
    
    private func getUserNickname() {
        ProfileAPI.shared.getUsersProfile { isSuccess, userProfile in
            if isSuccess {
                appStatus.nickname = userProfile.nickname
            }
        }
    }
    
    private func getTodayJoy() {
        HomeAPI.shared.getJoyToday { isSuccess, todayJoy in
            if isSuccess {
                print("DEBUG HomeTodayJoyView getTodayJoy isSuccess true, \(todayJoy)")
                viewModel.todayJoy = Joy(joyId: todayJoy.joyId, icon: todayJoy.joyIconNum, title: todayJoy.contents)
                isFinishedGetJoy = true
            } else {
                print("DEBUG HomeTodayJoyView getTodayJoy isSuccess false")
            }
        }
    }
}
