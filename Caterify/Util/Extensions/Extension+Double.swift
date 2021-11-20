//
//  Extension+Double.swift
//  Caterify
//
//  Created by Joanda Febrian on 20/11/21.
//

import Foundation

extension Double {
    func round(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

// MARK: - Distance

typealias Distance = Double

extension Distance {
    var toMeters: String {
        if self > 999 {
            let kilometres = self/1000
            return "\(kilometres.round(to: 1))km"
        } else {
            return "\(Int(self.rounded()))m"
        }
    }
}

// MARK: - Price

typealias Price = Double

extension Price {
    
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
