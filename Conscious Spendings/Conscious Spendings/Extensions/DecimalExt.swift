//
//  DecimalExt.swift
//  Conscious Spendings
//
//  Created by Egor Yanukovich on 29.06.23.
//

import Foundation

extension Decimal {
  var formattedAmount: String? {
    let formatter = NumberFormatter()
    formatter.generatesDecimalNumbers = true
    formatter.minimumFractionDigits = 2
    formatter.maximumFractionDigits = 2
    return formatter.string(from: self as NSDecimalNumber)
  }
}
