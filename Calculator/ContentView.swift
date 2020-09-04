//
//  ContentView.swift
//  Calculator
//
//  Created by Suneel Gunupudi on 02/09/20.
//  Copyright © 2020 Suneel. All rights reserved.
//

import SwiftUI

enum CalcaluterButton {
    case dot, zero, one, two, three, four, five, six, seven, eight, nine
    case equal, plus, minus, multiply, divide
    case ac, plusMinus, percent

    var title: String {
        switch self {
            case .zero:
                return "0"
            case .one:
                return "1"
            case .two:
                return "2"
            case .three:
                return "3"
            case .four:
                return "4"
            case .five:
                return "5"
            case .six:
                return "6"
            case .seven:
                return "7"
            case .eight:
                return "8"
            case .nine:
                return "9"
            case .dot:
                return "."
            case .equal:
                return "="
            case .plus:
                return "+"
            case .minus:
                return "-"
            case .multiply:
                return "X"
            case .divide:
                return "÷"
            case .ac:
                return "AC"
            case .plusMinus:
                return "±"
            case .percent:
                return "%"
        }
    }

    var background: Color {
        switch self {
        case .zero, .dot, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine:
            return Color(.darkGray)
        case .ac, .plusMinus, .percent, .divide:
            return Color(.lightGray)
        default:
            return .orange
        }
    }
}

//environment object
//we can treat this as global application state

class GlobalEnvirnment: ObservableObject {
    @Published var display = "11"

    func reciverInput(title: String) {
        display = title
    }
}

struct ContentView: View {
    let buttons: [[CalcaluterButton]] = [
        [.ac, .plusMinus, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .dot, .equal]
    ]

    var spacingForButton: CGFloat {
        12
    }

    @EnvironmentObject var env: GlobalEnvirnment

    var body: some View {
        ZStack (alignment: .bottom) {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack(spacing: self.spacingForButton) {

                HStack {
                    Spacer()
                    Text(env.display)
                        .font(.system(size: 64))
                        .foregroundColor(.white)
                }.padding()
                ForEach(buttons, id: \.self) { row in
                    HStack (spacing: self.spacingForButton) {
                        ForEach(row, id: \.self) { button in
                            CalculatorButtonView(button: button)
                        }
                    }
                }
            }.padding(.bottom)
        }
    }


}

//refactor the view
struct CalculatorButtonView: View {
    var spacingForButton: CGFloat {
        12
    }

    var button: CalcaluterButton
    @EnvironmentObject var env: GlobalEnvirnment

    var body: some View {
        Button(action: {
            self.env.reciverInput(title: self.button.title)
        }) {
            Text(button.title)
                .font(.system(size: 32, weight: .semibold))
                .frame(width: self.buttonWidth(button: button), height: self.buttonHeight())
                .foregroundColor(.white)
                .background(button.background)
                .cornerRadius(self.buttonHeight() / 2)
        }
    }

    private func buttonWidth(button: CalcaluterButton) -> CGFloat {
        if button == .zero {
           return ((UIScreen.main.bounds.width - 4 * spacingForButton) / 4) * 2
        }
        return (UIScreen.main.bounds.width - 5 * spacingForButton) / 4
    }

    private func buttonHeight() -> CGFloat {
        (UIScreen.main.bounds.width - 5 * spacingForButton) / 4
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(GlobalEnvirnment())
    }
}
