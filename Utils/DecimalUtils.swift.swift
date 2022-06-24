//
//  DecimalUtils.swift.swift
//  BankApp
//
//  Created by Mehmet Bilir on 24.06.2022.
//

import Foundation

extension Decimal {
    var doubleValue:Double {
        return NSDecimalNumber(decimal: self).doubleValue
    }
}
