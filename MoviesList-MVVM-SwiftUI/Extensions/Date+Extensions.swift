//
//  Date+Extensions.swift
//  MoviesList-MVVM-SwiftUI
//
//  Created by Menaim on 04/08/2024.
//

import Foundation

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

enum DateFormat: String {
  case yearMonthDay = "yyyy-MM-dd"
  case monthDayYear = "MM-dd-yyyy"
  case dayMonthYear = "dd-MM-yyyy"
  // Add more formats as needed
}
