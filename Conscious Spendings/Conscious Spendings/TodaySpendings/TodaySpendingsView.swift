//
//  TodaySpendingsView.swift
//  Conscious Spendings
//
//  Created by Egor Yanukovich on 11.06.23.
//

import SwiftUI
import UIKit

struct TodaySpendingsView: View {

  @EnvironmentObject var scoreModel: ViewModel
  @State private var renderedImage: UIImage?
  @Environment(\.displayScale) var displayScale

  var body: some View {
    let _ = Self._printChanges()
    todaySpendingsView
      .navigationBarBackButtonHidden(true)
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          Button {
            scoreModel.path.removeAll(where: { $0 == .todaySpendings })
          } label: {
            Image(systemName: "chevron.backward")
            Text("Back")
          }
        }
        ToolbarItem(placement: .navigationBarTrailing) {
          Button {
            prepareRenderedImage()
            if let renderedImage {
              showShareSheet(activityItems: [renderedImage])
            }
          } label: {
            Image(systemName: "square.and.arrow.up")
          }
        }
      }
  }

  private var todaySpendingsView: some View {
    SpendingsResultView(spendings: scoreModel.spendings, isLimitExceed: scoreModel.isLimitExceed)
  }

  private func prepareRenderedImage() {
    guard renderedImage == nil else { return }
    let content = todaySpendingsView.frame(width: UIScreen.screenWidth)
    let render = ImageRenderer(
      content: content
    )
    render.scale = displayScale
    if let uiImage = render.uiImage {
      renderedImage = uiImage
    }
  }
}
