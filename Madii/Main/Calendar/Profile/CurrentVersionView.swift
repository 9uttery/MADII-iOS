//
//  CurrentVersionView.swift
//  Madii
//
//  Created by Anjin on 8/18/24.
//

import SwiftUI

struct CurrentVersionView: View {
    var body: some View {
        Text("현재 버전 \(getCurrentAppVersion())")
            .madiiFont(font: .madiiBody4, color: .white.opacity(0.6))
    }
    
    func getCurrentAppVersion() -> String {
        guard let info: [String: Any] = Bundle.main.infoDictionary else { return "nil-info" }
        
        let versionKey = "CFBundleShortVersionString"
        guard let version: String = info[versionKey] as? String else { return "nil-version" }
        
        let buildNumberKey = "CFBundleVersion"
        guard let buildNumber: String = info[buildNumberKey] as? String else { return "nil-build-number" }
        
        return "\(version) (\(buildNumber))"
    }
}
