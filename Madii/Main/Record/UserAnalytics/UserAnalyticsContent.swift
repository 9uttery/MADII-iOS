//
//  UserAnalyticsContent.swift
//  Madii
//
//  Created by 이안진 on 1/22/24.
//

import SwiftUI

enum UserAnalyticsType { case recent, many, myJoy }

struct UserAnalyticsContent: Identifiable {
    let id = UUID()
    let type: UserAnalyticsType
    let title, image: String
    let imageColor: Color
}
