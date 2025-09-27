//
//  OnboardingRepository.swift
//  Madii
//
//  Created by Anjin on 8/10/25.
//

import Foundation

struct OnboardingRepository {
    private let userDefaults: UserDefaultsService
    
    init(userDefaults: UserDefaultsService) {
        self.userDefaults = userDefaults
    }
    
    func hasEverOnboarded() -> Bool {
        let result = userDefaults.load(type: Bool.self, key: .hasEverOnboarded)
        switch result {
        case .success(let data):
            return data
        case .failure:
            return false
        }
    }
    
    func setOnboarded() {
        userDefaults.save(value: true, key: .hasEverOnboarded)
    }
}
