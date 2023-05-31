//
//  MainViewModel.swift
//  Calculator
//
//  Created by 이치훈 on 2023/05/27.
//

import RxSwift
import UIKit

class MainViewModel {
    typealias Output = Observable<State>
    
    var calcModel = CalcModel()
  
    //MARK: - RxSwift Logic
    
    struct Input {
        let swipeLabel = PublishSubject<Void>()
        let selectNumber = PublishSubject<(UIButton, String)>()
        let selectAC = PublishSubject<Void>()
        let selectOperator = PublishSubject<Void>()
        let selectEquals = PublishSubject<Void>()
        let selectDote = PublishSubject<Void>()
        let selectLog = PublishSubject<Void>()
    }
    
    enum State {
        case eraseNumber
        case appendBuffer
        case initBuffer
        case showResult
        case showPresent
    }
    
    func transform(input: Input) -> Output {
       
        let swipLabel = swipeLabelStream(input)
        let selectNumber = selectNumberStream(input)
        let selectAC = selectACStream(input)
        let selectOperator = selectOperatorStream(input)
        let selectEquals = selectEqualsStream(input)
        let selectDote = selectDoteStream(input)
        let selectLog = selectLogStream(input)
        
        return Observable
            .merge(swipLabel,
                   selectNumber,
                   selectAC,
                   selectOperator,
                   selectEquals,
                   selectDote,
                   selectLog)
    }
    
    func swipeLabelStream(_ input: Input) -> Output {
        input.swipeLabel
            .map { [weak self] _ -> State in
                if self?.operandBufferIsEmpty() == false {
                    self?.removeLastOperandBuffer()
                    self?.removeLastLogBuffer()
                }
                
                return .eraseNumber
            }
            .asObservable()
    }
    
    func selectNumberStream(_ input: Input) -> Output {
        input.selectNumber
            .map { [weak self] (str, item) -> State in
                if self?.isFirstNum() == true { self!.setOperandBufferDefault() }
                self?.setIsFirstNum(state: false)
                self?.appendOperandBuffer(item)
                self?.appendLogBuffer(item)
                
                return .appendBuffer
            }.asObservable()
    }
    
    func selectACStream(_ input: Input) -> Output {
        input.selectAC
            .map { [weak self] _ -> State in
                self?.setOperandBufferDefault()
                self?.setLogBufferDefault()
                self?.setIsShowResult(state: false)
                self?.setIsFirstNum(state: false)
                
                return .initBuffer
            }.asObservable()
    }
    
    func selectOperatorStream(_ input: Input) -> Output {
        input.selectOperator
            .map { [weak self] _ -> State in
                self?.setOperandBufferDefault()
                self?.setIsShowResult(state: false)
                
                return .appendBuffer
            }.asObservable()
    }
    
    func selectDoteStream(_ input: Input) -> Output {
        input.selectDote
            .map { [weak self] _ -> State in
                self?.appendOperandBuffer(".")
                self?.appendLogBuffer(".")
                
                return .appendBuffer
            }.asObservable()
    }
    
    func selectEqualsStream(_ input: Input) -> Output {
        input.selectEquals
            .map { [weak self] _ -> State in
                self?.setResultValue(value: self?.calculate() ?? 0)
                
                if self?.isShowResult() == false {
                    self?.appendLogBuffer(" = \(String(describing: self?.getResultValue() ?? 0))")
                }
                
                self?.MASaveCoreData()
                
                self?.setIsShowResult(state: true)
                
                return .showResult
            }.asObservable()
    }
    
    func selectLogStream(_ item: Input) -> Output {
        item.selectLog
            .map { _ -> State in
                    .showPresent
            }.asObservable()
    }
    
    //MARK: - DefaultOperator
    
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
    
    public func isFirstNum() -> Bool {
        return calcModel.isFirstNum
    }
    
    public func isShowResult() -> Bool {
        return calcModel.isShowResult
    }
    
    public func setIsFirstNum(state: Bool) {
        calcModel.isFirstNum = state
    }
    
    public func setIsShowResult(state: Bool) {
        calcModel.isShowResult = state
    }
    
    public func setResultValue(value: Double) {
        calcModel.resultValue = value
    }
    
    public func getResultValue() -> Double {
        return calcModel.resultValue ?? 0.0
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
