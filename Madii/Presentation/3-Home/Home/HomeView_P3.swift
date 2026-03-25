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
    @State var album: Album = Album(id: 0, title: "")
    @State var isOhadol: Bool = false
    @State var canOhadol: Bool = false
    @State var showTodayJoyOptionBottomSheet: Bool = false
    @State var showSaveAlbumBottomSheet: Bool = false
    @State var showAddNewAlbumBottomSheet: Bool = false
    @State var isDeleted: Bool = false
    @State private var isFinishedGetJoy: Bool = false
    @State private var isSuccessEditJoy: Bool = false
    @State private var counter: Int = 0
    @State private var showTooLongToast: Bool = false
    @State private var keyboardHeight: CGFloat = 0
    @State private var showSavedToast: Bool = false
    
    init(viewModel: HomeViewModel_P3) {
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                MadiiHomeNavigation {
                    viewModel.action(.showAlbumList)
                    AnalyticsManager.shared.logEvent(name: "소확행 앨범 진입")
                }
                .padding(.bottom, 12)
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 0) {
                        if isFinishedGetJoy {
                            if viewModel.todayJoy.joyId == todayJoyId {
                                todayJoyCard
                                    .transition(.move(edge: .bottom).combined(with: .opacity))
                            } else {
                                todayJoyPlaceholder
                                    .transition(.move(edge: .top).combined(with: .opacity))
                            }
                            ParticleView(counter: $counter)
                        }
                        
                        if !isOhadol && canOhadol {
                            Button {
                                router.push(.dailyReview(todayJoys: viewModel.finishedJoys, visibleJoys: Array(repeating: false, count: viewModel.finishedJoys.count), date: viewModel.selectedDate))
                            } label: {
                                Text("\(viewModel.selectedDate < Date() && !viewModel.selectedDate.isSameDay(as: Date()) ? "" : "오늘 ")하루 돌아보기")
                                    .madiiFont(.subTitle)
                                    .foregroundStyle(.madiiContrast)
                                    .padding(.vertical, 16)
                                    .frame(maxWidth: .infinity)
                                    .background(.madiiGreen100)
                                    .cornerRadius(20)
                            }
                            .padding(.bottom, 16)
                            .transition(.move(edge: .top).combined(with: .opacity))
                        }
                        
                        HomeCalendar(
                            isMonthly: $viewModel.isMonthly,
                            joys: $viewModel.playListJoys,
                            selectedDate: $viewModel.selectedDate,
                            isSuccessEditJoy: $isSuccessEditJoy,
                            isOhadol: $isOhadol,
                            finishedJoys: $viewModel.finishedJoys,
                            canOhadol: $canOhadol,
                            isDeleted: $isDeleted,
                            showTooLongToast: $showTooLongToast,
                            keyboardHeight: $keyboardHeight
                        )
                    }
                    .padding(.horizontal, 20)
                    .offset(y: -keyboardHeight)
                    .animation(.easeOut(duration: 0.25), value: keyboardHeight)
                }
                .scrollIndicators(.hidden)
            }
            
            if viewModel.isPlayJoy {
                MadiiDesignSystem.MadiiToast(title: "오늘의 플레이리스트에 추가되었어요", isShowToast: $viewModel.isPlayJoy)
                    .padding(.bottom, 100)
            }
            
            if viewModel.isDuplicated {
                MadiiDesignSystem.MadiiToast(type: .error, title: "이미 추가된 소확행이에요", isShowToast: $viewModel.isDuplicated)
                    .padding(.bottom, 100)
            }
            
            if isDeleted {
                MadiiDesignSystem.MadiiToast(title: "행복 기록이 삭제되었어요", isShowToast: $isDeleted)
                    .padding(.bottom, 100)
            }
            
            if isSuccessEditJoy {
                MadiiDesignSystem.MadiiToast(title: "행복이 수정되었어요", isShowToast: $isSuccessEditJoy)
                    .padding(.bottom, 100)
            }
            
            if showTooLongToast {
                MadiiDesignSystem.MadiiToast(type: .error, title: "행복은 최대 30글자까지 입력할 수 있어요", isShowToast: $showTooLongToast)
                    .padding(.bottom, 100)
            }
            
            if showSavedToast {
                MadiiDesignSystem.MadiiToast(title: "행복이 앨범에 저장되었어요", isShowToast: $showSavedToast)
            }
        }
        .onAppear {
            getUserNickname()
            getTodayJoy()
            AnalyticsManager.shared.logEvent(name: "홈화면 진입")
        }
        .animation(.easeInOut, value: viewModel.isMonthly)
        .opacity(showTodayJoyOptionBottomSheet || showSaveAlbumBottomSheet ? 0.8 : 1)
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
                ), joyTitle: $viewModel.todayJoy.title, showSavedToast: $showSavedToast)
                    .presentationDetents([.height(608 + geo.safeAreaInsets.bottom)])
                    .presentationDragIndicator(.hidden)
                    .presentationBackground(.clear)
            }
        }
        .onChange(of: viewModel.isPlayJoy) {
            viewModel.action(.loadTodayJoy)
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
                        .madiiFont(.caption)
                        .foregroundStyle(.madiiGreen100)
                        .padding(.vertical, 4.5)
                }
                .padding(.horizontal, 8)
                .background(.madiiGreen10)
                .cornerRadius(90)
                
                Text(viewModel.todayJoy.title)
                    .madiiFont(.body2)
                    .foregroundStyle(.madiiGray100)
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
                .frame(maxWidth: .infinity)
                .frame(height: 260)
                .cornerRadius(40)
            
            VStack(spacing: 6) {
                Image("todayClover")
                    .resizable()
                    .frame(width: 141, height: 155)
                
                Button {
                    withAnimation(.easeInOut(duration: 0.4)) {
                        viewModel.action(.loadTodayJoy)
                        counter += 1
                        AnalyticsManager.shared.logEvent(name: "오늘의 소확행 선물 클릭")
                    }
                } label: {
                    Text("클릭해 보세요!")
                        .madiiFont(.subTitle)
                        .foregroundStyle(.madiiStrong)
                        .frame(width: UIScreen.main.bounds.width - 80)
                        .frame(height: 27)
                        .padding(.vertical, 16)
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
    
    private func playJoy() {
        AchievementsAPI.shared.playJoy(joyId: viewModel.todayJoy.joyId ?? 0) { isSuccess, isDuplicate in
            if isSuccess {
                print("DEBUG playJoy success")
                if isDuplicate {
                    print("DEBUG playJoy duplicate")
                    self.viewModel.isDuplicated = true
                } else {
                    if viewModel.selectedDate.isSameDay(as: Date()) {
                        self.viewModel.getJoy()
                    }
                    self.viewModel.isPlayJoy = true
                }
            } else {
                print("debug playJoy: isSuccess false")
                self.viewModel.isDuplicated = true
            }
        }
    }
}
