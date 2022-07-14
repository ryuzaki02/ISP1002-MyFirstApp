//
//  CalculatorViewModel.swift
//  ISP1002-MyFirstApp
//
//  Created by Aman on 07/07/22.
//

import Foundation

protocol CalculatorProtocol {
    func reloadCollectionView()
    
    @discardableResult
    func updateInputLabel(value: String, append: Bool) -> String
}

// Enum: To differentiate sub type of Input type
//
enum ButtonType {
    case number, operation, equal, clear
}

// Enum: Input type enums to store all numbers and operations
//
enum InputType: String, CaseIterable {
    case AC = "AC"
    case plusMinus = "+/-"
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
    
    // Computed variable to return sub type of particular input type
    //
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

// View model for view controller for business logic
//
struct CalculatorViewModel {
    // Computed variable to return all input types
    var items: [InputType] {
        return InputType.allCases
    }
    
    var firstNumber: Double?
    var secondNumber: Double?
    var inputType: InputType?
    var lastAction: ButtonType?
    var operation: InputType?
    var delegate: CalculatorProtocol?
    
    // Mutating function to perform selected operation
    // Return: Double type output value
    // Argument: Checks whether single operation on first number or operation on both first and second number
    //
    mutating private func operate(singleOperation: Bool = false) -> Double {
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
        case .plusMinus:
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
    
    // Function that checks whether particular operation is single or not
    // Return : Boolean variable
    //
    private func isSingleOperation() -> Bool {
        switch operation {
        case .tenPowerX, .ln, .sin, .cos, .square, .cube, .factorial, .by, .decimal, .plusMinus:
            return true
        default:
            return false
        }
    }
    
    // Function that calculates factorial of input number
    // Return : Integer Calculated factorial value
    // Param: Integer input number
    //
    private func factorial(_ number: Int) -> Int {
        let factorialNumber = Int(number)
        if factorialNumber == 0 {
            return 1
        } else {
            return factorialNumber * factorial(factorialNumber - 1)
        }
    }
    
    // Function that removes extra trailing zeroes
    // Return: String output value to show
    // Param: Double input value to convert
    //
    private func forTrailingZero(temp: Double) -> String {
        return String(format: "%g", temp)
    }
    
    // Mutating Function that resets all current stored properties of structure
    //
    mutating private func reset() {
        self.firstNumber = nil
        self.secondNumber = nil
        self.operation = nil
        self.inputType = nil
        self.lastAction = nil
    }
    
    // Mutating Function that calculates on basis of current stored properties and user action
    // Param: inputType on which action can be performed
    //
    mutating func calculate(inputType: InputType, count: Int) {
        let currentAction = inputType.buttonType
        if inputType == .AC {
            delegate?.updateInputLabel(value: "0", append: false)
            self.reset()
            delegate?.reloadCollectionView()
            return
        } else if inputType == .equals {
            let output = self.operate()
            delegate?.updateInputLabel(value: forTrailingZero(temp: output), append: false)
            self.firstNumber = output
            delegate?.reloadCollectionView()
            return
        }
        
        if let lastAction = self.lastAction {
            if let _ = self.secondNumber {
                self.lastAction = currentAction
                if currentAction == .number, count < 15 {
                    let labelText = delegate?.updateInputLabel(value: inputType.rawValue, append: true)
                    self.secondNumber = Double(labelText ?? "") ?? 0
                    return
                } else if currentAction == .operation {
                    let output = operate()
                    delegate?.updateInputLabel(value: forTrailingZero(temp: output), append: false)
                    delegate?.reloadCollectionView()
                }
            }
            
            if lastAction == .number {
                self.lastAction = currentAction
                if currentAction == .number, count < 15 {
                    let labelText = delegate?.updateInputLabel(value: inputType.rawValue, append: true)
                    self.firstNumber = Double(labelText ?? "") ?? 0
                } else if currentAction == .operation {
                    self.operation = inputType
                    if self.isSingleOperation() {
                        self.lastAction = .number
                        let output = self.operate(singleOperation: true)
                        delegate?.updateInputLabel(value: forTrailingZero(temp: output), append: false)
                    }
                    delegate?.reloadCollectionView()
                }
            } else if lastAction == .operation {
                self.lastAction = currentAction
                if currentAction == .number {
                    let labelText = delegate?.updateInputLabel(value: inputType.rawValue, append: false)
                    self.secondNumber = Double(labelText ?? "") ?? 0
                    delegate?.reloadCollectionView()
                }
            }
        } else {
            if currentAction == .operation {
                self.lastAction = currentAction
                self.firstNumber = 0
                self.inputType = inputType
            } else if currentAction == .number {
                self.lastAction = currentAction
                let labelText = delegate?.updateInputLabel(value: inputType.rawValue, append: false)
                self.firstNumber = Double(labelText ?? "") ?? 0
            }
        }
    }
}
