//
//  DIContainer.swift
//  Madii
//
//  Created by Anjin on 8/10/25.
//

import Foundation

final class DIContainer {
    // 화면 전환 Router
    lazy var router: Router = {
        Router(
            onboardingRepository: onboardingRepository,
            container: self
        )
    }()
    
    // MARK: - Data(Service)
    private lazy var userDefaultsService: UserDefaultsService  = UserDefaultsService()
    
    // MARK: - Data(Repository)
    private lazy var onboardingRepository: OnboardingRepository = {
        OnboardingRepository(userDefaults: userDefaultsService)
    }()
    
    // MARK: - Presentation(ViewModel)
    func homeViewModel() -> HomeViewModel_P3 {
        return HomeViewModel_P3(router: router)
    }
    
    func archivingViewModel() -> ArchivingViewModel_P3 {
        return ArchivingViewModel_P3(router: router)
    }
}
