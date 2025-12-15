//
//  ServiceTerm.swift
//  Madii
//
//  Created by Anjin on 12/14/25.
//

import Foundation

enum ServiceTerm: CaseIterable {
    case termOfUse
    case privacyPolicy
    case marketing
    
    var urlString: String? {
        switch self {
        case .termOfUse:
            return "https://docs.google.com/document/d/e/2PACX-1vRFuhWLyIE43X99pvLCJfdD9FEkyWDqW34pgA6YiRvGaVyoJo48WR2EBZeTK4T9Rcq7-7m71BJUeuSF/pub"
        case .privacyPolicy:
            return "https://docs.google.com/document/d/e/2PACX-1vTUyhxvK17s7JMJFZcKgOe6JJxLXgzeBSdY16EzglDNmb2YanuaNWC2A_jPhrOXT8Z-FkqAHPFsBqiZ/pub"
        case .marketing:
            return nil
        }
    }
    
    var title: String {
        switch self {
        case .termOfUse:
            return "서비스 이용약관 동의"
        case .privacyPolicy:
            return "개인정보처리방침 동의"
        case .marketing:
            return "마케팅 수신 동의 (선택)"
        }
    }
}
