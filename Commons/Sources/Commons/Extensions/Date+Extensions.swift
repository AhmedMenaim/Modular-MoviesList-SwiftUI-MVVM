//
//  Date+Extensions.swift
//
//
//  Created by Menaim on 06/08/2024.
//

import Foundation

public
extension Date {
  func toString(format: DateFormat = .yearMonthDay) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format.rawValue
    dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    return dateFormatter.string(from: self)
  }

  func year() -> String {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.year], from: self)
    if let year = components.year {
      return "\(year)"
    } else {
      return "0000"
    }
  }
}
