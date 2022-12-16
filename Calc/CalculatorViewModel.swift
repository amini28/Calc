//
//  CalculatorViewModel.swift
//  Calc
//
//  Created by Amini on 05/09/22.
//

import Combine
import Foundation

//struct DisplayResult {
//    var result: String
//    var operation: String
//}

class CalculatorViewModel {
     
    let currentResult = CurrentValueSubject<String, Never>("0")
    let currentOperation =  CurrentValueSubject<String, Never>("0")
    var subscriptions = Set<AnyCancellable>()
    
    var functionalActive = false
    var functionalValue: FunctionalValue?
    
    func execute(input: AnyPublisher<CalcButton, Never>) {
        input.sink { [unowned self] input in
            print(input.text())
            
            switch input {
            case let nn as NumberValue:
                let syntax = "\(nn.text())(\(currentResult.value))"
                if functionalActive {
                    let syntax = "\(currentResult.value)^\(nn.text())"
                    currentOperation.send(syntax)
                    guard let result = functionalValue?.execute(number: NSString(string: currentResult.value).doubleValue,
                                                                n: NSString(string:nn.text()).doubleValue) else { return }
                    sendValueResult(result: result)
                }
                doCalculationWithExpression(operation: syntax)
            case let ss as FunctionalValue:
                functionalActive.toggle()
                functionalValue = ss
            case let aa as FormatValue:
                let currentValue = NSString(string: currentOperation.value).doubleValue
                if currentValue == 0.0 {
                    currentOperation.send(aa.text())
                } else {
                    currentOperation.send(currentOperation.value + aa.text())
                }
                
                doCalculationWithExpression(operation: currentOperation.value)
                
            case let bb as CleareanceValue:
                doClearance(operation: bb)
                
            case let cc as MathOperationValue:
                let number = NSString(string: currentResult.value).doubleValue
                currentOperation.send("\(currentResult.value)")
                sendValueResult(result: cc.execute(number: number))
                
            default:
                break
            }
            
        }.store(in: &subscriptions)
    }
    
    private func doClearance(operation: CleareanceValue) {
        switch operation {
        case .clear:
            currentOperation.send("0")
            currentResult.send("0")
        case .clearEnter:
            if currentOperation.value.count > 1 {
                currentOperation.send(String(currentOperation.value.dropLast()))
                doCalculationWithExpression(operation: currentOperation.value)
            } else {
                currentOperation.send("0")
                currentResult.send("0")
            }
        case .equals:
            print("do something")
        }
    }
    private func doCalculationWithExpression(operation: String) {
        
        let lockOperations = [".", "x", "+", "-", ".", "÷"]
        
        if !lockOperations.contains(where: operation.hasSuffix(_:)) {
            var checkedWorkings = operation.replacingOccurrences(of: "%", with: "*0.01")
            checkedWorkings = checkedWorkings.replacingOccurrences(of: "x", with: "*")
            checkedWorkings = checkedWorkings.replacingOccurrences(of: "÷", with: "/")
            
            print(checkedWorkings)
            
            let expression = NSExpression(format: checkedWorkings)
            guard let result = expression.expressionValue(with: nil, context: nil) as? Double else {
                return
            }
            
            sendValueResult(result: result)
        }
    }
    
    private func doCalculationWithMath(operation: String) {
        
    }
    
    private func sendValueResult(result: Double) {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 12
        guard let value = formatter.string(from: NSNumber(value: result)) else { return }
        
        self.currentResult.send(value)
    }
}
