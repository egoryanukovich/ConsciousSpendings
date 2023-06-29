//
//  MainSpendingView.swift
//  Conscious Spendings
//
//  Created by Egor Yanukovich on 10.06.23.
//

import SwiftUI

enum ScreenPath: String, Hashable, CaseIterable {
  case todaySpendings
}

struct MainSpendingView: View {

  @StateObject private var viewModel = ViewModel()
  @State private var score = ""
  @FocusState private var isFocused: Bool

  // MARK: - View
  var body: some View {
    let _ = Self._printChanges()
    NavigationStack(path: $viewModel.path) {
      VStack(spacing: .zero) {
        textField
          .onTapGesture {
            isFocused = true
          }
        Spacer()
      }
      .safeAreaInset(edge: .bottom) {
        saveButton
      }
      .background(
        Color.white
          .ignoresSafeArea()
          .onTapGesture {
            isFocused = false
          }
      )
      .navigationTitle("Conscious Spendings")
      .navigationDestination(for: ScreenPath.self) { path in
        switch path {
          case .todaySpendings:
            TodaySpendingsView()
              .environmentObject(viewModel)
        }
      }
    }
  }

  private var textField: some View {
    VStack(alignment: .leading, spacing: 8.0) {
      Text("Total")
        .font(.title2)
      TextField("0", text: $score)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .focused($isFocused)
        .keyboardType(.decimalPad)
      Text(
        """
        You should add one value every day.
        Please, add your total spendings for current day
        """
      )
      .font(.caption)
      .foregroundColor(.gray)
    }
    .padding(.horizontal, 24.0)
  }

  private var saveButton: some View {
    Button {
      guard !score.isEmpty else { return }
      isFocused = false
      viewModel.setupSpending(value: score)
      viewModel.path.append(.todaySpendings)
    } label: {
      Text("Save")
        .foregroundColor(.white)
        .frame(maxWidth: .infinity)
        .font(.title)
        .padding()
        .background(
          LinearGradient(
            gradient: Gradient(
              colors: [
                Color("instagramGradientFirst"),
                Color("instagramGradientSecond"),
                Color("instagramGradientThird")
              ]
            ),
            startPoint: .leading,
            endPoint: .trailing
          )
        )
        .cornerRadius(24.0)
        .foregroundColor(.black)
        .padding([.horizontal, .bottom], 24.0)
    }
  }
}

struct MainSpendingView_Previews: PreviewProvider {
  static var previews: some View {
    MainSpendingView()
  }
}
