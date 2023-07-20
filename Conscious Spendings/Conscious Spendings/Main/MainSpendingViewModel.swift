//
//  MainSpendingViewModel.swift
//  Conscious Spendings
//
//  Created by Egor Yanukovich on 29.06.23.
//

import SwiftUI

final class ErrorState: ObservableObject {
  @Published var isPresented: Bool = false
  var errorWrapper: ErrorWrapper? {
    didSet {
      isPresented = errorWrapper != nil
    }
  }
}

final class ViewModel: ObservableObject {
  @Published var path: [ScreenPath] = []
  var isLimitExceed: Bool {
    spendings > limit
  }
  private(set) var spendings = Decimal()
  private var limit = Decimal(80.0)

  @discardableResult
  func setupSpending(value: String) -> ErrorWrapper? {
    guard let spendings = SpendingCalculation.saveSpending(value) else {
      return ErrorWrapper(error: AppError.invalidSpendings, guidance: "Please, check correctness of your data")
    }
    self.spendings = spendings
    return saveDailySpendingsToStorage()
  }

  private func saveDailySpendingsToStorage() -> ErrorWrapper? {
    let todaySpendings = DaySpendingModel(
      spendings: spendings,
      isLimitExceed: isLimitExceed
    )
    let currentMonthData = StorageService.fetchData(of: MonthSpendingModel.self, from: .dailySpendings)
    if var currentMonthSpendings = currentMonthData.result {
      currentMonthSpendings.appendNewSpending(todaySpendings)
      return StorageService.saveData(currentMonthSpendings, to: .dailySpendings)
    } else if let error = currentMonthData.error {
      return error
    } else {
      var monthSpendings = MonthSpendingModel()
      monthSpendings.appendNewSpending(todaySpendings)
      return StorageService.saveData(monthSpendings, to: .dailySpendings)
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
