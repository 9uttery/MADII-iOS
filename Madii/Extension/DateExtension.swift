//
//  DateExtension.swift
//  Madii
//
//  Created by 이안진 on 12/6/23.
//

import Foundation

extension Date {
    var day: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        return dateFormatter.string(from: self)
    }
    
    var twoDigitDay: String {
        let calendar = Calendar.current
        let day = calendar.component(.day, from: self)
        return String(format: "%02d", day)
    }
    
    var month: String {
        let calendar = Calendar.current
        let month = calendar.component(.month, from: self)
        return "\(month)"
    }
    
    var twoDigitMonth: String {
        let calendar = Calendar.current
        let month = calendar.component(.month, from: self)
        return String(format: "%02d", month)
    }
    
    var year: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy" // "yyyy"는 4자리 연도를 나타내는 포맷입니다
        return dateFormatter.string(from: self)
    }
    
    func isSameDay(as date: Date) -> Bool {
        Calendar.current.isDate(self, inSameDayAs: date)
    }
    
    var serverDateFormat: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
}
