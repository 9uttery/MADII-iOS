//
//  RoutingView.swift
//  Madii
//
//  Created by Anjin on 8/10/25.
//

import SwiftUI

struct RoutingView: View {
    private let container: DIContainer
    @Bindable private var router: Router
    @StateObject var appStatus: AppStatus = AppStatus()
    
    init(container: DIContainer) {
        self.container = container
        self.router = container.router
    }
    
    var body: some View {
        ZStack {
            NavigationStack(path: $router.path) {
                router.rootView()
                    .onAppear { finishLoadingView() }
                    .navigationDestination(for: Route.self) { route in
                        container.makeView(route)
                            .navigationBarBackButtonHidden()
                    }
            }
            
            Color.black
                .opacity(router.fullScreenRoute == nil ? 0.0 : 0.8)
                .ignoresSafeArea()
        }
        .fullScreenCover(item: $router.fullScreenRoute) { route in
            container.makeView(route)
        }
        .environment(router)
        .environmentObject(appStatus) 
    }
    
    private func finishLoadingView() {
        // 1.5초 후에 화면 전환
        Task {
            try? await Task.sleep(for: .seconds(1.5))
            await MainActor.run {
                withAnimation {
                    router.isLoadingViewFinished = true
                }
            }
        }
    }
}
