//
//  Extension+Int.swift
//  Caterify
//
//  Created by Joanda Febrian on 20/11/21.
//

import Foundation

// MARK: - Price

typealias PriceInt = Int

extension PriceInt {
    
    enum dollarSign: String {
        case one = "$"
        case two = "$$"
        case three = "$$$"
    }
    
    var priceRange: dollarSign {
        switch self {
        case _ where self <= 20000:
            return .one
        case 20001...50000:
            return .two
        case _ where self > 50000:
            return .three
        default:
            return .one
        }
    }
    
    func toCurrency(_ locale: String) -> String {
        let formatter = NumberFormatter.currency(with: locale)
        return formatter.string(from: NSNumber(value: self))!
    }
    
    func toRupiah() -> String {
        let formatter = NumberFormatter.currency(with: "id_ID")
        return formatter.string(from: NSNumber(value: self))!
    }
    
}
