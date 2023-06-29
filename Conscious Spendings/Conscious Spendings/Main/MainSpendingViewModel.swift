//
//  MainSpendingViewModel.swift
//  Conscious Spendings
//
//  Created by Egor Yanukovich on 29.06.23.
//

import SwiftUI

final class ViewModel: ObservableObject {
  private(set) var spendings = Decimal()
  private var limit = Decimal(80.0)
  var isLimitExceed: Bool {
    spendings > limit
  }

  @Published var path: [ScreenPath] = []
  func setupSpending(value: String) {
     spendings = SpendingCalculation.saveSpending(value) ?? Decimal()
  }
}

struct SpendingCalculation {
  @Rounded(rule: .up, scale: 2)
  private static var spendings: Decimal

  private static let formatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.maximumFractionDigits = 2

    return formatter
  }()

  static func saveSpending(_ spending: String) -> Decimal? {
    guard let number = formatter.number(from: spending) else { return nil}
    spendings = number.decimalValue
    return spendings
  }
}
