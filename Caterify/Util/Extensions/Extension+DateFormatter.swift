//
//  Extension+DateFormatter.swift
//  Caterify
//
//  Created by Joanda Febrian on 20/11/21.
//

import Foundation

extension DateFormatter {
    static func withFormat(_ format: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.calendar = Calendar(identifier: .gregorian)
        return formatter
    }
}

extension Date {

    func toString(withFormat format: String = "d MMM yyyy") -> String {

        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let str = dateFormatter.string(from: self)

        return str
    }
    
    func dateOnly() -> Date {
        let date = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: self)!
        return date
    }
}

extension String {
    
    func toDate(with format: String = "yyyy-MM-dd") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        return date
    }
    
}
