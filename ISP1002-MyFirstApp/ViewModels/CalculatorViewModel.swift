//
//  CalculatorViewModel.swift
//  ISP1002-MyFirstApp
//
//  Created by Aman on 07/07/22.
//

import Foundation

enum ButtonType {
    case number, operation, equal, clear
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
    case cube = "x^3"
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
            return .operation
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
    var lastAction: ButtonType?
    var operation: InputType?
    
    mutating func operate(singleOperation: Bool = false) -> Double {
        guard let firstNumber = firstNumber,
              let operation = operation
        else { return 0 }
        
        var secondNumber = 0.0
        if !isSingleOperation(),
           let value = self.secondNumber {
            secondNumber = value
        }
        
        var value = 0.0
        
        switch operation {
        case .AC:
            print("")
        case .PlusMinus:
            value = -firstNumber
        case .remainder:
            value = firstNumber.truncatingRemainder(dividingBy: secondNumber)
        case .divide:
            value = firstNumber / secondNumber
        case .tenPowerX:
            value = pow(10, firstNumber)
        case .ln:
            value = log(firstNumber)
        case .sin:
            value = sin(firstNumber)
        case .cos:
            value = cos(firstNumber)
        case .square:
            value = firstNumber * firstNumber
        case .cube:
            value = firstNumber * firstNumber * firstNumber
        case .factorial:
            value = Double(factorial(Int(firstNumber)))
        case .by:
            value = 1 / firstNumber
        case .multiply:
            value = firstNumber * secondNumber
        case .minus:
            value = firstNumber - secondNumber
        case .plus:
            value = firstNumber + secondNumber
        case .decimal:
            value = firstNumber
        default:
            value = 0
        }
        self.firstNumber = value
        self.secondNumber = nil
        self.operation = nil
        return value
    }
    
    func isSingleOperation() -> Bool {
        switch operation {
        case .tenPowerX, .ln, .sin, .cos, .square, .cube, .factorial, .by, .decimal:
            return true
        default:
            return false
        }
    }
    
    private func factorial(_ number: Int) -> Int {
        let factorialNumber = Int(number)
        if factorialNumber == 0 {
            return 1
        } else {
            return factorialNumber * factorial(factorialNumber - 1)
        }
    }
    
    func forTrailingZero(temp: Double) -> String {
        return String(format: "%g", temp)
    }
    
    private func rad2deg(_ number: Double) -> Double {
        return number * 180 / .pi
    }
    
    mutating func reset() {
        self.firstNumber = nil
        self.secondNumber = nil
        self.operation = nil
        self.inputType = nil
        self.lastAction = nil
    }
}
