//
//  DateExt.swift
//  Conscious Spendings
//
//  Created by Egor Yanukovich on 7.07.23.
//

import Foundation

enum DateFormat: String {
  /// MM/dd/yyyy
  case slashShortFormat = "MM/dd/yyyy"
  /// MM/dd/yyyy
  case dotShortFormat = "dd.MM.yyyy"
  /// MM/dd/yyyy
  case dashShortFormat = "yyyy-MM-dd"
  /// MM/dd/yyyy
  case dashWithTimeFormat = "yyyy-MM-dd HH:mm"
  /// "HH:mm"
  case hoursAndMinutesFormat = "HH:mm"
}

extension Date {

  func toString(format: DateFormat) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.dateFormat = format.rawValue
    return formatter.string(from: self)
  }

  func dateAndTimetoString(format: DateFormat = .dashWithTimeFormat) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.dateFormat = format.rawValue
    return formatter.string(from: self)
  }

  func timeIn24HourFormat() -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .none
    formatter.dateFormat = DateFormat.hoursAndMinutesFormat.rawValue
    return formatter.string(from: self)
  }

  func startOfMonth() -> Date? {
    var components = Calendar.current.dateComponents([.year,.month], from: self)
    components.day = 1
    return Calendar.current.date(from: components)
  }

  func endOfMonth() -> Date? {
    guard let startOfMonth = startOfMonth() else { return nil }
    return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth)
  }
}
