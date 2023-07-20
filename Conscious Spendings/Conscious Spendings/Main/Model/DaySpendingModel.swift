//
//  DaySpendingModel.swift
//  Conscious Spendings
//
//  Created by Egor Yanukovich on 7.07.23.
//

import Foundation

struct MonthSpendingModel: Codable {
  private(set) var result: [String: DaySpendingModel] = [:]

  mutating func appendNewSpending(_ spending: DaySpendingModel) {
    result[spending.date.toString(format: .dotShortFormat)] = spending
  }
}

struct DaySpendingModel: Codable {
  let date: Date
  let totalSpendings: Decimal
  let isLimitExceed: Bool

  init(
    spendings: Decimal,
    isLimitExceed: Bool
  ) {
    totalSpendings = spendings
    self.isLimitExceed = isLimitExceed
    date = Date()
  }
}
