//
//  CalculatorViewModel.swift
//  ISP1002-MyFirstApp
//
//  Created by Aman on 07/07/22.
//

import Foundation

enum InputType: String, CaseIterable {
    case AC = "AC"
    case PlusMinus = "+/-"
    case remainder = "%"
    case divide = "/"
    case multiply = "*"
    case minus = "-"
    case plus = "+"
    case equals = "="
    case square = "x^2"
    case root = "x^3"
    case factorial = "x!"
    case by = "1/x"
    case tenPowerX = "10^x"
    case ln = "ln"
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case decimal = "."
}

struct CalculatorViewModel {
    var items: [InputType] {
        return InputType.allCases
    }
}
