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
    
    func albumListViewModel() -> AlbumListViewModel_P3 {
        return AlbumListViewModel_P3(router: router)
    }
    
    func albumDetailViewModel(albumId: Int) -> AlbumDetailViewModel_P3 {
        return AlbumDetailViewModel_P3(router: router, albumId: albumId)
    }
    
    func reviewViewModel(joys: [Joy]) -> ReviewViewModel_P3 {
        return ReviewViewModel_P3(router: router, joys: joys)
    }
    
    func archivingViewModel() -> ArchivingViewModel_P3 {
        return ArchivingViewModel_P3(router: router)
    }
}
