//
//  UIApplicationExt.swift
//  Conscious Spendings
//
//  Created by Egor Yanukovich on 29.06.23.
//

import UIKit

public extension UIApplication {
  func currentUIWindow() -> UIWindow? {
    let connectedScenes = UIApplication.shared.connectedScenes
      .filter { $0.activationState == .foregroundActive }
      .compactMap { $0 as? UIWindowScene }

    let window = connectedScenes.first?
      .windows
      .first { $0.isKeyWindow }

    return window
  }
}
