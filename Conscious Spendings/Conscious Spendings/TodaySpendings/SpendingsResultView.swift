//
//  SpendingsResultView.swift
//  Conscious Spendings
//
//  Created by Egor Yanukovich on 29.06.23.
//

import SwiftUI

struct SpendingsResultView: View {

  private let spendings: Decimal
  private let isLimitExceed: Bool

  init(
    spendings: Decimal,
    isLimitExceed: Bool
  ) {
    self.spendings = spendings
    self.isLimitExceed = isLimitExceed
  }

  var body: some View {
    Circle()
      .fill(
        LinearGradient(
          gradient: Gradient(
            colors: limitBackgroundColors),
          startPoint: .top,
          endPoint: .bottom
        )
      )
      .overlay {
        Text("\(spendings.formatted()) zl")
          .font(.system(size: 40.0, weight: .bold, design: .rounded))
      }
      .padding()
      .background(
        .regularMaterial
      )
      .background(
        LinearGradient(
          gradient: Gradient(
            colors: limitBackgroundColors.reversed()),
          startPoint: .top,
          endPoint: .bottom
        )
      )
  }

  private var limitBackgroundColors: [Color] {
    let prefix = isLimitExceed ? "error" : "success"

    return [
      Color("\(prefix)GradientFirst"),
      Color("\(prefix)GradientSecond")
    ]
  }
}

struct SpendingsResultView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      SpendingsResultView(
        spendings: 80,
        isLimitExceed: true
      )
      SpendingsResultView(
        spendings: 100,
        isLimitExceed: false
      )
    }
  }
}
