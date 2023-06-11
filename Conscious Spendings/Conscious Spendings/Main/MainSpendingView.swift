//
//  MainSpendingView.swift
//  Conscious Spendings
//
//  Created by Egor Yanukovich on 10.06.23.
//

import SwiftUI

class ViewModel: ObservableObject {
  @Published var score = ""
//  var rbe: Decimal = Dec
  private let formatter: NumberFormatter = {
      let formatter = NumberFormatter()
      formatter.numberStyle = .decimal
      return formatter
  }()
}

struct MainSpendingView: View {

  @StateObject private var vm = ViewModel()
  @State private var score = ""
  @FocusState private var isFocused: Bool

  // MARK: - View
  var body: some View {
    let _ = Self._printChanges()

      VStack(spacing: .zero) {
        textField
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
      print("save score")
    } label: {
      Text("Save")
        .frame(maxWidth: .infinity)
        .fontWeight(.medium)
        .font(.title)
        .padding()
        .background(Color.yellow)
//        .background(LinearGradient(gradient: Gradient(colors: [Color("DarkGreen"), Color("LightGreen")]), startPoint: .leading, endPoint: .trailing))
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
