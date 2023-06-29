//
//  RoundedDecimal.swift
//  Conscious Spendings
//
//  Created by Egor Yanukovich on 29.06.23.
//

import Foundation

@propertyWrapper
struct Rounded {
  private(set) var value: Decimal = 0.0
  let rule: NSDecimalNumber.RoundingMode
  let scale: Int

  var wrappedValue: Decimal {
    get { value }
    set { value = roundedDecimal(value:newValue,scale: scale, mode: rule) }
  }

  private func roundedDecimal(value:Decimal, scale: Int = 0, mode: NSDecimalNumber.RoundingMode) -> Decimal {
    var result = Decimal()
    var valueToChange = value
    NSDecimalRound(&result, &valueToChange, scale, mode)
    return result
  }
}
