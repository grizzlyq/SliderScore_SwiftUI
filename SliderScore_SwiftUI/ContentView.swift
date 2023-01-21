//
//  ContentView.swift
//  SliderScore_SwiftUI
//
//  Created by Дмитрий on 21.01.2023.
//

import SwiftUI

struct ContentView: View {

@State private var targetValue = Int.random(in: 1...100)
@State private var currentValue = 50.0
@State private var showAlert = false

var body: some View {
    VStack {
        Spacer()
        Text("Подвиньте слайдер ближе к \(targetValue)")
        HStack {
            Text("1")
            SliderView(
                sliderValue: $currentValue,
                color: .red,
                alpha: computeScore()
            )
            Text("100")
        }
        ButtonView(
            showAlert: $showAlert,
            title: "проверь меня",
            currentScore: computeScore(),
            action: { showAlert = true }
        )
        ButtonView(title: "начать заново") {
            targetValue = Int.random(in: 1...100)
        }
        Spacer()
    }
    .padding()
}
    
    private func computeScore() -> Int {
          let difference = abs(targetValue - lround(currentValue))
          return 100 - difference
      }
           
}


struct ButtonView: View {
    @Binding var showAlert: Bool
    let title: String
    let currentScore: Int
    let action: () -> Void

    var body: some View {
        Button(title, action: action)
            .padding()
            .alert("Your Score", isPresented: $showAlert, actions: {}) {
                Text("\(currentScore)")
        }
}

    init(showAlert: Binding<Bool> = .constant(false), title: String, currentScore: Int = 0, action: @escaping () -> Void) {
        self._showAlert = showAlert
        self.title = title
        self.currentScore = currentScore
        self.action = action
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
