//
//  UserDefaultsService.swift
//  Madii
//
//  Created by Anjin on 8/10/25.
//

import Foundation

struct UserDefaultsService {
    // 저장
    func save<T>(value: T, key: UserDefaultsConstants.Keys) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    // 불러오기
    func load<T>(type: T.Type, key: UserDefaultsConstants.Keys) -> Result<T, Error> {
        if let data = UserDefaults.standard.value(forKey: key.rawValue) as? T {
            return .success(data)
        } else {
            return .failure(UserDefaultsError.keyNotFound(key: key.rawValue))
        }
    }
    
    // 삭제
    func remove(key: UserDefaultsConstants.Keys) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
    
    // 전체삭제
    func removeAllUserDefaults() {
        for key in UserDefaultsConstants.Keys.allCases {
            self.save(value: key.defaultValue, key: key)
        }
    }
}
