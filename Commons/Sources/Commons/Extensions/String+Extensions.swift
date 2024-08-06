//
//  String+Extensions.swift
//  
//
//  Created by Menaim on 06/08/2024.
//

import Foundation

public
extension String {
  func toDate(format: DateFormat = .yearMonthDay) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format.rawValue
    dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    return dateFormatter.date(from: self)
  }

  func toFormattedDateString(format: DateFormat = .yearMonthDay) -> String? {
    guard let date = self.toDate(format: format) else { return nil }
    return date.toString(format: format)
  }
}
