//
//  MainSpendingViewModel.swift
//  Conscious Spendings
//
//  Created by Egor Yanukovich on 29.06.23.
//

import SwiftUI

final class ViewModel: ObservableObject {
  @Published var path: [ScreenPath] = []
  var isLimitExceed: Bool {
    spendings > limit
  }
  private(set) var spendings = Decimal()
  private var limit = Decimal(80.0)

  func setupSpending(value: String) {
    spendings = SpendingCalculation.saveSpending(value) ?? Decimal()
    saveDailySpendingsToStorage()
  }

  private func saveDailySpendingsToStorage() {
    let todaySpendings = DaySpendingModel(
      spendings: spendings,
      isLimitExceed: isLimitExceed
    )
    if
      var currentMonthSpendings = StorageService.fetchData(of: MonthSpendingModel.self, from: .dailySpendings)
    {
      currentMonthSpendings.appendNewSpending(todaySpendings)
      StorageService.saveData(currentMonthSpendings, to: .dailySpendings)
    } else {
      var monthSpendings = MonthSpendingModel()
      monthSpendings.appendNewSpending(todaySpendings)
      StorageService.saveData(monthSpendings, to: .dailySpendings)
    }
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
