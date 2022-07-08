//
//  CalculatorViewModel.swift
//  ISP1002-MyFirstApp
//
//  Created by Aman on 07/07/22.
//

import Foundation

enum ButtonType {
    case number, action, equal, clear
}

enum InputType: String, CaseIterable {
    case AC = "AC"
    case PlusMinus = "+/-"
    case remainder = "%"
    case divide = "/"
    case tenPowerX = "10^x"
    case ln = "ln"
    case sin = "sin"
    case cos = "cos"
    case square = "x^2"
    case root = "x^3"
    case factorial = "x!"
    case by = "1/x"
    case one = "1"
    case two = "2"
    case three = "3"
    case multiply = "*"
    case four = "4"
    case five = "5"
    case six = "6"
    case minus = "-"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case plus = "+"
    case zero = "0"
    case dZero = "00"
    case decimal = "."
    case equals = "="
    
    var buttonType: ButtonType {
        switch self {
        case .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .zero, .decimal, .dZero:
            return .number
        case .AC:
            return .clear
        case .equals:
            return .equal
        default:
            return .action
        }
    }
}

struct CalculatorViewModel {
    var items: [InputType] {
        return InputType.allCases
    }
    
    var firstNumber: Double?
    var secondNumber: Double?
    var inputType: InputType?
}
