//
//  MainViewModel.swift
//  Calculator
//
//  Created by 이치훈 on 2023/05/27.
//

import RxSwift
import UIKit

class MainViewModel {
    
    var calcModel = CalcModel()
    //let updateResult = PublishSubject<CalcModel>()
    
    init() {
        
    }
    
    public func setOperandBufferDefault() {
        calcModel.operandBuffer = ""
    }
    
    public func setLogBufferDefault() {
        calcModel.logBuffer = ""
    }
    
    public func getOperandBuffer() -> String {
        return calcModel.operandBuffer
    }
    
    public func getLogBuffer() -> String {
        return calcModel.logBuffer
    }
    
    public func appendOperandBuffer(_ item: String) {
        calcModel.operandBuffer.append(item)
    }
    
    public func appendLogBuffer(_ item: String) {
        calcModel.logBuffer.append(item)
    }
    
    public func removeLastOperandBuffer() {
        calcModel.operandBuffer.removeLast()
    }
    
    public func removeLastLogBuffer() {
        calcModel.logBuffer.removeLast()
    }
    
    public func operandBufferIsEmpty() -> Bool {
        return calcModel.operandBuffer.isEmpty
    }
    
    //MARK: - Calculator Logic
    
    func calculate() -> Double {
        let operators: Set<Character> = ["+", "-", "*", "/", "%"]
        var numStack = [Double]()
        var opStack = [Character]()
        var numString = ""
        
        // 문자열을 반복하며 숫자와 연산자를 구분합니다.
        for char in calcModel.logBuffer {
            if char.isNumber || char == "." {
                numString.append(char)
            } else if operators.contains(char) {
                if let num = Double(numString) {
                    numStack.append(num)
                    numString = ""
                }
                
                // 우선순위가 높은 연산자는 먼저 처리합니다.
                while !opStack.isEmpty && higherPrecedence(opStack.last!, char) {
                    let num2 = numStack.removeLast()
                    let num1 = numStack.removeLast()
                    let op = opStack.removeLast()
                    let result = calculator(op, num1, num2)
                    numStack.append(result)
                }
                
                opStack.append(char)
            }
        }
        
        if let num = Double(numString) {
            numStack.append(num)
        }
        
        // 남은 연산자를 모두 처리합니다.
        while !opStack.isEmpty {
            let num2 = numStack.removeLast()
            let num1 = numStack.removeLast()
            let op = opStack.removeLast()
            let result = calculator(op, num1, num2)
            numStack.append(result)
        }
        
        // 계산된 결과값을 반환합니다.
        return numStack.last ?? 0
    }
    
    func higherPrecedence(_ op1: Character, _ op2: Character) -> Bool {
        return (op1 == "*" || op1 == "/" || op1 == "%") && (op2 == "+" || op2 == "-")
    }
    
    func calculator(_ op: Character, _ num1: Double, _ num2: Double) -> Double {
        switch op {
        case "+":
            return num1 + num2
        case "-":
            return num1 - num2
        case "*":
            return num1 * num2
        case "/":
            if num2 == 0 {
                return Double.nan
            } else {
                return num1 / num2
            }
        case "%":
            return num1.truncatingRemainder(dividingBy: num2)
        default:
            return Double.nan
        }
    }
    
    func MASaveCoreData() {
        Manager.shared.saveLog(logBuffer: getLogBuffer())
    }
    
}
