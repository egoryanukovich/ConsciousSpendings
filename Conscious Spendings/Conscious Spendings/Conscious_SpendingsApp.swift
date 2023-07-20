//
//  Conscious_SpendingsApp.swift
//  Conscious Spendings
//
//  Created by Egor Yanukovich on 9.06.23.
//

import SwiftUI

@main
struct Conscious_SpendingsApp: App {

  @StateObject private var errorState = ErrorState()

  var body: some Scene {
    WindowGroup {
      MainSpendingView()
        .environmentObject(errorState)
        .alert(errorState.errorWrapper?.guidance ?? "", isPresented: $errorState.isPresented) {
          Button("OK") {
            errorState.errorWrapper = nil
          }
        }
    }
  }
}
