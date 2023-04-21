//
//  Date+Extensions.swift
//  Space!
//
//  Created by Dave Piernick on 4/21/23.
//

import Foundation

extension Date {
    static func dateFromString(_ dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.date(from: dateString)
    }
    
    func shortFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: self)
    }
}
