//
//  ViewExt.swift
//  Conscious Spendings
//
//  Created by Egor Yanukovich on 29.06.23.
//

import SwiftUI
import UIKit

extension View {
  func showShareSheet(activityItems: [Any]) {
    let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
    UIApplication.shared.currentUIWindow()?.rootViewController?.present(activityVC, animated: true, completion: nil)
  }
}
