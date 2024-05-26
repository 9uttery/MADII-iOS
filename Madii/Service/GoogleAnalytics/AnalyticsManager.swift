//
//  AnalyticsManager.swift
//  Madii
//
//  Created by 정태우 on 5/22/24.
//

import FirebaseAnalytics
import FirebaseAnalyticsSwift
import Foundation

final class AnalyticsManager {
    
    static let shared = AnalyticsManager()
    private init() { }
    
    func logEvent(name: String, params: [String:Any]? = nil) {
        Analytics.logEvent(name, parameters: params)
    }
    
    func setUserId(userId: String) {
        Analytics.setUserID(userId)
    }
    
    func setUserProperty(value: String?, property: String) {
        // AnalyticsEventAddPaymentInfo
        Analytics.setUserProperty(value, forName: property)
    }
}
