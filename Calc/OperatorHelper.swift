//
//  OperatorHelper.swift
//  Calc
//
//  Created by Amini on 06/08/22.
//

import Foundation
import UIKit

protocol CalcButton {
    func text() -> String
}

enum NumberValue: CalcButton {
    
    case one
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nine
    case zero
    case dot
    
    func text() -> String {
        switch self {
        case .dot:
            return "."
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
        case .zero:
            return "0"
        }
    }

}

enum FormatValue: CalcButton {
    case comma
    case closebracket
    case openbracket
    case plus
    case minus
    case mutilplie
    case percent
    case divide

    func text() -> String {
        switch self {
        case .comma:
            return ","
        case .closebracket:
            return ")"
        case .openbracket:
            return "("
        case .plus:
            return "+"
        case .minus:
            return "-"
        case .mutilplie:
            return "x"
        case .percent:
            return "%"
        case .divide:
            return "÷"

        }
    }
}

enum CleareanceValue: CalcButton {
    case clear
    case clearEnter
    case equals
    
    func text() -> String {
        switch self {
        case .clear:
            return "AC"
        case .clearEnter:
            return "CE"
        case .equals:
            return "="
        }
    }
}

enum MathOperationValue: CalcButton {
    case modulo

    case sqroot
    case cbroot
    
    case sinus
    case cosinus
    case tangen
    case asinus
    case acosinus
    case atangen
    
    case lnFunction
    case tenPowx
    case onePerX
    case plusMinus
    
    case expnen
    case logaritma
    case absolute
    case random
    case piNumber
    
    case power2
    case power3
    
    case factorial
    
    func text() -> String {
        switch self {
        case .modulo:
            return "mod"
        case .sqroot:
            return "√"
        case .cbroot:
            return "∛"
        case .sinus:
            return "sin"
        case .cosinus:
            return "cos"
        case .tangen:
            return "tan"
        case .asinus:
            return "asin"
        case .acosinus:
            return "acos"
        case .atangen:
            return "atan"
        case .lnFunction:
            return "ln"
        case .factorial:
            return "!"
        case .expnen:
            return "exp"
        case .logaritma:
            return "log"
        case .absolute:
            return "abs"
        case .random:
            return "rand"
        case .power2:
            return "x²"
        case .power3:
            return "x³"
        case .onePerX:
            return "1/x"
        case .plusMinus:
            return "±"
        case .tenPowx:
            return "10ⁿ"
        case .piNumber:
            return "π"

        }
    }
    
    func execute(number: Double) -> Double {
        switch self {
        case .modulo:
            return fmod(2, 2)
        case .sqroot:
            return sqrt(number)
        case .cbroot:
            return cbrt(number)
        case .sinus:
            return sin(number * Double.pi / 180)
        case .cosinus:
            return cos(number * Double.pi / 180)
        case .tangen:
            return tan(number * Double.pi / 180)
        case .asinus:
            return asin(number) * 180 / Double.pi
        case .acosinus:
            return acos(number) * 180 / Double.pi
        case .atangen:
            return atan(number) * 180 / Double.pi
        case .lnFunction:
            return log10(number)
        case .tenPowx:
            return pow(10, number)
        case .onePerX:
            return 1/number
        case .expnen:
            return exp(number)
        case .logaritma:
            return log(number)
        case .absolute:
            return abs(number)
        case .random:
            return 1.1
        case .power2:
            return pow(number, 2)
        case .power3:
            return pow(number, 3)
        case .factorial:
            return dofactorial(n: number)
        case .plusMinus:
            return -1.0*number
        case .piNumber:
            return Double.pi*number

        }
        
    }
    
    func dofactorial(n: Double) -> Double {
        return n == 0 ? 1 : n * dofactorial(n: n-1)
    }

}

enum FunctionalValue: CalcButton {
        
    case powery
    case xPowy
    case xPowMinus

    case yroot
        
//    case meanFunction
    
    case permutation
    case combination
    
    case modulus
    
    func text() -> String {
        switch self {
//        case .modulo:
//            return "mod"
        case .xPowy:
            return "xⁿ"
        case .xPowMinus:
            return "x⁻ⁿ"
        case .modulus:
            return "mod"
        case .yroot:
            return "ⁿ√"
        case .powery:
            return "xⁿ"
//        case .meanFunction:
//            return "mean"
        case .permutation:
            return "ₙPₖ"
        case .combination:
            return "ₙCₖ"
        }
    }
    
    func execute(number: Double, n: Double) -> Double {
        
        switch self {
        case .powery:
            return pow(number, number)
        case .xPowy:
            return pow(number, number)
        case .yroot:
            let multipleOf2 = abs(n.truncatingRemainder(dividingBy: 2)) == 1
            return number < 0 && multipleOf2 ? -pow(-number, 1/n) : pow(number, 1/n)
        case .xPowMinus:
            return pow(number, -n)
//        case .meanFunction:
//            break
        case .permutation:
            return dofactorial(n: number)/dofactorial(n: number-n)
        case .combination:
            return Double(binomial(n: Int(number), Int(n)))
        case .modulus:
            return 1.1
        }
    }
        
        func dofactorial(n: Double) -> Double {
            return n == 0 ? 1 : n * dofactorial(n: n-1)
        }
        
        func binomial(n: Int, _ k: Int) -> Int {
            precondition(k >= 0 && n >= 0)
            if (k > n) { return 0 }
            var result = 1
            for i in 0 ..< min(k, n-k) {
                result = (result * (n - i))/(i + 1)
            }
            return result
        }
}


