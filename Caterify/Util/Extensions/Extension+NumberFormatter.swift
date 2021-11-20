//
//  Extension+NumberFormatter.swift
//  Caterify
//
//  Created by Joanda Febrian on 20/11/21.
//

import Foundation

extension NumberFormatter {
    static func currency(with identifier: String) -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: identifier)
        return formatter
    }
}
