//
//  Date+Extension.swift
//  BankApp
//
//  Created by Mehmet Bilir on 27.06.2022.
//

import Foundation


extension Date {
 
    static var bankeyDateFormatter:DateFormatter {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "TRT")
        return formatter
    }
    
    
    
    var monthDayYearString:String {
        let dateFormatter = Date.bankeyDateFormatter
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
}
