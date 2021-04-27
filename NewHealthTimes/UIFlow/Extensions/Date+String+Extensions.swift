//
//  Date+String+Extensions.swift
//  NewHealthTimes
//
//  Created by Cary Zhou on 4/27/21.
//

import Foundation

/// DateFormatters are relatively expensive objects to create, so we want to statically allocate one
/// to be shared among all of its use cases
extension Formatter {
    static let dateFormatter = DateFormatter()
}

extension Date {

    // Example: Apr 27, 2021
    var monthDayYear: String {
        let formatter = Formatter.dateFormatter
        formatter.dateFormat = "MMM d, yyyy"
        return formatter.string(from: self)
    }
}

extension String {

    // Example: 2021-04-27T05:49:23+0000
    var iso8601Date: Date? {
        let formatter = Formatter.dateFormatter
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter.date(from: self)
    }
}
